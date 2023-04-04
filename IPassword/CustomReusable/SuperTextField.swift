//
//  SuperTextField.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import SwiftUI


struct SuperTextField: View {    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }    
    let keyboardType: UIKeyboardType
    var isSecureField:Bool = false    
    var showPassword: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            if isSecureField , showPassword{
                SecureField("", text: $text)
                    .textContentType(.password)
            }else {
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                    //.textContentType(keyboardType)
                    .keyboardType(keyboardType)
            }
        }
    }
}


struct SuperTextField_Previews: PreviewProvider {
    static var previews: some View {
        SuperTextField(placeholder: Text("placeholder"), text: .constant(""), keyboardType: .emailAddress)
    }
}
