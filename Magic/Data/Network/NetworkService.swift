//
//  MagicNetworkService.swift
//  MagicAPI
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation
import Alamofire
import RxSwift

class NetworkService {
    typealias ResultCompletion<T> = (Result<T, Error>) -> Void
    typealias DataResponseCompletion<T> = (DataResponse<T>) -> Void
    let baseUrl: URL

    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    fileprivate func result<T, K: Codable>(completion: @escaping ResultCompletion<T>,
                                           mapper: @escaping (K) -> T) -> DataResponseCompletion<K> {
        return { response in
            let result = response.result.map(mapper)
            completion(result)
        }
    }
}

extension NetworkService: CardService {

    private struct CardsResponse: Codable {
        let cards: [Card]
    }
    func fetchAllCards(from set: CardSet) -> Single<[Card]> {
        return fetchCardsAllPages(from: set, from: 0).map { $0.0 }
    }

    func fetchCards(from set: CardSet, page: Int) -> Single<[Card]> {
        return Observable<[Card]>.create { [baseUrl] observer in
            let url = baseUrl.appendingPathComponent("/v1/cards")
            let params: [String: Any] =  [ "page": page,
                                           "set": set.code ]
            let request = AF.request(url, method: .get, parameters: params)

            request.responseDecodable(completionHandler: { (resp: DataResponse<CardsResponse>) in
                switch resp.result {
                case let .success(cardsResponse):
                    let cards = cardsResponse.cards
                    observer.onNext(cards)
                    observer.onCompleted()

                case let .failure(error):
                    observer.onError(error)
                }
            })
            return Disposables.create {
                request.cancel()
            }
        }.asSingle()
    }

    private func fetchCardsAllPages(from set: CardSet, from page: Int) -> Single<([Card], Int)> {
        return fetchCards(from: set, page: page)
                .map { ($0, page)}
            .flatMap {
                let cards = $0.0
                let page = $0.1

                if cards.isEmpty {
                    return .just((cards, page))
                }

                let nextPage = self.fetchCardsAllPages(from: set, from: page + 1)
                return .zip(.just($0), nextPage, resultSelector: { ($0.0 + $1.0, $1.1)})
        }
    }
}

extension NetworkService: CardSetService {
    private struct CardSetsResponse: Codable {
        let sets: [CardSet]
    }

    func fetchSets(completion: @escaping SetsCompletion) {
        let url = baseUrl.appendingPathComponent("/v1/sets")
        let alamofireCompletion: DataResponseCompletion<CardSetsResponse> = result(completion: completion,
                                                                                   mapper: { $0.sets })

        AF.request(url, method: .get)
            .responseDecodable(completionHandler: alamofireCompletion)
            .resume()
    }
}
