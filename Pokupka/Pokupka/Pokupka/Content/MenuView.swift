//
//  MenuView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 16.05.2021.
//

import SwiftUI

struct MenuView: View {
    @State private var selection: Int = 1
    @EnvironmentObject var user: UserData
    @EnvironmentObject var cart: CartData
    let products = getProducts(4)
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView(products: products)
                .environmentObject(user)
                .environmentObject(cart)
                .tabItem { MenuButton(icon: "house", title: "Главная") }.tag(1)
            FavoritesView()
                .tabItem { MenuButton(icon: "heart", title: "Избранное") }.tag(2)
            Text("Аналитика")
                .tabItem { MenuButton(icon: "chart.bar", title: "Аналитика") }.tag(3)
            Text("Покупки")
                .tabItem { MenuButton(icon: "bag", title: "Покупки") }.tag(4)
            CartView()
                .tabItem { MenuButton(icon: "cart", title: "Корзина") }.tag(5)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
