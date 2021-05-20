//
//  Classes.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 16.05.2021.
//

import SwiftUI
import Combine

class CodeInputer: ObservableObject {
    let isCompleted = PassthroughSubject<String, Never>()
    @Published var value: String {
        didSet {
            if value.count > 4 {
                value = oldValue
            } else if value.count == 4 {
                isCompleted.send(value)
            }
        }
    }
    
    init () {
        value = ""
    }
}

struct ItemCart {
    var title: String
    var location: String
    var count: Int
    var price: Int
    let uid = UUID()
    
    init (inTitle: String, inLocation: String, inPrice: Int) {
        title = inTitle
        location = inLocation
        count = 1
        price = inPrice
    }
}

class CartData: ObservableObject {
    @Published var totals: [Int]
    @Published var items: [ItemCart]
    
    init () {
        totals = [0, 0, 0]
        items = [ItemCart]()
    }
    
    func addItem (item: ItemCart) {
        items.append(item)
    }
    
    func calcTotals () {
        for item in items {
            print(item.count, item.price)
            totals[0] += item.count * item.price
            totals[1] += item.count * item.price
            totals[2] += item.count * item.price
        }
        totals[1] += 200
        totals[2] += Int.random(in: 0...200)
    }
}

class UserData: ObservableObject {
    @Published var name: String
    @Published var phone: String
    @Published var email: String
    @Published var push: Bool
    @Published var auth: Bool
    
    init () {
        name = UserDefaults.standard.string(forKey: "user_name") ?? "Мой друг"
        phone = UserDefaults.standard.string(forKey: "user_phone") ?? ""
        email = UserDefaults.standard.string(forKey: "user_email") ?? ""
        push = UserDefaults.standard.bool(forKey: "user_push")
        auth = UserDefaults.standard.bool(forKey: "user_auth")
    }
    
    init (inName: String = "Мой друг", inPhone: String, inEmail: String = "", inPush: Bool = true) {
        name = inName
        phone = inPhone
        email = inEmail
        push = inPush
        auth = true
        UserDefaults.standard.setValue(true, forKey: "user_auth")
    }
    
    func updateData (inName: String = "", inPhone: String = "", inEmail: String = "") {
        if !inName.isEmpty {
            UserDefaults.standard.setValue(inName, forKey: "user_name")
            name = inName
        }
        if inPhone.count == 12 {
            UserDefaults.standard.setValue(inPhone, forKey: "user_phone")
            phone = inPhone
        }
        if !inEmail.isEmpty {
            UserDefaults.standard.setValue(inEmail, forKey: "user_email")
            email = inEmail
        }
    }
    
    func logIn () {
        auth = true
        UserDefaults.standard.setValue(true, forKey: "user_auth")
    }
    
    func logOut () {
        auth = false
        UserDefaults.standard.setValue(true, forKey: "user_auth")
    }
    
    func togglePush () {
        push.toggle()
        UserDefaults.standard.setValue(push, forKey: "user_push")
    }
}
