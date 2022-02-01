//
//  StartHomeView.swift
//  ZCrypto
//
//  Created by Ishaan Bhasin on 11/26/21.
//

import SwiftUI

struct StartHomeView: View {
    @EnvironmentObject var startVm: StartHomeViewModel
    @State var isInLoginMode: Bool = false
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack{
            // Background Layer
            Color.theme.background
                .ignoresSafeArea()
            
            // Content Layer
            // Header
            VStack{
                header
                Spacer(minLength: 0)
                if !isInLoginMode{
                    registrationView
                        .alert(startVm.errorMessage, isPresented: $startVm.showError, actions: {
                            Button("Ok", role: .cancel){}
                        })
                        .transition(.move(edge: .leading))
                }
                if isInLoginMode{
                    loginView
                        .alert(startVm.errorMessage, isPresented: $startVm.showError, actions: {
                            Button("Ok", role: .cancel){}
                        })
                        .transition(.move(edge: .trailing))
                }
                VStack{
                    CircleButtonView(iconName: "chevron.right")
                        .rotationEffect(Angle(degrees: isInLoginMode ? 180: 0))
                        .onTapGesture {
                            withAnimation {
                                isInLoginMode.toggle()
                                email = ""
                                password = ""
                            }
                        }
                    Text(isInLoginMode ? "New User" : "Existing User")
                        .font(.caption)
                        .foregroundColor(Color.theme.accent)
                }
                Spacer(minLength: 0)
            }
        }
    }
}

extension StartHomeView{
    private var header: some View{
        HStack{
            
            Spacer()
            Text(isInLoginMode ? "Existing User" : "New User")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            
        }
        .padding()
    }
    
    private var registrationView: some View{
        VStack(spacing: 25){
            HStack{
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(Color.theme.accent)
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.background)
                    .shadow(color: Color.theme.accent.opacity(0.45), radius: 10, x: 0, y: 0)
                
            )
            .padding()
            
            HStack{
                SecureField("Password", text: $password)
                    .foregroundColor(Color.theme.accent)
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.background)
                    .shadow(color: Color.theme.accent.opacity(0.45), radius: 10, x: 0, y: 0)
                
            )
            .padding()
            
            Button {
                guard !email.isEmpty && !password.isEmpty else {return}
                startVm.signUp(email: email, password: password)
                email = ""
                password = ""
                
            } label: {
                Text(isInLoginMode ? "Login" : "Register")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.theme.accent, lineWidth: 1)
                    )
                    .animation(.none, value: isInLoginMode)
            }
        }
        .padding()
        .padding(.horizontal)
    }
    
    private var loginView: some View{
        VStack(spacing: 25){
            HStack{
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(Color.theme.accent)
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.background)
                    .shadow(color: Color.theme.accent.opacity(0.45), radius: 10, x: 0, y: 0)
                
            )
            .padding()
            
            HStack{
                SecureField("Password", text: $password)
                    .foregroundColor(Color.theme.accent)
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.background)
                    .shadow(color: Color.theme.accent.opacity(0.45), radius: 10, x: 0, y: 0)
                
            )
            .padding()
            Button {
                guard !email.isEmpty && !password.isEmpty else {return}
                startVm.signIn(email: email, password: password)
                email = ""
                password = ""
            } label: {
                Text(isInLoginMode ? "Login" : "Register")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.theme.accent, lineWidth: 1)
                    )
                    .animation(.none, value: isInLoginMode)
            }
        }
        .padding()
        .padding(.horizontal)
    }
}

struct StartHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StartHomeView()
            StartHomeView()
                .preferredColorScheme(.dark)
        }
    }
}

