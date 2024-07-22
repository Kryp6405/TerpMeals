//
//  MealView.swift
//  TerpMeals
//
//  Created by Eswar Karavadi on 7/5/24.
//

import SwiftUI

struct MealView: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    
    var body: some View {
        ZStack {
            
            
            ScrollView {
                cover
            }
            .ignoresSafeArea()
            
            closeButton
        }
        .background(Color.white)
        
    }
    
    var cover: some View {
        VStack{
            Spacer()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        
        .frame(height: 500)
        
        .foregroundColor(.black)
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
        .overlay(
            VStack(alignment: .leading, spacing: 12){
                Text("meal of the day".uppercased())
                    .font(.title3.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .matchedGeometryEffect(id: "blur", in: namespace)
                )
                .offset(y: 150)
                .padding(20)
        )
    }
    
    var closeButton: some View {
        Button{
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                show.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
                
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .topTrailing)
        .padding([.trailing], 20)
        
    }
}

struct MealView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        MealView(namespace: namespace, show: .constant(true))
    }
}
