//
//  ContentView.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/18/24.
//

import SwiftUI
import Firebase


struct HomeView: View {
    @State private var navigateToLogin = false
    var body: some View {
        if navigateToLogin {
            Intro()
        } else {
            NavigationView {
                ScrollView {
                    VStack {
                        // Add your main content here
                        ForEach(0..<20) { index in
                            Text("Item \(index)")
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding()
                        }
                    }
                    .navigationBarTitle("TerpMeals")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(
                        leading: Button(action: {
                            do {
                                try Auth.auth().signOut()
                                navigateToLogin = true
                            } catch let signOutError as NSError {
                                print(signOutError)
                            }
                        }) {
                            Text("Sign Out")
                        },
                        trailing: Button(action: {
                            // Action for plus button
                        }) {
                            Image(systemName: "person.circle")
                        }
                    )
                }
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollViewOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
                    }
                )
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    withAnimation {
                        if value < 0 {
                            // Modify the header appearance based on scroll value
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
            .tint(.blue)
        }
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: Value = 0
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
