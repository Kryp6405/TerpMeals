//
//  Signup.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/4/24.
//

import SwiftUI
import FirebaseAuth

struct Signup: View {
    @StateObject private var viewModel = SignInModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var confirm_password: String = ""
    @State private var showConfirmPassword: Bool = false
    @State private var userSignedUp = false
    @FocusState private var focusedField: Field?
    @State private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    var body: some View {
        if userSignedUp {
            UserForm()
                .onDisappear {
                    signOutAndDeleteUser { error in
                        if let error = error {
                            print("Error signing out and deleting user: \(error)")
                        }
                    }
                }
        } else {
            content
        }
    }
    
    var content: some View {
        VStack {
            GeometryReader { geo in
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: geo.size.width, height: geo.size.height * 2 / 3)
                        .offset(y: -geo.safeAreaInsets.top)
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text("Join Us Today!")
                                .font(.title)
                                .fontWeight(.light)
                                .foregroundColor(.white.opacity(0.75))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        HStack {
                            Text("Sign Up")
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
                            
                            HStack {
                                if showConfirmPassword {
                                    VStack(alignment: .leading, spacing: 2, content: {
                                        Text("Confirm Password")
                                            .fontWeight(.medium)
                                            .foregroundColor(
                                                focusedField == .confirm_password ? .black : .gray
                                            )

                                        TextField("*******", text: $confirm_password)
                                            .font(.system(size: 20, weight: .light))
                                            .foregroundColor(.black)
                                            .focused($focusedField, equals: .password)
                                            .onChange(of: focusedField) { newValue in
                                                if newValue == .confirm_password {
                                                    UITextField.appearance().tintColor = .black
                                                }
                                            }
                                        
                                        Divider()
                                            .frame(
                                                height: focusedField == .confirm_password ? 1 : 0.5
                                            )
                                            .background(
                                                focusedField == .confirm_password ? .black : .gray
                                            )
                                    })
                                    .padding()
                                    .cornerRadius(5)
                                    .padding(.horizontal, 10)
                                    
                                } else {
                                    VStack(alignment: .leading, spacing: 2, content: {
                                        Text("Confirm Password")
                                            .fontWeight(.medium)
                                            .foregroundColor(
                                                focusedField == .confirm_password ? .black : .gray
                                            )

                                        SecureField("*******", text: $confirm_password)
                                            .font(.system(size: 20, weight: .light))
                                            .foregroundColor(.black)
                                            .focused($focusedField, equals: .confirm_password)
                                            .onChange(of: focusedField) { newValue in
                                                if newValue == .confirm_password {
                                                    UITextField.appearance().tintColor = .black
                                                }
                                            }
                                        
                                        Divider()
                                            .frame(
                                                height: focusedField == .confirm_password ? 1 : 0.5
                                            )
                                            .background(
                                                focusedField == .confirm_password ? .black : .gray
                                            )
                                    })
                                    .padding()
                                    .cornerRadius(5)
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                        .padding(.vertical, 20)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 20)
                        
                        
                        Button(action: {
                            signup(email: email, password: password)
                        }) {
                            Text("Sign Up")
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
                                        userSignedUp = true
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
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button(action: {
                        hideKeyboard()
                    }) {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userSignedUp.toggle()
                }
            }
        }
        .onDisappear {
            if let handle = authStateListenerHandle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }
}

#Preview {
    Signup()
}
