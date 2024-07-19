//
//  SignupPrev.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/13/24.
//

import SwiftUI

struct SignupPrev: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
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

#Preview {
    SignupPrev()
}
