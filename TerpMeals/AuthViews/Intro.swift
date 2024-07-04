//
//  Intro.swift
//  TerpMeals
//
//  Created by Krisnajit S Rajeshkhanna on 7/4/24.
//

import SwiftUI

struct Intro: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 30)
                
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
                
                HStack {
                    NavigationLink(destination: Signup()) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 140, height: 50)
                            .background(Color.red)
                            .cornerRadius(5)
                    }
                    .padding(.horizontal, 10)
                    
                    NavigationLink(destination: Login()) {
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
                }
                
                Spacer().frame(height: 40)
            }
        }
        .tint(.white)
    }
}


#Preview {
    Intro()
}
