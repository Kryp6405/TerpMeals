//
//  Intro.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/4/24.
//

import SwiftUI
import Firebase
import FirebaseAuth



//MARK: Intro View
struct Intro: View {
    @State private var showLoginOptions: Bool = false
    @State private var navigateOnLogin: Bool = false
    @State private var navigateToHome: Bool = false
    
    var body: some View {
        if navigateToHome  {
            HomeView()
        } else {
            NavigationStack {
                VStack {
                    Spacer()
                    
                    // MARK: Image
                    Image("Intro")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 250)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 30)
                    
                    // MARK: Company + Tagline
                    Text("welcome to")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.black.opacity(0.8))
                    
                    LogoText()
                        .padding(.bottom, 5)
                    
                    Text("Your Campus Meal Companion")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black.opacity(0.7))
                        .padding(.bottom, 20)
                    
                    Text("Discover and track your meals at the dining hall. Join our community and start your wellnesss journey today!")
                        .font(.system(size: 12, weight: .light, design: .default))
                        .foregroundColor(.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 30)
                    
                    // MARK: Auth Buttons
                    HStack {
                        NavigationLink(destination: Q1(userData: UserData())) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 140, height: 50)
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                        .padding(.horizontal, 10)
                        
                        Button(action: {
                            showLoginOptions.toggle()
                        }) {
                            Text("Log In")
                                .font(.headline)
                                .foregroundColor(.red)
                                .frame(width: 140, height: 50)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.red, lineWidth: 2)
                                )
                        }
                        .padding(.horizontal, 10)
                        .sheet(isPresented: $showLoginOptions){
                            LoginSheet(showLoginOptions: $showLoginOptions, navigateOnLogin: $navigateOnLogin, navigateToHome: $navigateToHome)
                                .presentationDetents([.fraction(0.6)])
                                .presentationDragIndicator(.visible)
                                .presentationCornerRadius(25)
                        }
                        
                        NavigationLink(destination: Login(), isActive: $navigateOnLogin) {
                            EmptyView()
                        }
                        
                    }
                    
                    Spacer().frame(height: 40)
                }
            }
            .background(.ultraThickMaterial)
        }
    }
}

//MARK: LoginSheet View
struct LoginSheet: View {
    @Binding var showLoginOptions: Bool
    @Binding var navigateOnLogin: Bool
    @Binding var navigateToHome: Bool
    @StateObject private var viewModel = LoginModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Log In")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.8))
            
            Spacer()
            
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
                                        showLoginOptions = false
                                        navigateToHome = true
                                    } else {
                                        print("User exists but UID is nil.")
                                    }
                                } else {
                                    print("User does not exist in the database.")
                                    authModel.signOutAndDeleteUser { error in
                                        if let error = error {
                                            print("Error signing out and deleting user: \(error)")
                                            return
                                        }
                                    }
                                    // tell user to signup
                                }
                            }
                        } catch {
                            print(error)
                        }
                    }
                }) {
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
                
                Button(action: {
                    navigateOnLogin.toggle()
                    showLoginOptions.toggle()
                }){
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
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                }

            }
            .padding(.horizontal,30)
            
            Spacer().frame(height: 30)
        }
        .background(.ultraThickMaterial)
        .navigationBarBackButtonHidden(true)
    }
}


//MARK: Preview
#Preview {
    Intro()
}
