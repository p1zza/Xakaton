//
//  FavoritesView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 18.05.2021.
//

import SwiftUI

struct FavoritesView: View {
    @State var count = 8
    @State var search = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg").ignoresSafeArea()
                VStack (spacing: 24.0) {
                    SearchView(text: $search, catalog: false)
                        .padding(.horizontal)
                    ScrollView {
                        ForEach(1...count/2, id: \.self) { _ in
                            HStack (alignment: .top, spacing: 16.0) {
                                ForEach(1...2, id: \.self) { _ in
                                    ProductPreviewView(title: "Гречка Макфа", location: "пр-кт Вернадского 88", price: Int.random(in: 40...100), favorite: true)
                                }
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
