//
//  OB1View.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct OB1View: View {
    var body: some View {
        ZStack {
            // Background
            Color(red: 0.98, green: 0.98, blue: 0.98) // neutral-50
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Center Image/Vector
                Image("ob1-vector") // User will add this image in assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 367, height: 373)
                
                // Title Text
                VStack(spacing: 0) {
                    Text("Identify Plants")
                        .font(.system(size: 32, weight: .regular, design: .default))
                        .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33)) // #0c6654
                    
                    Text("Around You")
                        .font(.system(size: 32, weight: .regular, design: .default))
                        .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33))
                }
                .multilineTextAlignment(.center)
                .padding(.top, 50)
                
                Spacer()
            }
        }
    }
}

#Preview {
    OB1View()
}

