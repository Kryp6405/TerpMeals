//
//  Login.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/4/24.
//

import SwiftUI

struct Login: View {
    @StateObject private var viewModel = SignInModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var navigateToHome = false
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case email
        case password
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: geo.size.width, height: geo.size.height * 2 / 3)
                        .offset(y: -geo.safeAreaInsets.top)
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text("Welcome Back!")
                                .font(.title)
                                .fontWeight(.light)
                                .foregroundColor(.white.opacity(0.75))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        HStack {
                            Text("Log In")
                                .font(.system(size:65))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        
                        VStack {
                            VStack(alignment: .leading, spacing: 2, content: {
                                Text("Email")
                                    .fontWeight(.medium)
                                    .foregroundColor(
                                        focusedField == .email ? .red : .gray
                                    )

                                TextField("exmaple@email. com", text: $email)
                                    .font(.system(size: 20, weight: .light))
                                    .foregroundColor(.black)
                                    .autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                                    .focused($focusedField, equals: .email)
                                    .onChange(of: focusedField) { newValue in
                                        if newValue == .email {
                                            UITextField.appearance().tintColor = .red
                                        }
                                    }
                                
                                Divider()
                                    .frame(
                                        height: focusedField == .email ? 1 : 0.5
                                    )
                                    .background(
                                        focusedField == .email ? Color.red : Color.gray
                                    )
                            })
                            .padding()
                            .cornerRadius(5)
                            .padding(.horizontal, 10)
                            
                            HStack {
                                if showPassword {
                                    VStack(alignment: .leading, spacing: 2, content: {
                                        Text("Password")
                                            .fontWeight(.medium)
                                            .foregroundColor(
                                                focusedField == .password ? .red : .gray
                                            )

                                        TextField("*******", text: $password)
                                            .font(.system(size: 20, weight: .light))
                                            .foregroundColor(.black)
                                            .focused($focusedField, equals: .password)
                                            .onChange(of: focusedField) { newValue in
                                                if newValue == .password {
                                                    UITextField.appearance().tintColor = .red
                                                }
                                            }
                                        
                                        Divider()
                                            .frame(
                                                height: focusedField == .password ? 1 : 0.5
                                            )
                                            .background(
                                                focusedField == .password ? Color.red : Color.gray
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
                                                focusedField == .password ? .red : .gray
                                            )

                                        SecureField("*******", text: $password)
                                            .font(.system(size: 20, weight: .light))
                                            .foregroundColor(.black)
                                            .focused($focusedField, equals: .password)
                                            .onChange(of: focusedField) { newValue in
                                                if newValue == .password {
                                                    UITextField.appearance().tintColor = .red
                                                }
                                            }
                                        
                                        Divider()
                                            .frame(
                                                height: focusedField == .password ? 1 : 0.5
                                            )
                                            .background(
                                                focusedField == .password ? Color.red : Color.gray
                                            )
                                    })
                                    .padding()
                                    .cornerRadius(5)
                                    .padding(.horizontal, 10)
                                }
                            }
                            
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    // Forgot Password action
                                }) {
                                    Text("Forgot Password?")
                                        .font(.subheadline)
                                        .foregroundColor(.red.opacity(0.7))
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding(.bottom,10)
                        }
                        .padding(.vertical, 30)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 20)
                        
                        
                        // Log In button
                        Button(action: {
                            // Log In action
                        }) {
                            Text("Log In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(5)
                                .padding(.horizontal, 20)
                        }
                        
                        Text("- OR -")
                            .foregroundColor(.gray)
                            .padding(.vertical)
                        
                        HStack {
                            Button(action: {
                                // Google Sign-In Action
                                Task {
                                    do {
                                        try await viewModel.signInGoogle()
                                        navigateToHome = true
                                    } catch {
                                        print(error)
                                    }
                                }
                            }) {
                                HStack {
                                    Image("Google") // Google logo placeholder
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    
                                    Text("Google")
                                        .fontWeight(.bold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(5)
                                .shadow(radius: 1)
                            }
                            
                            Button(action: {
                                // UMD Sign-in action
                            }) {
                                HStack {
                                    Image("UMD") // UMD logo placeholder
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text("Directory ID")
                                        .fontWeight(.bold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .shadow(radius: 3)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 50)
                    }
                }
            }
        }
        .navigationBarHidden(false)
    }
}

#Preview {
    Login()
}
