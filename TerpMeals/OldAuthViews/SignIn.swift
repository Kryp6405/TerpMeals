//
//  SignIn.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/19/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

@MainActor
final class SignInModel: ObservableObject{
    
    func signInGoogle() async throws {
        
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}

struct SignIn: View {
    @State private var clickedSignUp: Bool = false
    @State private var openHome: Bool = false
    @State private var showSignInView: Bool = true
    
    var body: some View {
        if(clickedSignUp){
            SignUp()
        } else if(openHome){
            HomeView()
        } else{
            VStack {
                HeaderView()
                
                VStack {
                    Spacer()
                    
                    OptionsView(openHome: $openHome, showSignInView: $showSignInView)
                    
                    Spacer()
                    
                    HStack {
                        Text("Don't have an account?")
                        Button(action: {
                            clickedSignUp = true
                        }) {
                            Text("Sign up")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.bottom, 20)
                } .background(.gray.opacity(0.10))
                
            }
            .background(Color.white)
        }
    }
    
    /*func authUser(username: String, password: String){
        if username == "KrisR64" {
            wrongUsername = 0
            if password == "Test@1008" {
                wrongPassword = 0
                showSignIn = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
     
     VStack(alignment: .leading) {
         Text("EMAIL")
             .font(.caption)
             .foregroundColor(.gray)
         TextField("email@example.com", text: $email)
             .padding()
             .background(Color(.systemGray6))
             .cornerRadius(10)
             .padding(.bottom, 10)
         
         Text("PASSWORD")
             .font(.caption)
             .foregroundColor(.gray)
         SecureField("Password", text: $password)
             .padding()
             .background(Color(.systemGray6))
             .cornerRadius(10)
     }
     .padding(.horizontal)
     
     HStack {
         Spacer()
         Button("FORGOT?") {
             // Forgot password action
         }
         .font(.caption)
         .foregroundColor(.red)
     }
     .padding(.horizontal)
     .padding(.top, 5)
     
     */
}

struct OptionsView: View {
    @Binding var openHome: Bool
    @StateObject private var viewModel = SignInModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Sign In")
                        .bold()
                        .font(.largeTitle)
                        .padding(.bottom,5)
                    Text("Please sign in to continue.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 50)
            
            VStack(spacing: 15) {
                Button(action: {
                    // UMD Sign-in action
                }) {
                    HStack {
                        Image("UMD") // UMD logo placeholder
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Sign in with Directory ID")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }
                
                Button(action: {
                    // Google Sign-In Action
                    Task {
                        do {
                            try await viewModel.signInGoogle()
                            showSignInView = false
                            openHome = true
                        } catch {
                            print(error)
                        }
                    }
                }) {
                    HStack {
                        Image("Google") // Google logo placeholder
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("Sign in with Google")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }
                
                Button(action: {
                    // Apple Sign-in action
                }) {
                    HStack {
                        Image(systemName: "applelogo") // Apple logo placeholder
                        Text("Sign in with Apple")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }
            }
            .padding(.horizontal,30)
            
            Text("- OR -")
                .foregroundColor(.gray)
                .padding(.vertical)
            
            Button(action: {
                openHome = true
            }) {
                HStack {
                    Image(systemName: "phone.fill") // Apple logo placeholder
                    Text("One-Time Passkey")
                        .fontWeight(.bold)
                }
                    .fontWeight(.bold)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(.green.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal,30)
            .shadow(radius: 3)
        }
        .padding(.vertical, 30)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

struct Login: View {
    @StateObject private var viewModel = SignInModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var navigateToHome = false
    @FocusState private var focusedField: Field?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
                                    try await AuthenticationModel().login(email: email, password: password)
                                } catch {
                                    
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
                            .foregroundColor(Color(.accent))
                    }
                }
            }
        }
    }
}

#Preview {
    SignIn()
}
