//
//  ContentView.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/18/24.
//

import SwiftUI


struct HomeView: View {
    var body: some View {
        VStack {
            Text("Welcome [User]!")
                .font(.largeTitle)
                .bold()
            Text("This is the First View")
        }
        .padding()
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Text("This is the Second View")
        }
        .padding()
    }
}

struct ThirdView: View {
    var body: some View {
        VStack {
            Text("This is the Third View")
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab){
            NavigationView {
                HomeView()
                    .navigationTitle("First View")
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
