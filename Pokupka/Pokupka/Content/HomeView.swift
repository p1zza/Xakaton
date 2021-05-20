//
//  HomeView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 16.05.2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user: UserData
    @EnvironmentObject var cart: CartData
    @State var search = ""
    
    // Search demo
    @State var products = ["Гречка Макфа", "Кофе Motti", "Гречка Мукфо", "Лапша Barilla"]
    let cols = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg").ignoresSafeArea()
                VStack (spacing: 24.0) {
                    SearchView(text: $search)
                    ScrollView (.vertical, showsIndicators: false) {
                        if !search.isEmpty {
                            LazyVGrid (columns: cols, spacing: 24.0) {
                                ForEach(products.filter{search.isEmpty || $0.contains(search)}, id: \.self) { product in
                                    ProductPreviewView(title: product, location: "Москва, Вернадского 8", price: Int.random(in: 40...100), from: true)
                                        .environmentObject(cart)
                                }
                            }
                        } else {
                            VStack (spacing: 40.0) {
                                SliderView()
                                BuyNowView()
                                SalesView()
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
    @State private var count: Int = 4
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack (spacing: 16.0) {
                ForEach(1...count, id: \.self) { _ in
                    Rectangle()
                        .foregroundColor(Color("LightTheme"))
                        .frame(width: 240.0, height: 120.0)
                        .cornerRadius(8.0)
                }
            }
        }
    }
}

struct BuyNowView: View {
    @State private var count = 8
    
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
            ForEach(1...count/2, id: \.self) { _ in
                HStack (alignment: .top, spacing: 16.0) {
                    ForEach(1...2, id: \.self) { _ in
                        ProductPreviewView(title: "Гречка Макфа", location: "Москва, Вернадского 8", price: Int.random(in: 40...100))
                    }
                }
            }
        }
    }
}

struct SalesView: View {
    @State private var count = 8
    
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
            ForEach(1...count/2, id: \.self) { _ in
                HStack (alignment: .top, spacing: 16.0) {
                    ForEach(1...2, id: \.self) { _ in
                        ProductPreviewView(title: "Гречка Макфа", location: "пр-кт Вернадского 88", price: Int.random(in: 40...100))
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
