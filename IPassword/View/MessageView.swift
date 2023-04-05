//
//  MessageView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 5.04.2023.
//

import SwiftUI

struct ShowMessageView: View  {
    @Binding var showMessage: Bool
    @Binding var message: String
    @State var timeRemaining = 0.5
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if showMessage {
            ZStack {
              Text(message)
                    .padding(.horizontal)
            }.background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color("rowGray"))
                    .frame(minWidth: 100, minHeight: 60)
            )
            .opacity(showMessage ? 1 : 0)
            .padding(.bottom, 150)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .onReceive(timer, perform: { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }else {
                    withAnimation {
                        showMessage = false
                    }
                }
            })
        }
    }
    
}
