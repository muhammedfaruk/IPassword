//
//  AddAccountView.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import SwiftUI

struct AddAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var item: Item?
    var isUpdate: Bool = false
    
    @State var username: String = ""
    @State var password: String = ""
    @State var title: String = ""
    
    @State var circleColor: Color = .blue
    @State var circleChar: String = "A"        
    
    let gridItemsForAlphabet = Array(repeating: GridItem(.fixed(45)), count: 1)
    let gridItems3ForColors = Array(repeating: GridItem(.fixed(45)), count: 2)
    
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map({String($0)})
    
    var body: some View {
        ZStack {
            Color("back")
                .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    Text(isUpdate ? "Update Record".localized() : "Add Record".localized())
                        .bold()
                        .font(.title)
                        .padding(.leading, 24)
                    
                    VStack {
                        circle()
                        
                        VStack(spacing: 24) {
                            InputView(title: "Title".localized(), input: $title, placeholder: "Please_add_title".localized(), activeColor: circleColor, keyboardType: .default)
                            
                            InputView(title: "Email or Username".localized(), input: $username, placeholder: "Please_add_your_username", activeColor: circleColor, keyboardType: .emailAddress)
                            
                            InputView(title: "Password".localized(), input: $password, placeholder: "Please_add_your_password", activeColor: circleColor, keyboardType: .default, isSecureField: true)
                            
                        }
                        .padding(.horizontal)
                        
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
                            
                            Button {
                                
                                if isUpdate {
                                    //MARK - UPDATE
                                    if item != nil {
                                        updateItem(updateItem: item!)
                                    }
                                                                        
                                }else {
                                    //MARK - SAVE
                                    addItem()
                                }
                                                                
                            } label: {
                                ZStack {
                                    Capsule()
                                        .fill(
                                            LinearGradient(gradient: Gradient(colors: [circleColor, Color.sysBack]), startPoint: .leading, endPoint: .trailing)
                                        )
                                    
                                    Text(isUpdate ? "Update".localized() : "Save".localized())
                                        .bold()
                                        .foregroundColor(.labelColor)
                                }
                                .frame(height: 50)
                                
                            }
                            .padding(.horizontal)
                        }
                    .padding(.top)
                    
                    

                }
                .padding(.bottom)
            }
            .padding(.top, 24)
        }
        .navigationBarHidden(true)
        .onAppear {
            setDataIfNotNil()
        }
    }
    
    
    private func circle() -> some View {
        ZStack {
            Circle()
                .foregroundColor(circleColor)
                .frame(width: 50, height: 50, alignment: .center)
            Text(circleChar)
                .foregroundColor(.labelColor)
                .bold()
        }
    }
    
    //MARK: -Update icin hazir gelen bilgiler burada handle ediliyor
    private func setDataIfNotNil(){
        if item != nil {
            title = item?.title ?? ""
            username = item?.username ?? ""
            password = item?.pass ?? ""
            circleChar = item?.character ?? ""
            circleColor = Color(hex: item?.colorHex ?? "")
        }
    }
    
    private func updateItem(updateItem: Item) {
        withAnimation {
            items.forEach { item in
                if item == updateItem {                    
                    item.character = circleChar
                    item.colorHex = circleColor.toHex() ?? "3478F6"
                    item.username = username
                    item.pass = password
                    item.title = title
                }
                
                saveContext()
                dismiss()
            }
        }        
    }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.character = circleChar
            newItem.colorHex = circleColor.toHex() ?? "3478F6"
            newItem.username = username
            newItem.pass = password
            newItem.title = title
            saveContext()
            dismiss()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
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
