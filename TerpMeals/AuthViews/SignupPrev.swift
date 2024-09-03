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
    @State private var loading = false
    
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
                            .background(Color(.accent).opacity(0.8))
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
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                        
                        Button(action: {
                            // Google Sign-In Action
                            Task {
                                do {
                                    try await viewModel.signInGoogle()
                                    loading = true
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
                            .background(.white)
                            .foregroundColor(Color(.dark))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                        
                        NavigationLink(destination: Signup2(userData: userData)){
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
                            .background(.yellow)
                            .foregroundColor(Color(.dark))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                        
                    }
                    .padding(.horizontal,30)
                }
                .background(Color(.light))
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
            .disabled(loading)
        }
    }
}

#Preview {
    SignupPrev(userData: UserData())
}
