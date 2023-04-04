//
//  MainView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import SwiftUI

struct MainView: View {
    @State private var searchText = ""
    @State var openSheet: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var selectedIndex: Int?
    
    
    
    
    var body: some View {
            ZStack {
                Color("back")
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                                                            
                    if items.count != 0 {
                        Spacer()
                        VStack(alignment: .center, spacing: 20) {
                            
                            Button {
                                selectedIndex = nil
                                openSheet.toggle()
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color("rowGray"))
                                        .frame(width: 70, height: 70, alignment: .center)
                                        .shadow(color: .black.opacity(0.3), radius: 10)
                                    Image(systemName:"plus")
                                        .font(.title)
                                        .foregroundColor(.labelColor)
                                }
                            }
                            
                            Text("Add Your First Record".localized())
                                .foregroundColor(.labelColor)
                                .font(.title2)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }else {
                        ScrollView {
                            VStack() {
                                ForEach(0...5, id: \.self) { index in
//                                    NavigationLink {
//                                        //AddAccountView(item: item)
//                                    } label: {
//
//                                    }
//                                    .buttonStyle(PlainButtonStyle())
                                    AccountRowView()
                                        //.frame(height: 60)
                                }
                            }
                            .padding(.top)
                        }
                    }
                }
                .sheet(isPresented: $openSheet) {
                    AddAccountView()
                }
            }
            .onChange(of: searchText, perform: { _ in
                if searchText.isEmpty {
                    items.nsPredicate = nil
                } else {
                    items.nsPredicate = NSPredicate(format: "title BEGINSWITH %@", searchText)
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    plusBtnView()
                }
            })
            .navigationTitle("All Records".localized())
            .searchable(text: $searchText)
    }
    
    @ViewBuilder
    private func plusBtnView() -> some View {
        if items.count != 0 {
            Button {
                openSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.labelColor)
                    .font(.title2)
            }
        }
    }
}

struct AccountRowView: View {
    
    //let item: Item
    
    @State var isMoreVisible: Bool = false
    @State var isSecurePass: Bool = true
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color("rowGray"))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
            
            VStack(alignment: .center, spacing: 20) {
                HStack() {
                    iconAndTitle()
                    moreBtn()
                }
                
                if isMoreVisible {
                    HStack(alignment: .bottom, spacing: 10) {
                        usernamAndPass()
                        Button {
                            withAnimation {
                                isSecurePass.toggle()
                            }
                        } label: {
                            Image(systemName: isSecurePass ? "eye" : "eye.slash")
                                .padding(.trailing)
                                .foregroundColor(.white)
                                .padding(.bottom , 2)
                        }
                    }
                    .padding(.bottom)
                    .padding(.top)
                    
                    HStack {
                        copyButtons()
                    }
                    .padding(.bottom)
                }
            }
            .padding(10)
        }
        //.padding(.vertical, 25)
        .padding(.horizontal)
        
    }
    
    @ViewBuilder
    private func usernamAndPass() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Username".localized() + ":")
                .font(.body)
            Text("Password".localized() + ":")
                .font(.body)
        }
        .padding(.leading)
        
        
        VStack(alignment: .leading, spacing: 10) {
            Text("faruk.sogut@btpro.net")
                .font(.body)
            Text(isSecurePass ? "Aa12345.".secureText() : "Aa12345")
                .font( isSecurePass ? .footnote : .body)
                .frame(height: 20)
        }
    }
    
    @ViewBuilder
    private func copyButtons() -> some View {
        Button {
            
        } label: {
            HStack(alignment: .center) {
                Image(systemName: "wallet.pass")
                Text("Copy Name".localized())
            }
        }
        .buttonStyle(.bordered)
        
        
        Button {
            
        } label: {
            HStack(alignment: .center) {
                Image(systemName: "wallet.pass")
                Text("Copy Password".localized())
            }
        }
        .buttonStyle(.bordered)
    }
    
    @ViewBuilder
    private func moreBtn() -> some View {
        VStack {
            Spacer()
            Button {
                withAnimation {
                    isMoreVisible.toggle()
                }
            } label: {
                Text( isMoreVisible ? "Hide Detail".localized() : "Show Detail".localized())
                    .font(.callout)
            }
        }
        .padding(.trailing)
        .padding(.bottom, 4)
    }
    
    
    @ViewBuilder
    private func iconAndTitle() -> some View {
        HStack(spacing: 25) {
            ZStack {
                Circle()
                    .foregroundColor(Color.yellow)
                
                Text("A")
                    .bold()
            }
            .padding(.leading, 8)
            .frame(height: 50)
            
            Text("Label")
                .foregroundColor(.labelColor)
                .font(.title3)
                .bold()
            
            Spacer()
        }
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

