//
//  SplashScreen.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/18/24.
//

import SwiftUI
import Firebase

struct SplashScreen: View {
    @State private var isActive: Bool = false
    @State private var isSignedIn: Bool = false
    @State private var imageOpacity: Double = 0
    @State private var textAnimationStep: Int = 0

    var body: some View {
        if isActive {
            if isSignedIn {
                HomeView()
            } else {
                Intro()
            }
            
//            Intro()
        } else {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Image("LogoRemBg")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .opacity(imageOpacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2).delay(1)) {
                                self.imageOpacity = 1.0
                            }
                        }
                    
                    HStack(spacing: 0) {
                        ForEach(Array("TerpMeals").indices, id: \.self) { index in
                            let letter = Array("TerpMeals")[index]
                            Text(String(letter))
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(index < 4 ? .black : .red)
                                .opacity(textAnimationStep > index ? 1 : 0)
                        }
                    }
                    .onAppear {
                        animateText()
                    }
                }
                .onAppear {
                    checkAuthStatus()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }

    func animateText() {
        let totalSteps = Array("TerpMeals").count
        for step in 0..<totalSteps {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(step) * 0.13) {
                withAnimation(.easeIn(duration: 0.2).delay(1)) {
                    self.textAnimationStep = step + 1
                }
            }
        }
    }
    
    private func checkAuthStatus() {
            // Simulate a delay for the splash screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                if let _ = Auth.auth().currentUser {
                    self.isSignedIn = true
                } else {
                    self.isSignedIn = false
                }
            }
        }
}


struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
