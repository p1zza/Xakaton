//
//  AuthView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 12.05.2021.
//

import SwiftUI
import AuthenticationServices

struct AuthView: View {
    @State var phone: String = "+7"
    @State private var confirm = false
    @State private var code = ""
    @ObservedObject var codeInputer = CodeInputer()
    @EnvironmentObject var user: UserData
    
    var body: some View {
        ZStack {
            Color("Bg").ignoresSafeArea()
            VStack (spacing: 8.0) {
                if !confirm {
                    //auth
                    HStack {
                        Text("Номер телефона")
                            .font(.headline)
                        Spacer()
                    }
                    HStack (alignment: .center, spacing: 16.0) {
                        TextField("+7", text: $phone)
                            .modifier(BasicTextField())
                        if phone.count == 12 {
                            Spacer()
                            Button (action: {
                                code.randomCode()
//                                    pushNotice(title: "Код подтверждения", message: code)
                                confirm.toggle()
                            }) {
                                Image(systemName: "chevron.right")
                            }
                            .buttonStyle(IconButton())
                            Spacer()
                        }
                    }
                    SignInWithAppleButton(.signIn, onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                        print()
                    }, onCompletion: { result in
                        switch result {
                            case .success(let authResults):
                                user.logIn()
                            case .failure (let error):
                                print("Authorisation failed: \(error.localizedDescription)")
                        }
                    }
                    )
                    .signInWithAppleButtonStyle(.whiteOutline)
                    .frame(width: 240.0, height: 48.0)
                    .padding(.top, 24.0)
                    Button ("Пропустить") {
                        // do some
                    }
                    .buttonStyle(TextButton())
                } else {
                    //confirm
                    HStack {
                        Text("Код подтверждения")
                            .font(.headline)
                        Spacer()
                    }
                    HStack (alignment: .center, spacing: 16.0) {
                        TextField(code, text: $codeInputer.value)
                            .modifier(BasicTextField())
                            .keyboardType(.numberPad)
                    }
                    .onReceive(codeInputer.isCompleted) { value in
                        if value == code {
                            user.updateData(inPhone: phone)
                            user.logIn()
                        }
                    }
                    Button ("Выслать повторно на\n\(phone)") {
                        code.randomCode()
//                            pushNotice(title: "Код подтверждения", message: code)
                    }
                    .buttonStyle(TextButton())
                    .multilineTextAlignment(.center)
                }
            }
            .padding()
        }
    }
}
