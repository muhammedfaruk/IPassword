//
//  BaseView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 4.04.2023.
//

import SwiftUI
import LocalAuthentication

struct BaseView: View {
    @State private var unlocked = false
    @State private var biometricIsAvailable = true
    
    @State var showMessage: Bool = false
    @State var message: String = ""
    
    
    
    var body: some View {
        ZStack {
            
            if UserDefaults.standard.bool(forKey: "isBiometricOn") , !unlocked {
                ZStack {
                    Color("back")
                        .ignoresSafeArea()
                }
            }else {
                TabView {
                    NavigationView {
                        MainView(showMessage: $showMessage, message: $message)
                    }
                    .tabItem {
                        Label("All Records".localized(), systemImage: "list.bullet.indent")
                    }
                    
                    NavigationView {
                        SettingsView()
                    }
                    .tabItem {
                        Label("All Records".localized(), systemImage: "gear")
                    }
                }
                ShowMessageView(showMessage: $showMessage, message: $message)
            }
            
            
        }
        .onAppear(perform: {
            if UserDefaults.standard.bool(forKey: "isBiometricOn") {
                authenticate()
            }
        })
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check whether it's possible to use biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
           
            // Handle events
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is a security check reason.") { success, authenticationError in
                
                if success {
                    unlocked = true
                } else {
                    unlocked = false
                }
            }
        } else {
            biometricIsAvailable = false
        }
    }
}



struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
