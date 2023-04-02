//
//  AddAccountView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import SwiftUI

struct AddAccountView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Color("back")
            
            VStack(alignment: .leading) {
                
                Text("Add Account".localized())
                    .bold()
                    .font(.title)
                    .padding(.leading, 24)
                
                VStack {
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    VStack(spacing: 24) {
                        InputView(title: "Username", input: $username, placeholder: "Please_add_your_username")
                        .padding(.horizontal)
                        InputView(title: "Password", input: $username, placeholder: "Please_add_your_username")
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                
                ScrollView {
                    ForEach(0...10, id: \.self) { _ in
                        HStack {
                            Button {
                                
                            } label: {
                                
                            }

                        }
                    }
                }
            }
            .padding(.top, 24)
            
        }
        .ignoresSafeArea()
    }
}

struct AddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountView()
    }
}
