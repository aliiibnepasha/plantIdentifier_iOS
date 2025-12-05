//
//  IdentifyView.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct IdentifyView: View {
    let image: UIImage
    @Environment(\.dismiss) var dismiss
    @State private var expandedProblem: String? = "Wilting Leaves"
    @State private var expandedFAQ: Int? = nil
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.white
                    .ignoresSafeArea()
                
                // Scrollable Content (Image + All Content)
                ScrollView {
                    VStack(spacing: 0) {
                        // Top Image Section - Scrollable
                        ZStack(alignment: .top) {
                            // Image with fixed frame - won't expand
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: 462)
                                .clipped()
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 462)
                        .clipped()
                        
                        VStack(alignment: .leading, spacing: 20) {
                            // Plant Name and Info
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Blue Sage")
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                                
                                HStack(spacing: 12) {
                                    Text("Shrub")
                                        .font(.system(size: 18, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                                    
                                    Circle()
                                        .fill(Color(red: 0.01, green: 0.22, blue: 0.15))
                                        .frame(width: 6, height: 6)
                                    
                                    Text("Eranthemum roseoum")
                                        .font(.system(size: 18, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                                }
                                
                                Button(action: {}) {
                                    Text("Not your plant?")
                                        .font(.system(size: 18, weight: .semibold, design: .default))
                                        .foregroundColor(Color(red: 0.91, green: 0.29, blue: 0.38))
                                }
                                
                                // Care Tags
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack(spacing: 12) {
                                        CareTag(text: "Moderate to care")
                                        CareTag(text: "Medium")
                                    }
                                    CareTag(text: "Flowering")
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            
                            // Health Status Card
                            HealthStatusCard()
                                .padding(.horizontal, 20)
                            
                            // About Section
                            AboutSection()
                                .padding(.horizontal, 20)
                            
                            // Details Section
                            DetailsSection()
                                .padding(.horizontal, 20)
                            
                            // Common Problems Section
                            CommonProblemsSection(expandedProblem: $expandedProblem)
                                .padding(.horizontal, 20)
                            
                            // AI Botanist Section
                            AIBotanistSection()
                                .padding(.horizontal, 20)
                            
                            // FAQ Section
                            FAQSection(expandedFAQ: $expandedFAQ)
                                .padding(.horizontal, 20)
                            
                            // Fun Facts Section
                            FunFactsSection()
                                .padding(.horizontal, 20)
                            
                            // Bottom spacing for action bar
                            Spacer()
                                .frame(height: 100)
                        }
                    }
                }
                
                // Fixed Top Bar (overlay on scrollable content)
                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(width: 24, height: 24)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding(.horizontal, 20)
                    //.padding(.top, 0)
                    .padding(.bottom, 10)
                    .background(Color.white)
                    
                    Spacer()
                }
                
                // Bottom Action Bar
                VStack {
                    Spacer()
                    BottomActionBar()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Care Tag Component
struct CareTag: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .semibold, design: .default))
            .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
            )
            .cornerRadius(10)
    }
}

// Health Status Card
struct HealthStatusCard: View {
    var body: some View {
        HStack(spacing: 20) {
            // Plant Image with icon
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 120, height: 100)
                    .blur(radius: 2)
                
                Image(systemName: "leaf.fill")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .frame(width: 52, height: 52)
                    .background(Color.black.opacity(0.16))
                    .cornerRadius(26)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Your plant may")
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                    Text("not be healthy!")
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .foregroundColor(Color(red: 0.91, green: 0.29, blue: 0.38))
                }
                
                Button(action: {}) {
                    HStack(spacing: 12) {
                        Image("diagnose-icon")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color(red: 0.91, green: 0.29, blue: 0.38))
                        Text("Diagnose")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color(red: 0.91, green: 0.29, blue: 0.38))
                    .cornerRadius(12)
                }
            }
        }
        .padding(20)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        )
        .cornerRadius(18)
    }
}

// About Section
struct AboutSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("About")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
            
            Text("Eranthemum roseum, commonly known as the rose eranthemum, is a tropical evergreen shrub with glossy green leaves and clusters of small pink flowers. It is native to India and Southeast Asia.")
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(Color.black.opacity(0.5))
                .lineSpacing(4)
            
            Button(action: {}) {
                HStack(spacing: 4) {
                    Text("Read More")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                }
            }
        }
    }
}

