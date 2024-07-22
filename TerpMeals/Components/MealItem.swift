//
//  MealItem.swift
//  TerpMeals
//
//  Created by Eswar Karavadi on 7/5/24.
//

import SwiftUI
   
struct MealItem: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading, spacing: 12){
                Text("meal of the day".uppercased())
                    .font(.title3.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 20)
                    .matchedGeometryEffect(id: "blur", in: namespace)
            )
            
        }
        
        
        .foregroundColor(.white)
        .background(
            Image("fast_food_15")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "image", in: namespace)
        )
        .background(
            Image("Background 5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
        .frame(height: 100)
        .padding(20)
        
    }
}

struct MealItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        MealItem(namespace: namespace, show: .constant(true))
    }
}
