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
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("All Records".localized())
                    .foregroundColor(.labelColor)
                    .font(.title)
                    .bold()
                
                Spacer()
                Button {
                    openSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.labelColor)
                        .font(.title)
                }

            }
            .padding(.horizontal)
                      
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(items) { i in
                        AccountRowView(item: i)
                    }
                }
                .padding(.top)
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

