//
//  InputView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import SwiftUI

struct InputView: View {
    let title: String
    @Binding var input: String
    let placeholder: String
    @State var isActive: Bool = false
    var activeColor: Color = .blue
    let keyboardType: UIKeyboardType
    var isSecureField:Bool = false
    @State var showPassword: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.labelColor)
                .bold()
                .font(.title2)
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder( activeColor, lineWidth: 1)
                    .frame(height: 50, alignment: .center)
                    .foregroundColor(.clear)
                HStack {
                    SuperTextField(
                        placeholder: Text(placeholder.localized()).foregroundColor(.gray),
                            text: $input,
                            editingChanged: { changed in
                                withAnimation {
                                    isActive = changed
                                }                                
                            }, keyboardType: keyboardType, isSecureField: isSecureField, showPassword: showPassword
                        )
                    .foregroundColor(.labelColor)
                    .padding(.leading, 8)
                                       
                    if isSecureField {
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye" : "eye.slash")
                                .foregroundColor(Color.labelColor.opacity(0.6))
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(.trailing)
                        }
                    }
                }
            }
        }        
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(title: "Username", input: .constant(""), placeholder: "Please_add_your_username", keyboardType: .emailAddress)
    }
}
