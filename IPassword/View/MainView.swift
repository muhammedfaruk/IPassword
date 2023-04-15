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
    @State var openUpdateSheet: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var didSave =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave) //the publisher
    @State private var refreshID = UUID()
    
        
    @Binding var showMessage: Bool
    @Binding var message: String
    
    @State private var selectedItemIndex: Int?
    @State private var selectedItem: FetchedResults<Item>.Element?
    
    var body: some View {
            ZStack {
                Color("back")
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                                                            
                    if items.count == 0 {
                        Spacer()
                        VStack(alignment: .center, spacing: 20) {
                            
                            Button {
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
                            VStack(spacing: 20) {
                                ForEach(Array(items.enumerated()), id: \.element) { index, item in
                                    AccountRowView(item: item, showMessage: $showMessage, message: $message)
                                        .onTapGesture {
                                            //Update
                                            selectedItem = item
                                            openUpdateSheet.toggle()
                                        }
                                }
                            }
                            .padding(.top)
                        }
                        .id(refreshID)
                        .onReceive(self.didSave) { _ in //the listener - context update
                            self.refreshID = UUID()
                        }
                    }
                }
                .sheet(isPresented: $openSheet) {
                    AddAccountView()
                }
                .sheet(item: $selectedItem, content: { i in
                    AddAccountView(item: i, isUpdate: true)
                })
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
    
    let item: Item
    @Binding var showMessage: Bool
    @Binding var message: String
    @State var isMoreVisible: Bool = false
    @State var isSecurePass: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color("rowGray"))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
            
            VStack(alignment: .center, spacing: 20) {
                ZStack() {
                    iconAndTitle()
                    HStack() {
                        Spacer()
                        VStack() {
                            Spacer()
                            moreBtn()
                        }
                    }
                    .padding(.top)
                }
                
                if isMoreVisible {
                    HStack(alignment: .center, spacing: 10) {
                        usernamAndPass()
                        Spacer()
                        Button {
                            withAnimation {
                                isSecurePass.toggle()
                            }
                        } label: {
                            Image(systemName: isSecurePass ? "eye" : "eye.slash")
                                .padding(.trailing)
                                .foregroundColor(.white)
                                .padding(.top)
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
            Text(item.username ?? "")
                .lineLimit(1)
                .font(.body)
            let password = item.pass ?? ""
            Text(isSecurePass ? password.secureText() : password)
                .font( isSecurePass ? .footnote : .body)
                .frame(height: 20)
        }
    }
    
    @ViewBuilder
    private func copyButtons() -> some View {
        Spacer()
        Button {
            UIPasteboard.general.string = item.username ?? ""
            withAnimation {
                message = "Username Copied"
                showMessage = true
            }
        } label: {
            HStack(alignment: .center) {
                Image(systemName: "wallet.pass")
                Text("Copy Username".localized())
                    .lineLimit(1)
            }
        }
        .buttonStyle(.bordered)
        
        Spacer()
        
        Button {
            UIPasteboard.general.string = item.pass ?? ""
            withAnimation {
                message = "Password Copied"
                showMessage = true
            }
        } label: {
            HStack(alignment: .center) {
                Image(systemName: "wallet.pass")
                Text("Copy Password".localized())
                    .lineLimit(1)
            }
        }
        .buttonStyle(.bordered)
        Spacer()
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
                Image(systemName: isMoreVisible ? "chevron.up" : "chevron.down")
                    .font(.title3)
            }
        }
        .padding(.trailing, 4)
        .padding(.top, 16)
    }
    
    
    @ViewBuilder
    private func iconAndTitle() -> some View {
        HStack(spacing: 25) {
            ZStack {
                Circle()
                    .foregroundColor(Color(hex: item.colorHex ?? "fffff"))
                
                Text(item.character ?? "")
                    .bold()
            }
            .padding(.leading, 8)
            .frame(height: 50)
            
            Text(item.title ?? "")
                .foregroundColor(.labelColor)
                .font(.title3)
                .bold()
            
            Spacer()
        }
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showMessage: .constant(false), message: .constant(""))
    }
}

