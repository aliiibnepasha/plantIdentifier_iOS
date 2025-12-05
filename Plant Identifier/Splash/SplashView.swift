//
//  SplashView.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var displayedP = false
    @State private var displayedLANT = ""
    @State private var displayedIdentifier = ""
    @State private var showSubtitle = false
    @State private var navigateToOnboarding = false
    
    private let lantText = "LANT"
    private let identifierText = "identifier"
    private let subtitle = "Your Own Planting Assistant"
    
    var body: some View {
        ZStack {
            // Background Image - Full Screen
            Image("splash-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // Text Overlay - Right side positioning
            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                    .frame(height: 320)
                
                // Text Content Container
                VStack(alignment: .leading, spacing: 0) {
                    // Main Title Section
                    HStack(alignment: .top, spacing: 0) {
                        // Large "P"
                        if displayedP {
                            Text("P")
                                .font(.system(size: 96, weight: .bold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        // "LANT" and "identifier" in VStack
                        VStack(alignment: .leading, spacing: 0) {
                            // "LANT" text - moved down
                            if !displayedLANT.isEmpty {
                                Text(displayedLANT)
                                    .font(.system(size: 32, weight: .semibold, design: .default))
                                    .foregroundColor(.black)
                                    .padding(.top, 20)
                            }
                            
                            // "identifier" text on new line - minimal space with "LANT"
                            if !displayedIdentifier.isEmpty {
                                Text(displayedIdentifier)
                                    .font(.system(size: 32, weight: .semibold, design: .default))
                                    .foregroundColor(.black)
                                    .padding(.top, -2)
                            }
                        }
                        .padding(.leading, 8)
                    }
                    .padding(.bottom, 0)
                    
                    // Subtitle - aligned with "P", very close to "identifier"
                    if showSubtitle {
                        Text(subtitle)
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.top, 0)
                            .transition(.opacity)
                    }
                }
                .padding(.trailing, 30)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .onAppear {
            startTypingAnimation()
            // Navigate to onboarding after 3-4 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                navigateToOnboarding = true
            }
        }
        .fullScreenCover(isPresented: $navigateToOnboarding) {
            ContentView()
        }
    }
    
    private func startTypingAnimation() {
        // Show "P" first
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                displayedP = true
            }
            
            // Start typing "LANT"
            typeLANT()
        }
    }
    
    private func typeLANT() {
        var index = 0
        Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { timer in
            if index < lantText.count {
                let charIndex = lantText.index(lantText.startIndex, offsetBy: index)
                displayedLANT = String(lantText[...charIndex])
                index += 1
            } else {
                timer.invalidate()
                // Start typing "identifier" after "LANT" is complete
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    typeIdentifier()
                }
            }
        }
    }
    
    private func typeIdentifier() {
        var index = 0
        Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { timer in
            if index < identifierText.count {
                let charIndex = identifierText.index(identifierText.startIndex, offsetBy: index)
                displayedIdentifier = String(identifierText[...charIndex])
                index += 1
            } else {
                timer.invalidate()
                // Show subtitle after all text is complete
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        showSubtitle = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}

