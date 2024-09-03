//
//  Signup.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/4/24.
//

import SwiftUI
import FirebaseAuth

struct Signup2: View {
    @StateObject private var viewModel = SignInModel()
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var confirm_password: String = ""
    @State private var showConfirmPassword: Bool = false
    @State private var navigateToHome = false
    @ObservedObject var userData: UserData
    @FocusState private var focusedField: Field?
    @State private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if navigateToHome {
            HomeView()
        } else {
            NavigationStack {
                VStack {
                    Spacer()
                    
                    HStack {
                        Text("Join Us Today!")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(Color(.dark).opacity(0.75))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Text("Sign Up")
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
                    
                    VStack {
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
                                if(password == confirm_password){
                                    @StateObject var authModel = AuthenticationModel()
                                    try await authModel.signUp(email: email, password: confirm_password)
                                    navigateToHome = true
                                    authModel.checkUserExists { exists, uid in
                                        if exists {
                                            if let uid = uid {
                                                print("User with UID \(uid) exists in the database.")
                                                authModel.signOut()
                                                //tell user to login
                                            } else {
                                                print("User exists but UID is nil.")
                                            }
                                        } else {
                                            print("User does not exist in the database.")
                                            authModel.saveUserInfo(userData: userData) { error in
                                                if let error = error {
                                                    // Handle the error
                                                    print("Error saving user info: \(error.localizedDescription)")
                                                } else {
                                                    navigateToHome = true
                                                    print("User info saved successfully!")
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    print("Passwords Don't Match")
                                }
                            } catch {
                                print("Sign Up Failed")
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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if userSignedUp {
            UserForm()
                .onDisappear {
                    AuthenticationModel().signOutAndDeleteUser { error in
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
                        .fill(Color(.accent))
                        .frame(width: geo.size.width, height: geo.size.height * 1 / 2 + geo.safeAreaInsets.top)
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
                                Text("First Name")
                                    .fontWeight(.medium)
                                    .foregroundColor(
                                        focusedField == .confirm_password ? .black : .gray
                                    )

                                TextField("John", text: $confirm_password)
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
                        }
                        .padding(.vertical, 20)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 20)
                        
                        Spacer().frame(height: 20)  
                        
                        Button(action: {
                            Task {
                                do {
                                    try await AuthenticationModel().signUp(email: email, password: password)
                                } catch {
                                    
                                }
                            }
                        }) {
                            Text("Sign Up")
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
                }
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
                            .foregroundColor(.white)
                    }
                    
                }
                
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
    Signup2(userData: UserData())
}
