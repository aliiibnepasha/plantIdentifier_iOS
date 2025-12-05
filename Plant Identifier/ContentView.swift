//
//  ContentView.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showHome = false
    
    var body: some View {
        if showHome {
            HomeView()
        } else {
            OnboardingView(showHome: $showHome)
        }
    }
}

#Preview {
    ContentView()
}

