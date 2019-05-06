//
//  MagicNetworkService.swift
//  MagicAPI
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation
import Alamofire

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

    func fetchCards(from set: CardSet, page: Int, completion: @escaping CardsCompletion) {
        let url = baseUrl.appendingPathComponent("/v1/cards")
        let alamofireCompletion: DataResponseCompletion<CardsResponse> = result(completion: completion,
                                                                                mapper: { $0.cards })

        AF.request(url, method: .get, parameters: [ "page": page,
                                                    "set": set.code ])
            .responseDecodable(completionHandler: alamofireCompletion)
            .resume()
    }

    func fetchAllCards(from set: CardSet, completion: @escaping CardsCompletion) {
        fetchCards(from: set, currentPage: 0, currentCards: [], completion: completion)
    }

    private func fetchCards(from set: CardSet,
                            currentPage: Int,
                            currentCards: [Card],
                            completion: @escaping CardsCompletion) {
        fetchCards(from: set, page: currentPage) { [weak self] result in
            switch result {
            case let .success(cards):
                if cards.isEmpty {
                    completion(.success(currentCards))
                    return
                }
                self?.fetchCards(from: set,
                                 currentPage: currentPage + 1,
                                 currentCards: currentCards + cards,
                                 completion: completion)
            case .failure:
                completion(result)
            }
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