// Details Section
struct DetailsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Details")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
            
            VStack(alignment: .leading, spacing: 24) {
                DetailRow(icon: "temperature-icon", title: "Temperature", value: "25-30 degrees")
                DetailRow(icon: "sunlight-icon", title: "Sunlight", value: "Full sun")
                
                HStack {
                    DetailRow(icon: "water-icon", title: "Water", value: "every 4-7 days")
                    Spacer()
                    Button(action: {}) {
                        HStack(spacing: 12) {
                            Image("water-calculate-icon")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.white)
                            Text("Calculate")
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.31, green: 0.69, blue: 0.96))
                        .cornerRadius(33)
                    }
                }
                
                DetailRow(icon: "pests-icon", title: "Pests", value: "Syprus")
                DetailRow(icon: "repotting-icon", title: "Repotting", value: "every 1-2 years")
                DetailRow(icon: "fertilizing-icon", title: "Fertilizing", value: "every 1-2 months")
            }
        }
        .padding(20)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        )
        .cornerRadius(18)
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                .frame(width: 48, height: 48)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                )
                .cornerRadius(9)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                Text(value)
                    .font(.system(size: 12, weight: .semibold, design: .default))
                    .foregroundColor(Color.black.opacity(0.5))
            }
        }
    }
}

// Common Problems Section
struct CommonProblemsSection: View {
    @Binding var expandedProblem: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Common Problems")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
            
            VStack(spacing: 20) {
                ProblemItem(
                    title: "Wilting Leaves",
                    imageName: "wilting-leaves-image",
                    isExpanded: expandedProblem == "Wilting Leaves",
                    onToggle: {
                        expandedProblem = expandedProblem == "Wilting Leaves" ? nil : "Wilting Leaves"
                    }
                )
                
                ProblemItem(
                    title: "Overcrowding",
                    imageName: "overcrowding-image",
                    isExpanded: expandedProblem == "Overcrowding",
                    onToggle: {
                        expandedProblem = expandedProblem == "Overcrowding" ? nil : "Overcrowding"
                    }
                )
            }
            
            VStack(spacing: 12) {
                Text("Use diagnose to keep your plant healthy")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                
                Button(action: {}) {
                    HStack(spacing: 12) {
                        Image("diagnose-icon")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color(red: 0.91, green: 0.29, blue: 0.38))
                        Text("Diagnose")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color(red: 0.91, green: 0.29, blue: 0.38))
                    .cornerRadius(12)
                }
            }
        }
        .padding(20)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        )
        .cornerRadius(18)
    }
}

struct ProblemItem: View {
    let title: String
    let imageName: String
    let isExpanded: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: onToggle) {
                HStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 48)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text(title)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                }
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 20) {
                    if title == "Wilting Leaves" {
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("About")
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                                
                                Text("Wilting leaves usually signify underwatering, root damage, or excessive heat. When plants lack water, they lose turgor pressure, causing them to wilt.")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .padding(.top, 12)
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("How to care")
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                                
                                Text("Water the plant thoroughly and consistently, ensuring water reaches the root zone. Check soil moisture regularly and adjust watering frequency as needed. Provide shade during hot weather to prevent wilting from heat stress.")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .padding(.top, 12)
                            }
                        }
                        .padding(.top, 20)
                    } else if title == "Overcrowding" {
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("About")
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                                
                                Text("Overcrowding occurs when plants are too close together, competing for space, nutrients, light, and water. This can lead to stunted growth, poor air circulation, increased disease risk, and reduced flowering or fruiting.")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .padding(.top, 12)
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("How to care")
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                                
                                Text("Thin out crowded plants by removing excess seedlings or dividing mature plants. Ensure proper spacing between plants according to their mature size. Repot container plants into larger pots when roots become root-bound. Prune regularly to maintain adequate air circulation and prevent competition for resources.")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .padding(.top, 12)
                            }
                        }
                        .padding(.top, 20)
                    }
                }
            }
        }
    }
}

