//
//  ContentView.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/18/24.
//

import SwiftUI
    struct ContentView: View {
        @State private var selectedTab = 1
        @State var statusBar = false
        
        var body: some View {
            TabView(selection: $selectedTab){
                NavigationView {
                    HomeView()
                        
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(1)
                
                NavigationView {
                    SecondView()
                        .navigationTitle("Second View")
                }
                .tabItem {
                    Label("Second", systemImage: "plus")
                }
                .tag(2)
                
                NavigationView {
                    ThirdView()
                        .navigationTitle("Third View")
                }
                .tabItem {
                    Label("Third", systemImage: "person")
                }
                .tag(3)
            }
            
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
