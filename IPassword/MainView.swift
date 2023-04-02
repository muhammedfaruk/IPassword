//
//  MainView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("My_Accounts")
                .foregroundColor(.white)
                .font(.title)
                .bold()
                .padding(.leading)
            
            ScrollView {
                VStack {
                    ForEach(0...3, id: \.self) { i in
                        PassRow()
                    }
                }
            }
        }
        .padding(.top, 74)
        .background(Color("rowBack"))
        .ignoresSafeArea()
    }
}

struct PassRow: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color("back"))
            HStack(spacing: 25) {
                ZStack {
                    Circle()
                        .foregroundColor(.yellow)
                    Text("A")
                }
                .padding(.leading, 8)
                .frame(height: 50)
                
                Text("Account Name")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                Spacer()
            }
        }
        .padding(.horizontal)
        .frame(height: 60, alignment: .center)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
