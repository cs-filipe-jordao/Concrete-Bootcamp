//
//  AppDelegate.swift
//  Magic
//
//  Created by filipe.n.jordao on 29/04/19.
//  Copyright © 2019 filipe.n.jordao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.rootViewController = CardListDetailCoordinator().create(cards: [
            MagicCard(name: "", type: "", types: [], cardSet: "", imageURL: nil, identifier: ""),
            MagicCard(name: "", type: "", types: [], cardSet: "", imageURL: nil, identifier: ""),
            MagicCard(name: "", type: "", types: [], cardSet: "", imageURL: nil, identifier: ""),
            MagicCard(name: "", type: "", types: [], cardSet: "", imageURL: nil, identifier: "")])
        window?.makeKeyAndVisible()
        
        return true
    }
}
