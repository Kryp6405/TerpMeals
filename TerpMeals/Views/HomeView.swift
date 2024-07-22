//
//  HomeView.swift
//  TerpMeals
//
//  Created by Eswar Karavadi on 7/5/24.
//

import SwiftUI

struct HomeView: View {
    @Namespace var meal
    @Namespace var breakfast
    @Namespace var lunch
    @Namespace var dinner
    @State var Mealshow = false
    @State var Breakfastshow = false
    @State var Lunchshow = false
    @State var Dinnershow = false

    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            ZStack{
                ScrollView {
                    
                    VStack(spacing: 20){
                        
                        headerText
                        
                        if !Mealshow{
                             MealItem(namespace: meal, show: $Mealshow)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                                        //Mealshow.toggle()
                                        print("meal")
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 100) // Ensure a specific height
                                .border(Color.green)
                                .shadow(radius: 10)
                        }
                        
                        if !Breakfastshow {
                            BreakfastItem(namespace: breakfast, show: $Breakfastshow)
                               .onTapGesture {
                                   withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                                       Breakfastshow.toggle()
                                       print("breakfast")
                                   }
                               }
                               .frame(maxWidth: .infinity)
                               .frame(height: 100) // Ensure a specific height
                               .border(Color.black)
                               .shadow(radius: 10)
                           
                        }
                        
                        if !Lunchshow {
                            LunchItem(namespace: lunch, show: $Lunchshow)
                               .onTapGesture {
                                   withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                                       Lunchshow.toggle()
                                       print("lunch")
                                   }
                               }
                               .frame(maxWidth: .infinity)
                               .frame(height: 100) // Ensure a specific height
                               .border(Color.black)
                               .shadow(radius: 10)
                           
                        }
                        
                        if !Dinnershow {
                            DinnerItem(namespace: dinner, show: $Dinnershow)
                               .onTapGesture {
                                   withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                                       Dinnershow.toggle()
                                       print("lunch")
                                   }
                               }
                               .frame(maxWidth: .infinity)
                               .frame(height: 100) // Ensure a specific height
                               .border(Color.black)
                               .shadow(radius: 10)
                           
                        }
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("Main Color"), Color("Background Color")]),
                            startPoint: .init(x: 0.5, y: 330 / height),
                            endPoint: .init(x: 0.5, y: 355 / height)
                        )
                        .ignoresSafeArea()
                    )
                    
                    
                    
                    //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                }
                //.background(Color("Main Color"))
                
                
                .ignoresSafeArea()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                
                
                
                
                if Mealshow{
                    MealView(namespace: meal, show: $Mealshow)
                        
                }
                if Breakfastshow{
                    BreakfastView(namespace: breakfast, show: $Breakfastshow)
                        
                }
                if Lunchshow{
                    LunchView(namespace: lunch, show: $Lunchshow)
                        
                }
                if Dinnershow{
                    DinnerView(namespace: dinner, show: $Dinnershow)
                        
                }
            }
        }
    }
}

var headerText: some View {
    HStack{
        Text("eaten")
            .font(.title3.weight(.bold))
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding([.leading], 40)
        Text("calories")
            .font(.title3.weight(.bold))
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        Text("burned")
            .font(.title3.weight(.bold))
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            .padding([.trailing], 40)
    }
    .offset(y:90)
    .frame(maxWidth: .infinity)
    .frame(height: 300)
    .foregroundColor(.white)
    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


