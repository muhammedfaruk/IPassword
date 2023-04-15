//
//  SettingsView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 15.04.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isBiometricOn") var isBiomatricOn: Bool = false
    
    var body: some View {
        ZStack {
            Color("back")
                .ignoresSafeArea()
            
            List {
                
                Section {
                    
                    Toggle(isOn: $isBiomatricOn) {
                        Text("Biometric Login")
                    }
                } header: {
                    Text("Login Options")
                } footer: {
                    Text("Use Face ID to log into IPassword")
                        .font(.footnote)
                }
                .listRowBackground(Color("rowGray"))
                
                
                Section {
                    
                    
                    
                }
                
                
            }
            .listStyle(.plain)
        }
        .navigationTitle("Settings".localized())
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
