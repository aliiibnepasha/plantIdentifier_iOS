//
//  MainTabView.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    @State private var showCamera = false
    
    enum Tab {
        case home
        case diagnose
        case experts
        case garden
    }
    
    var body: some View {
        ZStack {
            // Show content based on selected tab
            Group {
                switch selectedTab {
                case .home:
                    HomeViewContent()
                case .diagnose:
                    // Diagnose view - placeholder
                    Color.white
                        .overlay(
                            Text("Diagnose View")
                                .font(.system(size: 24, weight: .bold))
                        )
                case .experts:
                    // Experts view - placeholder
                    Color.white
                        .overlay(
                            Text("Experts View")
                                .font(.system(size: 24, weight: .bold))
                        )
                case .garden:
                    MyGardenViewContent()
                }
            }
            
            // Bottom Navigation Bar - Overlay on all views
            VStack {
                Spacer()
                BottomNavBar(selectedTab: $selectedTab, showCamera: $showCamera)
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraView()
        }
    }
}

// Home View Content (without bottom nav bar)
struct HomeViewContent: View {
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
                            Image("star-icon")
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
                                    Color(red: 0.0, green: 0.52, blue: 0.39),
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
                        Image("search-icon")
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
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(Color(red: 0.05, green: 0.40, blue: 0.33))
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                            
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
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraView()
        }
    }
}

// My Garden View Content (without bottom nav bar)
struct MyGardenViewContent: View {
    @State private var selectedTab: GardenTab = .myPlants
    
    enum GardenTab {
        case myPlants
        case reminders
    }
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 0.98, green: 0.98, blue: 0.98)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                VStack(spacing: 34) {
                    // Header with title and icons
                    HStack {
                        Text("My Garden")
                            .font(.system(size: 28, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                // Search action
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                                    .frame(width: 24, height: 24)
                            }
                            
                            Button(action: {
                                // More options action
                            }) {
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    
                    // Tab Selector
                    HStack(spacing: 12) {
                        // My Plants Tab
                        Button(action: {
                            selectedTab = .myPlants
                        }) {
                            ZStack {
                                if selectedTab == .myPlants {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(red: 0.0, green: 0.52, blue: 0.39))
                                        .frame(height: 40)
                                } else {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.clear)
                                        .frame(height: 40)
                                }
                                
                                Text("My plants")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .foregroundColor(selectedTab == .myPlants ? .white : Color.black.opacity(0.5))
                            }
                            .frame(width: 113)
                        }
                        
                        // Reminders Tab
                        Button(action: {
                            selectedTab = .reminders
                        }) {
                            ZStack {
                                if selectedTab == .reminders {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(red: 0.0, green: 0.52, blue: 0.39))
                                        .frame(height: 40)
                                } else {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black.opacity(0.1), lineWidth: 1)
                                        )
                                        .frame(height: 40)
                                }
                                
                                Text("Reminders")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .foregroundColor(selectedTab == .reminders ? .white : Color(red: 0.01, green: 0.22, blue: 0.15))
                            }
                            .frame(width: 120)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 32)
                
                // Content based on selected tab
                if selectedTab == .myPlants {
                    MyPlantsView()
                } else {
                    RemindersView()
                }
            }
        }
    }
}

// Bottom Navigation Bar
struct BottomNavBar: View {
    @Binding var selectedTab: MainTabView.Tab
    @Binding var showCamera: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Navigation Bar Background
            HStack(spacing: 0) {
                // Home
                BottomNavButton(
                    icon: "home-icon",
                    title: "Home",
                    isActive: selectedTab == .home,
                    action: {
                        selectedTab = .home
                    }
                )
                
                // Diagnose
                BottomNavButton(
                    icon: "diagnose-nav-icon",
                    title: "Diagnose",
                    isActive: selectedTab == .diagnose,
                    action: {
                        selectedTab = .diagnose
                    }
                )
                
                // Spacer for camera button
                Spacer()
                    .frame(width: 60)
                
                // Experts
                BottomNavButton(
                    icon: "experts-icon",
                    title: "Experts",
                    isActive: selectedTab == .experts,
                    action: {
                        selectedTab = .experts
                    }
                )
                
                // Garden
                BottomNavButton(
                    icon: "garden-nav-icon",
                    title: "Garden",
                    isActive: selectedTab == .garden,
                    action: {
                        selectedTab = .garden
                    }
                )
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .background(Color.white)
            .shadow(color: Color(red: 0, green: 0.52, blue: 0.39).opacity(0.04), radius: 14.65, x: 0, y: -1)
            
            // Central Camera Button - Elevated above navigation bar
            Button(action: {
                showCamera = true
            }) {
                ZStack {
                    // Background Image from Assets
                    Image("camera-button-icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: 70, height: 70)
                    
                    Image(systemName: "camera.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
            }
            .offset(y: -35)
        }
    }
}

// Bottom Navigation Button
struct BottomNavButton: View {
    let icon: String
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(icon)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isActive ? Color(red: 0.01, green: 0.22, blue: 0.15) : Color(red: 0.01, green: 0.22, blue: 0.15).opacity(0.34))
                
                Text(title)
                    .font(.system(size: 12, weight: .semibold, design: .default))
                    .foregroundColor(isActive ? Color(red: 0.01, green: 0.22, blue: 0.15) : Color(red: 0.01, green: 0.22, blue: 0.15).opacity(0.34))
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainTabView()
}

