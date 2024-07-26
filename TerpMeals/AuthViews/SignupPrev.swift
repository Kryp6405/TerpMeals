//
//  SignupPrev.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/13/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignupPrev: View {
    @ObservedObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = LoginModel()
    @State private var navigateToHome = false
    
    var body: some View {
        if navigateToHome {
            HomeView()
        } else {
            NavigationStack {
                VStack {
                    Spacer()
                    
                    Text("Let's get you your personalized UMD dining plan!")
                    Text("Sign up for free today")
                    
                    VStack(spacing: 15) {
                        Button(action: {
                            // UMD Sign-in action
                        }) {
                            HStack {
                                Image("UMD")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                                Text("CONTINUE WITH DIRECTORY ID")
                                    .font(.system(size: 14, weight: .light, design: .default))
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                        
                        Button(action: {
                            // Apple Sign-in action
                        }) {
                            HStack {
                                Image(systemName: "applelogo") // Apple logo placeholder
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height:20)
                                Text("CONTINUE WITH APPLE")
                                    .font(.system(size: 14, weight: .light, design: .default))
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                        
                        Button(action: {
                            // Google Sign-In Action
                            Task {
                                do {
                                    try await viewModel.signInGoogle()
                                    @StateObject var authModel = AuthenticationModel()
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
                                } catch {
                                    print(error)
                                }
                            }
                        }){
                            HStack {
                                Image("Google") // Google logo placeholder
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                                
                                Text("CONTINUE WITH GOOGLE")
                                    .font(.system(size: 14, weight: .light, design: .default))
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                        
                        NavigationLink(destination: Signup()){
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 16)
                                Text("CONTINUE WITH EMAIL")
                                    .font(.system(size: 14, weight: .light, design: .default))
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                        
                    }
                    .padding(.horizontal,30)
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
                                .foregroundColor(.red)
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
        }
    }
}

#Preview {
    SignupPrev(userData: UserData())
}
