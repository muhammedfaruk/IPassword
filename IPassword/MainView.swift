//
//  MainView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @State var openSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("My_Accounts")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                
                Spacer()
                Button {
                    openSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.title)
                }

            }
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ForEach(0...3, id: \.self) { i in
                        AccountRowView()
                    }
                }
            }
        }
        .padding(.top, 74)
        .background(Color("back"))
        .ignoresSafeArea()
        .sheet(isPresented: $openSheet) {
            AddAccountView()
        }
    }
}

struct AccountRowView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color("rowBack"))
            HStack(spacing: 25) {
                ZStack {
                    Circle()
                        .foregroundColor(.yellow)
                    Text("A")
                        .bold()
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


struct AddAccountView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Color("back")
            
            VStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50, alignment: .center)
                
                VStack(spacing: 24) {
                    InputView(title: "Username", input: $username, placeholder: "Please_add_your_username")
                    .padding(.horizontal)
                    InputView(title: "Password", input: $username, placeholder: "Please_add_your_username")
                    .padding(.horizontal)
                }
                Spacer()
            }
            
        }
        .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

