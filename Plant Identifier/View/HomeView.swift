//
//  HomeView.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var showCamera = false
    
    var body: some View {
        ZStack {
            // Background
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    // PRO Button
                    Button(action: {
                        // PRO action
                    }) {
                        HStack(spacing: 4) {
                            Image("star-icon") // User will add this icon in assets
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            
                            Text("PRO")
                                .font(.system(size: 16, weight: .medium, design: .default))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.0, green: 0.52, blue: 0.39), // #008463
                                    Color(red: 0.0, green: 0.65, blue: 0.48)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(20)
                        .frame(height: 40)
                    }
                    
                    Spacer()
                    
                    // Search Icon
                    Button(action: {
                        // Search action
                    }) {
                        Image("search-icon") // User will add this icon in assets
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Main Feature Cards
                        VStack(spacing: 16) {
                            // Identify Plant Card
                            Button(action: {
                                showCamera = true
                            }) {
                                FeatureCard(
                                    icon: "camera-icon",
                                    title: "Identify",
                                    subtitle: "Plant",
                                    image: "identify-plant-image",
                                    backgroundImage: "identify-card-bg"
                                )
                            }
                            
                            // Diagnose Plant Card
                            FeatureCard(
                                icon: "stethoscope-icon",
                                title: "Diagnose",
                                subtitle: "Plant",
                                image: "diagnose-plant-image",
                                backgroundImage: "diagnose-card-bg"
                            )
                            
                            // Garden Plant Card
                            FeatureCard(
                                icon: "garden-icon",
                                title: "Garden",
                                subtitle: "Plant",
                                image: "garden-plant-image",
                                backgroundImage: "garden-card-bg"
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        // Care Tools Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Care Tools")
                                .font(.system(size: 22, weight: .semibold, design: .default))
                                .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33))
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                            
                            // Horizontal Scrollable Care Tools
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    // Reminder Card
                                    CareToolCard(
                                        icon: "reminder-icon",
                                        title: "Reminder",
                                        image: "reminder-image",
                                        backgroundImage: "reminder-card-bg"
                                    )
                                    
                                    // Light Meter Card
                                    CareToolCard(
                                        icon: "light-meter-icon",
                                        title: "Light Meter",
                                        image: "light-meter-image",
                                        backgroundImage: "light-meter-card-bg"
                                    )
                                    
                                    // Water Calculator Card
                                    CareToolCard(
                                        icon: "water-calculator-icon",
                                        title: "Water Calculator",
                                        image: "water-calculator-image",
                                        backgroundImage: "water-calculator-card-bg"
                                    )
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.bottom, 100) // Space for bottom navigation
                    }
                }
            }
            
            // Bottom Navigation Bar
            VStack {
                Spacer()
                
                ZStack(alignment: .bottom) {
                    // Navigation Bar Background
                    HStack(spacing: 0) {
                        // Home
                        BottomNavItem(icon: "home-icon", title: "Home", isActive: true)
                        
                        // Diagnose
                        BottomNavItem(icon: "diagnose-nav-icon", title: "Diagnose", isActive: false)
                        
                        // Spacer for camera button
                        Spacer()
                            .frame(width: 90)
                        
                        // Experts
                        BottomNavItem(icon: "experts-icon", title: "Experts", isActive: false)
                        
                        // Garden
                        BottomNavItem(icon: "garden-nav-icon", title: "Garden", isActive: false)
                    }
                    .frame(height: 90)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                    
                    // Central Camera Button - Elevated above navigation bar
                    Button(action: {
                        showCamera = true
                    }) {
                        ZStack {
                            // Green circular background
                            Circle()
                                .fill(Color(red: 0.05, green: 0.40, blue: 0.33))
                                .frame(width: 90, height: 90)
                                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                            
                            // Camera icon - larger size
                            Image("camera-button-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .foregroundColor(.white)
                        }
                    }
                    .offset(y: -20) // Extends above the navigation bar
                }
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraView()
        }
    }
}

// Feature Card Component
struct FeatureCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let image: String
    let backgroundImage: String
    
    var body: some View {
        ZStack {
            // Background Image
            Image(backgroundImage) // User will add background images in assets
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .clipped()
            
            HStack(spacing: 0) {
                // Left side - Icon and Text
                HStack(spacing: 12) {
                    Image(icon) // User will add icons in assets
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33))
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(title)
                            .font(.system(size: 22, weight: .semibold, design: .default))
                            .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33))
                        
                        Text(subtitle)
                            .font(.system(size: 22, weight: .regular, design: .default))
                            .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33).opacity(0.7))
                    }
                }
                .padding(.leading, 24)
                
                Spacer()
                
                // Right side - Plant Image
                Image(image) // User will add plant images in assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .padding(.trailing, 24)
            }
        }
        .frame(height: 140)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

// Care Tool Card Component
struct CareToolCard: View {
    let icon: String
    let title: String
    let image: String
    let backgroundImage: String
    
    var body: some View {
        ZStack {
            // Background Image
            Image(backgroundImage) // User will add background images in assets
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
                .clipped()
            
            VStack(alignment: .leading, spacing: 0) {
                // Icon
                HStack {
                    Image(icon) // User will add icons in assets
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33))
                    
                    Spacer()
                }
                .padding(.top, 24)
                .padding(.leading, 24)
                
                Spacer()
                
                // Image
                Image(image) // User will add images in assets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                
                // Title
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33))
                    .padding(.leading, 24)
                    .padding(.bottom, 24)
            }
        }
        .frame(width: 160, height: 160)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

// Bottom Navigation Item Component
struct BottomNavItem: View {
    let icon: String
    let title: String
    let isActive: Bool
    
    var body: some View {
        Button(action: {
            // Navigation action
        }) {
            VStack(spacing: 4) {
                Image(icon) // User will add icons in assets
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isActive ? Color(red: 0.05, green: 0.40, blue: 0.33) : .gray)
                
                Text(title)
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(isActive ? Color(red: 0.05, green: 0.40, blue: 0.33) : .gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}

