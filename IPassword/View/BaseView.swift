//
//  BaseView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 4.04.2023.
//

import SwiftUI

struct BaseView: View {
    @State var showMessage: Bool = false
    @State var message: String = ""
    
    var body: some View {
        ZStack {
            TabView {
                NavigationView {
                    MainView(showMessage: $showMessage, message: $message)
                }
                .tabItem {
                    Label("All Records".localized(), image: "eye")
                }
                
                NavigationView {
                    Color.red
                }
                .tabItem {
                    Label("All Records".localized(), image: "eye")
                }
            }
            ShowMessageView(showMessage: $showMessage, message: $message)
        }
    }
}



struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