// AI Botanist Section
struct AIBotanistSection: View {
    var body: some View {
        HStack(spacing: 42) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Ask AI Botanist")
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                
                Text("Get treatment advice")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(Color.black.opacity(0.5))
                
                Button(action: {}) {
                    Text("Start Chat")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .frame(width: 181, height: 44)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.0, green: 0.70, blue: 0.52),
                                    Color(red: 0.0, green: 0.51, blue: 0.39)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(100)
                }
            }
            
            // Botanist Image
            Image("ai-botanist-profile")
                .resizable()
                .scaledToFill()
                .frame(width: 106, height: 106)
                .clipShape(Circle())
        }
        .padding(20)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        )
        .cornerRadius(18)
    }
}

// FAQ Section
struct FAQSection: View {
    @Binding var expandedFAQ: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("FAQ")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
            
            VStack(spacing: 12) {
                FAQItem(
                    question: "How often should you water Eranthemum roseum?",
                    isExpanded: expandedFAQ == 0,
                    onToggle: {
                        expandedFAQ = expandedFAQ == 0 ? nil : 0
                    }
                )
                
                Divider()
                
                FAQItem(
                    question: "What is the best sunlight condition for Eranthemum roseum?",
                    isExpanded: expandedFAQ == 1,
                    onToggle: {
                        expandedFAQ = expandedFAQ == 1 ? nil : 1
                    }
                )
                
                Divider()
                
                FAQItem(
                    question: "When should I repot my Eranthemum roseum?",
                    isExpanded: expandedFAQ == 2,
                    onToggle: {
                        expandedFAQ = expandedFAQ == 2 ? nil : 2
                    }
                )
            }
        }
    }
}

struct FAQItem: View {
    let question: String
    let isExpanded: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: onToggle) {
                HStack {
                    Text(question)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                }
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    if question == "How often should you water Eranthemum roseum?" {
                        Text("Eranthemum roseum should be watered when the top inch of soil feels dry to the touch. Generally, this means watering every 4-7 days during the growing season, depending on temperature and humidity. Reduce watering frequency in winter when the plant is dormant. Always ensure proper drainage to prevent root rot.")
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundColor(Color.black.opacity(0.5))
                            .padding(.top, 12)
                    } else if question == "What is the best sunlight condition for Eranthemum roseum?" {
                        Text("Eranthemum roseum thrives in full sun to partial shade. It prefers bright, indirect light for at least 4-6 hours daily. In very hot climates, provide some afternoon shade to prevent leaf scorching. The plant will produce more flowers when it receives adequate sunlight.")
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundColor(Color.black.opacity(0.5))
                            .padding(.top, 12)
                    } else if question == "When should I repot my Eranthemum roseum?" {
                        Text("Repot Eranthemum roseum every 1-2 years, preferably in spring before the growing season begins. Signs that repotting is needed include roots growing out of drainage holes, slowed growth, or the plant becoming top-heavy. Choose a pot that is 1-2 inches larger in diameter than the current one.")
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundColor(Color.black.opacity(0.5))
                            .padding(.top, 12)
                    }
                }
            }
        }
    }
}

// Fun Facts Section
struct FunFactsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Fun Facts")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.01, green: 0.22, blue: 0.15))
            
            VStack(alignment: .leading, spacing: 24) {
                FunFactItem(
                    text: "Eranthemum roseum flowers don't have much scent during the day, but they are very fragrant in the evening"
                )
                
                FunFactItem(
                    text: "Eranthemum roseum flowers don't have much scent during the day, but they are very fragrant in the evening"
                )
            }
        }
        .padding(20)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        )
        .cornerRadius(18)
    }
}

struct FunFactItem: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "sparkles")
                .font(.system(size: 20))
                .foregroundColor(Color(red: 0.0, green: 0.52, blue: 0.39))
                .frame(width: 48, height: 48)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                )
                .cornerRadius(9)
            
            Text(text)
                .font(.system(size: 18, weight: .semibold, design: .default))
                .foregroundColor(Color.black.opacity(0.5))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// Bottom Action Bar
struct BottomActionBar: View {
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {}) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 67)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    )
                    .cornerRadius(67)
            }
            
            Button(action: {}) {
                HStack(spacing: 34) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                    Text("Add to My Plants")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color(red: 0.0, green: 0.52, blue: 0.39))
                .cornerRadius(100)
            }
        }
    }
}

#Preview {
    IdentifyView(image: UIImage(systemName: "leaf.fill")!)
}

