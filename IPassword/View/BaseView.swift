//
//  BaseView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 4.04.2023.
//

import SwiftUI
import LocalAuthentication
import GoogleMobileAds

struct BaseView: View {
    @State var interstitial: GADInterstitialAd?
    @AppStorage("isAdsShowedBefore") var isAdsShowedBefore: Bool = false
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
                        Label("Settings".localized(), systemImage: "gearshape")
                    }
                }
                ShowMessageView(showMessage: $showMessage, message: $message)
            }
            
            
        }
        .onLoad(perform: {
            requestAds()
        })
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
    
    
    private func requestAds(){
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: AdmobHelper.intersitialId, request: request) {[self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
            self.showAds()
        }
    }
    
    private func showAds(){
        
        guard !isAdsShowedBefore else {
            UserDefaults.standard.set(false, forKey: "isAdsShowedBefore")
            return
        }

        if interstitial != nil {
            
            if let root = UIApplication.shared.windows.first?.rootViewController {
                interstitial?.present(fromRootViewController: root)
                UserDefaults.standard.set(true, forKey: "isAdsShowedBefore")
            }
            
         } else {
           print("Ad wasn't ready")
         }
    }
}



struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
