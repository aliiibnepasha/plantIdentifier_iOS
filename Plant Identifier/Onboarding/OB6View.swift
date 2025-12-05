//
//  OB6View.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct OB6View: View {
    @Binding var showHome: Bool
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 0.98, green: 0.98, blue: 0.98) // neutral-50
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Welcome Title - Moved up
                    Text("Welcome!")
                        .font(.system(size: 36, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33)) // #0c6654
                        .padding(.top, 20)
                    
                    // Subtitle - Moved up
                    Text("Your Personal Planting Assistant")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    // Center Image/Vector - Moved up
                    Image("ob6-vector") // User will add this image in assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 367, height: 373)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    OB6View(showHome: .constant(false))
}

