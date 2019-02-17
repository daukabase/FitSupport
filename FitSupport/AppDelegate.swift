//
//  AppDelegate.swift
//  FitSupport
//
//  Created by Daulet on 25.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

var uiRealm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
        })
        return true
    }

}
