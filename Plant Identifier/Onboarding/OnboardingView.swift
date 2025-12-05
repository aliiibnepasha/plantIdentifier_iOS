//
//  OnboardingView.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @Binding var showHome: Bool
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 0.98, green: 0.98, blue: 0.98)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Skip Button - Stable
                HStack {
                    Spacer()
                    Button(action: {
                        // Skip to Home
                        showHome = true
                    }) {
                        Text("Skip")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                }
                
                // Page-based Content
                TabView(selection: $currentPage) {
                    OB1View()
                        .tag(0)
                    
                    OB2View()
                        .tag(1)
                    
                    OB3View()
                        .tag(2)
                    
                    OB4View()
                        .tag(3)
                    
                    OB5View()
                        .tag(4)
                    
                    OB6View(showHome: $showHome)
                        .tag(5)
                        .allowsHitTesting(true) // Ensure OB6 is interactive
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .disabled(true) // Disable swipe, use buttons only
                
                // Bottom Section - Stable (Next Button + Indicators)
                VStack(spacing: 0) {
                    // Next/Let's Go Button
                    if currentPage < 5 {
                        Button(action: {
                            withAnimation {
                                if currentPage < 5 {
                                    currentPage += 1
                                }
                            }
                        }) {
                            ZStack {
                                Image("next-button-bg")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 313, height: 50)
                                    .clipped()
                                
                                Text("Next")
                                    .font(.system(size: 20, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 30)
                    } else {
                        // OB6 - "Let's Go" Button (handled here to ensure clickability)
                        Button(action: {
                            // Navigate to Home
                            showHome = true
                        }) {
                            ZStack {
                                Image("next-button-bg")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 313, height: 50)
                                    .clipped()
                                
                                Text("Let's Go!")
                                    .font(.system(size: 20, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 0) // Move button further up
                    }
                    
                    // Page Indicators - Animated (only for OB1-OB5, OB6 has no indicators)
                    if currentPage < 5 {
                        HStack(spacing: 10) {
                            ForEach(0..<5) { index in
                                if index == currentPage {
                                    // Active indicator - animated expand
                                    RoundedRectangle(cornerRadius: 62)
                                        .fill(Color(red: 0.0, green: 0.52, blue: 0.39))
                                        .frame(width: 30, height: 5)
                                        .transition(.scale.combined(with: .opacity))
                                } else {
                                    // Inactive indicator
                                    Circle()
                                        .fill(Color(red: 0.0, green: 0.52, blue: 0.39).opacity(0.5))
                                        .frame(width: 5, height: 5)
                                }
                            }
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 50)
                    } else {
                        // OB6 - Legal Text at bottom
                        VStack(spacing: 4) {
                            // First line
                            Text("You will be accepting our")
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundColor(.gray)
                            
                            // Second line with clickable links
                            HStack(spacing: 4) {
                                Button(action: {
                                    // Terms and services action
                                }) {
                                    Text("terms and services")
                                        .font(.system(size: 12, weight: .regular, design: .default))
                                        .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33))
                                }
                                
                                Text("and")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                    .foregroundColor(.gray)
                                
                                Button(action: {
                                    // Privacy policy action
                                }) {
                                    Text("privacy policy")
                                        .font(.system(size: 12, weight: .regular, design: .default))
                                        .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                        .padding(.bottom, 40) // Bottom padding for screen edge
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView(showHome: .constant(false))
}

