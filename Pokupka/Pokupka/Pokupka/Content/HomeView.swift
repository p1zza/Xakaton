//
//  HomeView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 16.05.2021.
//

import SwiftUI

let cols = [
    GridItem(.flexible(), spacing: 16.0),
    GridItem(.flexible(), spacing: 16.0)
]

struct HomeView: View {
    @EnvironmentObject var user: UserData
    @EnvironmentObject var cart: CartData
    @State var search = ""
    let products: [DemoProduct]
    
    // Search demo
//    @State var products = ["Гречка Макфа", "Кофе Motti", "Бананы 1 кг", "Вода Русская"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg").ignoresSafeArea()
                VStack (spacing: 24.0) {
                    SearchView(text: $search)
                    ScrollView (.vertical, showsIndicators: false) {
                        if !search.isEmpty {
                            LazyVGrid (columns: cols, spacing: 24.0) {
                                ForEach(products.filter{search.isEmpty || $0.title.contains(search)}, id: \.uid) { product in
                                    ProductPreviewView(location: "Москва, Вернадского 8", price: Int.random(in: 40...100), product: product, from: true)
                                        .environmentObject(cart)
                                }
                            }
                        } else {
                            VStack (spacing: 40.0) {
                                SliderView()
                                BuyNowView(products: products)
                                SalesView(products: products)
                            }
                            .padding(.bottom, 16.0)
                        }
                    }
                }
                .padding(.top, 16.0)
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarItems(
                leading:
                    HStack (alignment: .center, spacing: 4.0) {
                        Text("пр-кт Лунчарского, 10к5")
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12.0))
                    }
                    .foregroundColor(Color("DarkTheme"))
                ,trailing:
                    HStack (alignment: .center, spacing: 16.0) {
                        Spacer()
                        NavigationLink(destination: AlarmsView()) {
                            Image(systemName: "bell.badge")
                        }
                        NavigationLink(destination: AccountView().environmentObject(user)) {
                            Image(systemName: "person.crop.circle")
                        }
                    }
            )
        }
        .resignKeyboardOnDragGesture()
    }
}

struct AlarmsView: View {
    @State var alarm = UserDefaults.standard.string(forKey: "alarm")
    
    var body: some View {
        if alarm != nil {
            List {
                Section (header: Text(alarm!)) {
                    Text("Изменение цены на 10 руб. ниже")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Будильники")
        } else {
            Text("Будильников нет :(")
        }
    }
}

struct SliderView: View {
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack (spacing: 16.0) {
                Image("SliderA")
                    .frame(width: 240.0, height: 120.0)
                    .cornerRadius(8.0)
                Image("SliderB")
                    .frame(width: 240.0, height: 120.0)
                    .cornerRadius(8.0)
            }
        }
    }
}

struct BuyNowView: View {
    let products: [DemoProduct]
    
    var body: some View {
        VStack (spacing: 16.0) {
            HStack (alignment: .center, spacing: 8.0) {
                Text("Купить сегодня")
                    .font(.title3)
                    .bold()
                Spacer()
                Group {
                    Text("ещё + 3")
                    Image(systemName: "chevron.right")
                }
                .font(.caption)
            }
            LazyVGrid (columns: cols, spacing: 24.0) {
                ForEach(products, id: \.uid) { product in
                    ProductPreviewView(location: "Москва, Вернадского 8", price: Int.random(in: 40...100), product: product)
                }
            }
        }
    }
}

struct SalesView: View {
    let products: [DemoProduct]
    
    var body: some View {
        VStack (spacing: 16.0) {
            HStack {
                Text("Акции")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            HStack (spacing: 8.0) {
                Button("Сортировка") {
                    // some do
                }
                .buttonStyle(AdditionalButton())
                Button("Фильтр") {
                    // some do
                }
                .buttonStyle(AdditionalButton())
                Spacer()
            }
            LazyVGrid (columns: cols, spacing: 24.0) {
                ForEach(products, id: \.uid) { product in
                    ProductPreviewView(location: "Москва, Вернадского 8", price: Int.random(in: 40...100), product: product)
                }
            }
        }
    }
}
