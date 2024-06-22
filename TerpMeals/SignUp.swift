//
//  SignUp.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/19/24.
//

import SwiftUI

struct SignUp: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("FULL NAME")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("John Williams", text: $fullName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                
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
                    .padding(.bottom, 10)
                
                Text("CONFIRM PASSWORD")
                    .font(.caption)
                    .foregroundColor(.gray)
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                Button(action: {
                    // Sign Up action
                }) {
                    HStack {
                        Text("Sign Up")
                            .fontWeight(.bold)
                        Image(systemName: "arrow.right")
                            .font(Font.system(size: 16, weight: .bold))
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(50)
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            Spacer()
            
            HStack {
                Text("Already have an account?")
                Button(action: {
                    // Navigate to sign in
                }) {
                    Text("Sign in")
                        .foregroundColor(.red)
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color.white)
    }
}

#Preview {
    SignUp()
}
