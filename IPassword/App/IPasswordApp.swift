//
//  IPasswordApp.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import SwiftUI
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    
      GADMobileAds.sharedInstance().start(completionHandler: nil)
      
                      
    return true
  }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
            
}


@main
struct IPasswordApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BaseView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)            
        }
    }
}
