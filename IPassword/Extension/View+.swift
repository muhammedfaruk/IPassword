//
//  View+.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 30.04.2023.
//

import SwiftUI

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

