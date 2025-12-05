//
//  MyGardenView.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct MyGardenView: View {
    @State private var selectedTab: GardenTab = .myPlants
    
    enum GardenTab {
        case myPlants
        case reminders
    }
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 0.98, green: 0.98, blue: 0.98) // #FAFAFA
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                VStack(spacing: 34) {
                    // Header with title and icons
                    HStack {
                        Text("My Garden")
                            .font(.system(size: 28, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15)) // #033826
                        
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
                                        .fill(Color(red: 0.0, green: 0.52, blue: 0.39)) // #008463
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
                                        .fill(Color(red: 0.0, green: 0.52, blue: 0.39)) // #008463
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
            
            // Bottom Navigation Bar will be handled by MainTabView
        }
    }
}

// My Plants View (Empty State)
struct MyPlantsView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            VStack(spacing: 12) {
                Text("No plants in your library")
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                    .multilineTextAlignment(.center)
                
                Text("Tap to add your first plant")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                // Add plant action
            }) {
                HStack(spacing: 12) {
                    Text("+")
                        .font(.system(size: 33, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    Text("Add Plant")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color(red: 0.0, green: 0.52, blue: 0.39))
                .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}

// Reminders View (Empty State)
struct RemindersView: View {
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            VStack(spacing: 12) {
                Text("No reminders")
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                    .multilineTextAlignment(.center)
                
                Text("Tap to add your first reminder")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                // Add reminder action
            }) {
                HStack(spacing: 12) {
                    Image(systemName: "bell.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    
                    Text("Add Reminder")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color(red: 0.0, green: 0.52, blue: 0.39))
                .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}


#Preview {
    MyGardenView()
}

