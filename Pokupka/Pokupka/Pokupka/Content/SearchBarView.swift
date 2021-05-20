//
//  SearchBarView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 18.05.2021.
//

import SwiftUI


struct SearchView: View {
    @Binding var text: String
    @State var catalog: Bool = true
    
    var body: some View {
        HStack (spacing: 8.0) {
            if catalog && text.isEmpty {
                Button(action: {
                    // catalog
                }) {
                    Image(systemName: "circle.grid.2x2")
                }
                .font(.system(size: 24.0))
                .foregroundColor(Color("Colar"))
            }
            ZStack {
                TextField("Найти...", text: $text)
                    .modifier(SearchTextField())
                HStack {
                    Spacer()
                    Image(systemName: "qrcode")
                        .foregroundColor(Color("DarkTheme"))
                        .font(.subheadline)
                        .padding(.trailing, 16.0)
                }
                .opacity(text.isEmpty ? 1.0 : 0)
            }
            if !text.isEmpty {
                Button ("Отмена") {
                    text.removeAll()
                }
            }
        }
    }
}
