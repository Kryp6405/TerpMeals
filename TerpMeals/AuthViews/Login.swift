//
//  Login.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/4/24.
//

import SwiftUI

struct Login2: View {
    @StateObject private var viewModel = SignInModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var navigateToHome = false
    @FocusState private var focusedField: Field?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if navigateToHome {
            HomeView()
        } else {
            NavigationStack {
                VStack {
                    Spacer()
                    
                    HStack {
                        Text("Welcome Back!")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(Color(.dark).opacity(0.75))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Text("Log In")
                            .font(.system(size:65))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.dark))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    
                    VStack {
                        VStack(alignment: .leading, spacing: 2, content: {
                            Text("Email")
                                .fontWeight(.medium)
                                .foregroundColor(
                                    focusedField == .email ? .black : .gray
                                )
                            
                            TextField("exmaple@email. com", text: $email)
                                .font(.system(size: 20, weight: .light))
                                .foregroundColor(.black)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .focused($focusedField, equals: .email)
                                .onChange(of: focusedField) { newValue in
                                    if newValue == .email {
                                        UITextField.appearance().tintColor = .black
                                    }
                                }
                            
                            Divider()
                                .frame(
                                    height: focusedField == .email ? 1 : 0.5
                                )
                                .background(
                                    focusedField == .email ? .black : .gray
                                )
                        })
                        .padding()
                        .cornerRadius(5)
                        .padding(.horizontal, 10)
                    }
                    .padding(.vertical, 5)
                    .background(Color(.light))
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.dark), lineWidth: 2)
                            .padding(.horizontal,20)
                    )
                    
                    VStack {
                        HStack {
                            if showPassword {
                                VStack(alignment: .leading, spacing: 2, content: {
                                    Text("Password")
                                        .fontWeight(.medium)
                                        .foregroundColor(
                                            focusedField == .password ? .black : .gray
                                        )
                                    
                                    TextField("*******", text: $password)
                                        .font(.system(size: 20, weight: .light))
                                        .foregroundColor(.black)
                                        .focused($focusedField, equals: .password)
                                        .onChange(of: focusedField) { newValue in
                                            if newValue == .password {
                                                UITextField.appearance().tintColor = .black
                                            }
                                        }
                                    
                                    Divider()
                                        .frame(
                                            height: focusedField == .password ? 1 : 0.5
                                        )
                                        .background(
                                            focusedField == .password ? .black : .gray
                                        )
                                })
                                .padding()
                                .cornerRadius(5)
                                .padding(.horizontal, 10)
                                
                            } else {
                                VStack(alignment: .leading, spacing: 2, content: {
                                    Text("Password")
                                        .fontWeight(.medium)
                                        .foregroundColor(
                                            focusedField == .password ? .black : .gray
                                        )
                                    
                                    SecureField("*******", text: $password)
                                        .font(.system(size: 20, weight: .light))
                                        .foregroundColor(.black)
                                        .focused($focusedField, equals: .password)
                                        .onChange(of: focusedField) { newValue in
                                            if newValue == .password {
                                                UITextField.appearance().tintColor = .black
                                            }
                                        }
                                    
                                    Divider()
                                        .frame(
                                            height: focusedField == .password ? 1 : 0.5
                                        )
                                        .background(
                                            focusedField == .password ? .black : .gray
                                        )
                                })
                                .padding()
                                .cornerRadius(5)
                                .padding(.horizontal, 10)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                    .background(Color(.light))
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.dark), lineWidth: 2)
                            .padding(.horizontal,20)
                    )
                    
                    Spacer().frame(height: 20)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            // Forgot Password action
                        }) {
                            Text("Forgot Password?")
                                .font(.subheadline)
                                .foregroundColor(Color(.accent).opacity(0.7))
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom,10)
                    
                    Button(action: {
                        Task {
                            do {
                                try await AuthenticationModel().login(email: email, password: password)
                                navigateToHome = true
                            } catch {
                                print("Login Failed")
                            }
                        }
                    }) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.accent))
                            .cornerRadius(5)
                            .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                }
                .background(Color(.light))
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.accent))
                    }
                    
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button(action: {
                        hideKeyboard()
                    }) {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .foregroundColor(Color(.accent))
                    }
                }
            }
        }
    }
}

#Preview {
    Login2()
}
