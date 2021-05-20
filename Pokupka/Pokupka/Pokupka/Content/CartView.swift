//
//  CartView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 19.05.2021.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartData
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg").ignoresSafeArea()
                ScrollView {
                    VStack (spacing: 16.0) {
                        if cart.items.isEmpty {
                            Text("В корзине пусто")
                        } else {
                            ForEach (cart.items, id: \.uid) { item in
                                HStack (spacing: 16.0) {
                                    item.image
                                        .resizable()
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .frame(maxWidth: 80.0)
                                        .cornerRadius(8.0)
                                    Spacer()
                                    VStack (spacing: 8.0) {
                                        HStack {
                                            Text(item.title)
                                                .bold()
                                            Spacer()
                                            Image(systemName: "xmark")
                                                .foregroundColor(Color("Gray"))
                                        }
                                        HStack (spacing: 4.0) {
                                            Image(systemName: "location.fill.viewfinder")
                                            Text(item.location)
                                                .font(.caption)
                                                .foregroundColor(Color("Gray"))
                                            Spacer()
                                        }
                                        HStack (spacing: 8.0) {
                                            Image(systemName: "minus")
                                                .font(.title3)
                                            Text("\(item.count)")
                                            Image(systemName: "plus")
                                                .font(.title3)
                                            Spacer()
                                            Text("\(item.price) руб.")
                                                .bold()
                                        }
                                    }
                                    
                                }
                            }
                            Divider()
                            HStack {
                                Spacer()
                                Text("Очистить корзину")
                                    .foregroundColor(Color("Colar"))
                            }
                            Group {
                                Button (action: {
                                    
                                }) {
                                    Text("Умный маршрут \(cart.totals[0]) руб.")
                                        .padding()
                                }
                                Button (action: {
                                    
                                }) {
                                    Text("Доставка \(cart.totals[1]) руб.")
                                        .padding()
                                }
                                Button (action: {
                                    
                                }) {
                                    Text("Все в одном магазине \(cart.totals[2]) руб.")
                                        .padding()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("Night"))
                            .background(Color("LightTheme"))
                            .cornerRadius(8.0)
                        }
                        BuyNowView(products: getProducts(4))
                        Spacer()
                    }
                    .padding()
                    .navigationBarTitle("Корзина", displayMode: .inline)
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
