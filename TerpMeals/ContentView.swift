//
//  ContentView.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/18/24.
//

import SwiftUI


struct HomeView: View {
    var body: some View {
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
                .navigationBarItems(trailing: Button(action: {
                    // Action for plus button
                }) {
                    Image(systemName: "person.circle")
                })
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
    }
}

struct CustomTabView: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                // Action for home button
            }) {
                Image(systemName: "house.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
            }
            Spacer()
            Button(action: {
                // Action for plus button
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(.bottom, 20)
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
