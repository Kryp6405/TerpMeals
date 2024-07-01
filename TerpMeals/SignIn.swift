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

#Preview {
    SignIn()
}
