//
//  UIComponents.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 12.05.2021.
//

import SwiftUI
import AuthenticationServices

//Buttons
struct TextButton: ButtonStyle {
    @State var color: Color = Color("DarkTheme")
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 14.0, weight: .bold))
            .foregroundColor(color.opacity(0.8))
            .padding(.all, 4)
    }
}
struct ColarButton: ButtonStyle {
    @State var minWidth: CGFloat?
    @State var maxWidth: CGFloat?
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: self.minWidth ?? .none, maxWidth: self.maxWidth ?? .none)
            .padding(.vertical, 8.0)
            .padding(.horizontal, 16.0)
            .foregroundColor(Color("Colar"))
            .cornerRadius(8.0)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color("Colar"), lineWidth: 1)
            )
            .animation(nil)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring())
    }
}
struct AdditionalButton: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.all, 8.0)
            .foregroundColor(Color("DarkTheme"))
            .background(Color("LightTheme"))
            .cornerRadius(16.0)
            .animation(nil)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring())
    }
}
struct IconButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 32.0, height: 32.0)
            .background(Color("Light"))
            .foregroundColor(Color("Colar"))
            .cornerRadius(8.0)
            .font(.system(size: 16.0))
            .animation(nil)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring())
    }
}
struct MenuButton: View {
    @State var icon: String = "app"
    @State var title: String = "Item"
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
            Text(title)
        }
    }
}

// TextFields
struct BasicTextField: ViewModifier {
    @State var error: Bool = false
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(Color("DarkTheme"))
            .background(Color("LightTheme"))
            .cornerRadius(8.0)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(error ? .pink : Color.clear, lineWidth: 1)
            )
            .animation(.spring())
    }
}
struct SearchTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("DarkTheme"))
            .padding(.vertical, 8.0)
            .padding(.horizontal, 16.0)
            .background(Color("LightTheme"))
            .cornerRadius(8.0)
            .animation(.spring())
    }
}
