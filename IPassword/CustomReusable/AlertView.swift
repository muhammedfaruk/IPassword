//
//  AlertView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 15.04.2023.
//

import SwiftUI

struct AlertView: View {     
    let message : String
    @Binding var isActive : Bool
    
    
    var body: some View {
        ZStack {
            
        }
        .alert(isPresented: $isActive, content: {
            Alert(title: Text("Hata!"), message: Text(message), dismissButton: .cancel(Text("Tamam"), action: {}))
        })
    }
    
}
