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
    
    @State var circleColor: Color = .blue
    @State var circleChar: String = ""
    
    let gridItemsForAlphabet = Array(repeating: GridItem(.fixed(45)), count: 2)
    let gridItems3ForColors = Array(repeating: GridItem(.fixed(45)), count: 3)
    
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map({String($0)})
    
    var body: some View {
        ZStack {
            Color("back")
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    Text("Add Account".localized())
                        .bold()
                        .font(.title)
                        .padding(.leading, 24)
                    
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundColor(circleColor)
                                .frame(width: 50, height: 50, alignment: .center)
                            Text(circleChar)
                                .foregroundColor(.labelColor)
                                .bold()
                        }
                        
                        VStack(spacing: 24) {
                            InputView(title: "Username", input: $username, placeholder: "Please_add_your_username", activeColor: circleColor)
                            .padding(.horizontal)
                            InputView(title: "Password", input: $username, placeholder: "Please_add_your_username", activeColor: circleColor)
                            .padding(.horizontal)
                        }
                        
                    }
                            
                    
                    VStack(alignment: .leading, spacing: 24) {
                        HStack {
                            Text("Icon Color".localized())
                                .bold()
                                .font(.title2)
                                .padding(.leading, 20)
                            Spacer()
                            
                            ColorPicker("", selection: $circleColor)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(.trailing, 24)

                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: gridItemsForAlphabet, alignment: .top) {
                                ForEach(Color.colorArray, id: \.self) { color in
                                    Button {
                                        withAnimation {
                                            circleColor = color
                                        }
                                    } label: {
                                        Circle()
                                            .foregroundColor(color)
                                    }
                                    .frame(width: 36, height: 36, alignment: .center)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Text("Icon Character".localized())
                            .bold()
                            .font(.title2)
                            .padding(.leading, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: gridItems3ForColors, alignment: .top) {
                                ForEach(alphabet, id: \.self) { char in
                                    Button {
                                        withAnimation {
                                            circleChar = char
                                        }
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(Color("rowGray"))
                                            Text(char)
                                                .bold()
                                                .foregroundColor(.labelColor)
                                        }
                                        
                                    }
                                    .frame(width: 36, height: 36, alignment: .center)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(maxHeight: .infinity)
                        
                    }
                    .padding(.top)
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


struct ColorPickerView: View {
    @State private var bgColor = Color.red

    var body: some View {
        VStack {
            ColorPicker("Set the background color", selection: $bgColor, supportsOpacity: false)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bgColor)
    }
}
