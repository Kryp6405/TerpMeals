//
//  SignIn.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/19/24.
//

import SwiftUI

struct SignIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
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
            .padding(.top, 20)
            
            Spacer()
                .frame(height: 40)
                        
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
            
            Button(action: {
                ContentView()
            }) {
                Text("LOGIN")
                    .fontWeight(.bold)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            Text("- OR -")
                .foregroundColor(.gray)
                .padding(.vertical)
            
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
                    .background(Color.red.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Button(action: {
                    // Google Sign-in action
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
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
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
                }
            }
            .padding(.horizontal)


            Spacer()
            
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    // Navigate to sign up
                }) {
                    Text("Sign up")
                        .foregroundColor(.red)
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color.white)
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
    }*/
}

#Preview {
    SignIn()
}
