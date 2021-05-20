//
//  FavoritesView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 18.05.2021.
//

import SwiftUI

struct FavoritesView: View {
    @State var products = getProducts(8)
    @State var search = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg").ignoresSafeArea()
                VStack (spacing: 24.0) {
                    SearchView(text: $search, catalog: false)
                        .padding(.horizontal)
                    ScrollView {
                        LazyVGrid (columns: cols, spacing: 24.0) {
                            ForEach(products, id: \.uid) { product in
                                ProductPreviewView(location: "Москва, Вернадского 8", price: Int.random(in: 40...100), product: product)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 16.0)
                .navigationBarTitle("Избранное", displayMode: .inline)
                .navigationBarItems(leading: leading, trailing: trailing)
                .resignKeyboardOnDragGesture()
            }
        }
    }
    
    private var leading: some View {
        Button (action: {
            //some do
        }) {
            Image(systemName: "arrow.up.arrow.down")
        }
    }
    private var trailing: some View {
        Button (action: {
            //some do
        }) {
            Image(systemName: "line.horizontal.3.decrease")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
