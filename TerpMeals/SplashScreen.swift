//
//  SplashScreen.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/18/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive: Bool = false
    @State private var imageOpacity: Double = 0
    @State private var textAnimationStep: Int = 0

    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Image("LogoRemBg")
                        .resizable()
                        .frame(width: 200, height: 200)
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
                                .font(.custom("ArialRoundedMTBold", size: 28))
                                .foregroundColor(index < 4 ? .black : .red)
                                .opacity(textAnimationStep > index ? 1 : 0)
                        }
                    }
                    .onAppear {
                        animateText()
                    }
                }
                .onAppear {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(step) * 0.2) {
                withAnimation(.easeIn(duration: 0.2).delay(1)) {
                    self.textAnimationStep = step + 1
                }
            }
        }
    }
}


struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
