//
//  HeaderView.swift
//  TerpMeals
//
//  Created by krisnajit Rajeshkhanna on 6/23/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            Image("LogoRemBg")
                .resizable()
                .frame(width: 35, height: 35)
            LogoText()
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 20)
        
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.black.opacity(0.2))
    }
}

struct LogoText: View {
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array("TerpMeals").indices, id: \.self) { index in
                let letter = Array("TerpMeals")[index]
                Text(String(letter))
                    .font(.system(size:52))
                    .fontWeight(.bold)
                    .foregroundColor(index < 4 ? .black : .red)
            }
        }
    }
}

/*#Preview {
    HeaderView()
}*/
