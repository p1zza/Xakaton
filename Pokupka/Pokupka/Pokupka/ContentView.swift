//
//  ContentView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 12.05.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var user: UserData
    @StateObject var cart = CartData()
    
    var body: some View {
        ZStack {
            if user.auth {
                MenuView().environmentObject(user).environmentObject(cart)
            } else {
                AuthView().environmentObject(user)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            pushNotice(title: "Будильник цен", message: "Цена товара \(UserDefaults.standard.string(forKey: "alarm") ?? "Бананы 1 кг") изменилась на 10 рублей ниже!")
        }
        .onAppear {
            requestAuthorizationNotice()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
