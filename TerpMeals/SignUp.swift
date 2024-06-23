//
//  SignUp.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/19/24.
//

import SwiftUI

struct SignUp: View {
    @State private var val: String = ""
    @State private var clickedSignIn: Bool = false
    @State private var clickedSignUp: Bool = false
    
    var body: some View {
        if(clickedSignIn){
            SignIn()
        } else if(clickedSignUp) {
          HomeView()
        } else {
            VStack {
                HeaderView()
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    InputView(clickedSignUp: $clickedSignUp)
                    
                    Spacer()
                    
                    HStack {
                        Text("Already have an account?")
                        Button(action: {
                            clickedSignIn = true
                        }) {
                            Text("Sign in")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .background(.gray.opacity(0.10))
            }
        }
    }
}

struct InputView: View {
    @Binding var clickedSignUp: Bool
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var gender: String = "Select Gender"
    @State private var age: Int = 18
    @State private var weight: Double = 0.0
    @State private var weightUnit: String = "lbs"
    @State private var heightFeet: Int = 5
    @State private var heightInches: Int = 8
    @State private var heightCm: Double = 0.0
    @State private var preferredDiningHall: String = "Select Dining Hall"
    @State private var useImperial: Bool = true
    
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
                TextField("John Williams", text: $firstName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                
                Text("EMAIL")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("email@example.com", text: $lastName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                
                Text("PASSWORD")
                    .font(.caption)
                    .foregroundColor(.gray)
                SecureField("Password", text: $firstName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                
                Text("CONFIRM PASSWORD")
                    .font(.caption)
                    .foregroundColor(.gray)
                SecureField("Confirm Password", text: $lastName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                Button(action: {
                    clickedSignUp = true
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
        }
        .padding(.vertical, 30)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SignUp()
}
