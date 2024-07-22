//
//  BreakfastItem.swift
//  TerpMeals
//
//  Created by Eswar Karavadi on 7/10/24.
//

import SwiftUI
   
struct BreakfastItem: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading, spacing: 12){
                Text("Breakfast".uppercased())
                    .font(.title3.weight(.bold))
                    .matchedGeometryEffect(id: "breakfasttitle", in: namespace)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 20)
                    .matchedGeometryEffect(id: "breakfastblur", in: namespace)
            )
            
        }
        
        .foregroundColor(.white)
        .background(
            Image("breakfast")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "breakfastimage", in: namespace)
        )
        .background(
            Image("Background 5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "breakfastbackground", in: namespace)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "breakfastmask", in: namespace)
        }
        .frame(height: 100)
        .padding(20)
    }
}

struct BreakfastItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        BreakfastItem(namespace: namespace, show: .constant(true))
    }
}
