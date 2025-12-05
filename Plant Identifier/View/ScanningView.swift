//
//  ScanningView.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI

struct ScanningView: View {
    let image: UIImage
    @State private var scanningOffset: CGFloat = 0
    @State private var step1Completed = false
    @State private var step2Completed = false
    @State private var step3Completed = false
    @State private var currentStep = 1 // 1, 2, or 3
    var onComplete: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            let centerX = screenWidth / 2
            let centerY = screenHeight / 2 - 100
            let frameSize = min(screenWidth, screenHeight) * 0.75 // Increased frame size
            let clearFrameSize = frameSize // Same size as bracket frame
            let frameTopY = centerY - frameSize/2
            let frameBottomY = centerY + frameSize/2
            let frameHeight = frameSize
            
            ZStack {
                // Background Image - Clear (no blur)
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                
                // Blurred overlay with clear cutout for bracket area
                ZStack {
                    // Blurred image overlay
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .blur(radius: 8)
                        .mask(
                            // Create mask that hides the bracket area (clear) and shows blur outside
                            ZStack {
                                // Full screen blur
                                Rectangle()
                                    .fill(Color.black)
                                
                                // Clear cutout for bracket frame area
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.white)
                                    .frame(width: clearFrameSize, height: clearFrameSize)
                                    .position(x: centerX, y: centerY)
                                    .blendMode(.destinationOut)
                            }
                        )
                    
                    // Dark overlay with same cutout
                    Color.black.opacity(0.3)
                        .mask(
                            ZStack {
                                Rectangle()
                                    .fill(Color.black)
                                
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.white)
                                    .frame(width: clearFrameSize, height: clearFrameSize)
                                    .position(x: centerX, y: centerY)
                                    .blendMode(.destinationOut)
                            }
                        )
                }
                
                // Corner Brackets
                CornerBracketsOverlay()
                
                // Scanning Text Overlay - Centered
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("Scanning...")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                        Text("We are checking our garden")
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text("just wait a second")
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundColor(.white.opacity(0.9))
                        
                        // Steps - Centered
                        VStack(alignment: .center, spacing: 16) {
                            ScanningStep(
                                text: "Analyzing image",
                                isCompleted: step1Completed,
                                isLoading: currentStep == 1 && !step1Completed
                            )
                            
                            ScanningStep(
                                text: "Detecting leaves",
                                isCompleted: step2Completed,
                                isLoading: currentStep == 2 && !step2Completed
                            )
                            
                            ScanningStep(
                                text: "Identifying plant",
                                isCompleted: step3Completed,
                                isLoading: currentStep == 3 && !step3Completed
                            )
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 30)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 100)
                }
                
                // Green Gradient Scanning Line - Constrained within bracket frame
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.0, green: 0.52, blue: 0.39).opacity(0.0),
                        Color(red: 0.0, green: 0.52, blue: 0.39),
                        Color(red: 0.0, green: 0.52, blue: 0.39).opacity(0.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: geometry.size.width, height: 6)
                .offset(y: frameTopY + scanningOffset - 400)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
            .onAppear {
                startScanning(frameHeight: frameHeight)
            }
        }
        .ignoresSafeArea()
    }
    
    private func startScanning(frameHeight: CGFloat) {
        // Start from top of frame (offset = -50 to allow more upward movement)
        scanningOffset = -50
        
        // Animate scanning line up and down within the bracket frame only
        // Bottom limit stays same, top can go more up
        withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: true)) {
            scanningOffset = frameHeight
        }
        
        // Step 1: Analyzing image (starts immediately)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            step1Completed = true
            currentStep = 2
        }
        
        // Step 2: Detecting leaves
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            step2Completed = true
            currentStep = 3
        }
        
        // Step 3: Identifying plant
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            step3Completed = true
        }
        
        // Complete scanning after all steps
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            onComplete()
        }
    }
}

struct ScanningStep: View {
    let text: String
    let isCompleted: Bool
    let isLoading: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(width: 20, height: 20)
            } else if isCompleted {
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
            } else {
                Circle()
                    .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    .frame(width: 20, height: 20)
            }
            
            Text(text)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
    }
}

// Corner Brackets Overlay
struct CornerBracketsOverlay: View {
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            let centerX = screenWidth / 2
            let centerY = screenHeight / 2 - 100
            let bracketSize: CGFloat = 70
            let bracketThickness: CGFloat = 3
            let bracketLength: CGFloat = 50
            let frameSize: CGFloat = min(screenWidth, screenHeight) * 0.6
            
            ZStack {
                // Top Left Bracket
                CornerBracketShape(corner: .topLeft, size: bracketSize, thickness: bracketThickness, length: bracketLength)
                    .fill(Color.white)
                    .frame(width: bracketSize, height: bracketSize)
                    .position(x: centerX - frameSize/2, y: centerY - frameSize/2)
                
                // Top Right Bracket
                CornerBracketShape(corner: .topRight, size: bracketSize, thickness: bracketThickness, length: bracketLength)
                    .fill(Color.white)
                    .frame(width: bracketSize, height: bracketSize)
                    .position(x: centerX + frameSize/2, y: centerY - frameSize/2)
                
                // Bottom Left Bracket
                CornerBracketShape(corner: .bottomLeft, size: bracketSize, thickness: bracketThickness, length: bracketLength)
                    .fill(Color.white)
                    .frame(width: bracketSize, height: bracketSize)
                    .position(x: centerX - frameSize/2, y: centerY + frameSize/2)
                
                // Bottom Right Bracket
                CornerBracketShape(corner: .bottomRight, size: bracketSize, thickness: bracketThickness, length: bracketLength)
                    .fill(Color.white)
                    .frame(width: bracketSize, height: bracketSize)
                    .position(x: centerX + frameSize/2, y: centerY + frameSize/2)
            }
        }
    }
}


#Preview {
    ScanningView(image: UIImage(systemName: "leaf.fill")!, onComplete: {})
}

