//
//  DinnerItem.swift
//  TerpMeals
//
//  Created by Eswar Karavadi on 7/10/24.
//

import SwiftUI
   
struct DinnerItem: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading, spacing: 12){
                Text("Dinner".uppercased())
                    .font(.title3.weight(.bold))
                    .matchedGeometryEffect(id: "Dinnertitle", in: namespace)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 20)
                    .matchedGeometryEffect(id: "Dinnerblur", in: namespace)
            )
            
        }
        
        .foregroundColor(.white)
        .background(
            Image("breakfast")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "Dinnerimage", in: namespace)
        )
        .background(
            Image("Background 5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "Dinnerbackground", in: namespace)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "Dinnermask", in: namespace)
        }
        .frame(height: 100)
        .padding(20)
    }
}

struct DinnerItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        DinnerItem(namespace: namespace, show: .constant(true))
    }
}
