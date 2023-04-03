//
//  MainView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @State var openSheet: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var selectedIndex: Int?
    
    var body: some View {
        ZStack {
            Color("back")
            VStack(alignment: .center) {
                
                HStack(alignment: .top) {
                    Text("All Records".localized())
                        .foregroundColor(.labelColor)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    if items.count != 0 {
                        Button {
                            openSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.labelColor)
                                .font(.title)
                        }
                    }
                }
                .padding(.horizontal)
                                
                if items.count == 0 {
                    Spacer()
                    VStack(alignment: .center, spacing: 20) {
                        
                        Button {
                            selectedIndex = nil
                            openSheet.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("rowGray"))
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .shadow(color: .black.opacity(0.3), radius: 10)
                                Image(systemName:"plus")
                                    .font(.title)
                                    .foregroundColor(.labelColor)
                            }
                        }
                        
                        Text("Add Your First Record".localized())
                            .foregroundColor(.labelColor)
                            .font(.title)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(Array(items.enumerated()), id: \.element) { index, item in
                                NavigationLink {
                                    AddAccountView(item: item)
                                } label: {
                                    AccountRowView(item: item)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .padding(.top, 74)
            .sheet(isPresented: $openSheet) {
                AddAccountView()
            }
        }
        .ignoresSafeArea()
    }
}

struct AccountRowView: View {
    
    let item: Item
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color("rowGray"))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
            
            HStack(spacing: 25) {
                ZStack {
                    Circle()
                        .foregroundColor(Color(hex: item.colorHex ?? ""))
                    
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
        .padding(.horizontal)
        .frame(height: 60, alignment: .center)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

