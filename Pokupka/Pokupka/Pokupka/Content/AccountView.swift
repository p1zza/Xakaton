//
//  AccountView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 17.05.2021.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var user: UserData
    
    var body: some View {
        VStack (spacing: 8.0) {
            HStack {
                Text(user.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("DarkTheme"))
                Spacer()
            }
            HStack {
                Text(user.phone)
                    .font(.subheadline)
                    .foregroundColor(Color("Gray"))
                Spacer()
            }
            Divider()
            List {
                Group {
                    NavigationLink (destination: SettingsView().environmentObject(user)) {
                        HStack (spacing: 8.0) {
                            Image(systemName: "gearshape")
                            Text("Настройки")
                            Spacer()
                        }
                    }
                    NavigationLink (destination: Text("Настройки")) {
                        HStack (spacing: 8.0) {
                            Image(systemName: "location.viewfinder")
                            Text("Адреса")
                            Spacer()
                        }
                    }
                    NavigationLink (destination: Text("Настройки")) {
                        HStack (spacing: 8.0) {
                            Image(systemName: "heart")
                            Text("Любимые магазины")
                            Spacer()
                        }
                    }
                    NavigationLink (destination: Text("Настройки")) {
                        HStack (spacing: 8.0) {
                            Image(systemName: "wallet.pass")
                            Text("Чеки")
                            Spacer()
                        }
                    }
                }
                .padding(.vertical, 8.0)
                Button(action: {
                    user.logOut()
                }) {
                    HStack (spacing: 8.0) {
                        Image(systemName: "person.crop.circle.badge.xmark")
                        Text("Выйти из аккаунта")
                        Spacer()
                    }
                    .foregroundColor(Color("Colar"))
                }
                .padding(.vertical, 8.0)
            }
        }
        .padding()
        .navigationBarTitle("Аккаунт")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView: View {
    @EnvironmentObject var user: UserData
    @State var push = false
    
    var body: some View {
        ZStack {
            Color("Bg").ignoresSafeArea()
            List {
                Section (header:
                    HStack {
                        Text("Аккаунт")
                        Spacer()
                    }
                ) {
                    Group {
                        NavigationLink (destination: Text("Смена имени")) {
                            HStack (spacing: 8.0) {
                                Image(systemName: "person.crop.circle")
                                Text(user.name == "Мой друг" ? "Укажите имя" : user.name)
                                Spacer()
                            }
                        }
                        NavigationLink (destination: Text("Смена телефона")) {
                            HStack (spacing: 8.0) {
                                Image(systemName: "phone")
                                Text(user.phone.isEmpty ? "Укажите телефон" : user.phone)
                                Spacer()
                            }
                        }
                        NavigationLink (destination: Text("Смена почты")) {
                            HStack (spacing: 8.0) {
                                Image(systemName: "envelope")
                                Text(user.email.isEmpty ? "Укажите email" : user.email)
                                Spacer()
                            }
                        }
                    }
                    .padding(.vertical, 8.0)
                }
                Section (header:
                    HStack {
                        Text("Карта лояльности Магнит")
                        Spacer()
                    }
                ) {
                    Group {
                        NavigationLink (destination: Text("Привязка карты")) {
                            HStack (spacing: 8.0) {
                                Image(systemName: "mail.stack")
                                Text("Привязать карту")
                                Spacer()
                            }
                        }
                    }
                    .padding(.vertical, 8.0)
                }
                Section (header:
                    HStack {
                        Text("Уведомления")
                        Spacer()
                    }
                ) {
                    Group {
                        HStack {
                            Text("Разрешить Push-уведомления")
                            Spacer()
                            Toggle(isOn: $user.push) {
                                Text("")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: Color("Colar")))
                            .onTapGesture {
                                user.togglePush()
                            }
                        }
                    }
                    .padding(.vertical, 8.0)
                }
            }.listStyle(InsetGroupedListStyle())
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
