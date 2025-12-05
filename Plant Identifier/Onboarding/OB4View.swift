//
//  OB4View.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct OB4View: View {
    var body: some View {
        ZStack {
            // Background
            Color(red: 0.98, green: 0.98, blue: 0.98) // neutral-50
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Center Image/Vector
                Image("ob4-vector") // User will add this image in assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 345, height: 514)
                
                Spacer()
            }
        }
    }
}

#Preview {
    OB4View()
}

