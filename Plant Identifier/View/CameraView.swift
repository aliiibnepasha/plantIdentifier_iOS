//
//  CameraView.swift
//  Plant Identifier
//
//  Created by Lowbyte Studio on 04/12/2025.
//

import SwiftUI
import AVFoundation
import Combine
import PhotosUI

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var cameraManager = CameraManager()
    @State private var showIdentify = true // true for Identify, false for Diagnose
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showNextOptions = false
    @State private var showScanning = false
    @State private var showIdentifyView = false
    
    var body: some View {
        ZStack {
            // Camera Preview or Selected Image
            GeometryReader { geometry in
                if let selectedImage = selectedImage {
                    ZStack {
                        Color.black
                            .ignoresSafeArea()
                        
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                } else {
                    CameraPreview(cameraManager: cameraManager)
                        .ignoresSafeArea()
                }
            }
            .ignoresSafeArea()
            
            // Top Bar
            VStack {
                HStack {
                    // Flash Button
                    Button(action: {
                        cameraManager.toggleFlash()
                    }) {
                        Image(systemName: cameraManager.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()
                    
                    // Close Button
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 10)
                .background(Color.black)
                
                Spacer()
            }
            
            // Corner Brackets (Framing Guide) - Curved Style
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                let centerX = screenWidth / 2
                let centerY = screenHeight / 2 - 40 // Move brackets up
                let bracketSize: CGFloat = 70
                let bracketThickness: CGFloat = 3
                let bracketLength: CGFloat = 50
                let frameSize: CGFloat = min(screenWidth, screenHeight) * 0.6 // Square frame size
                
                ZStack {
                    // Top Left Bracket (Curved)
                    CornerBracketShape(corner: .topLeft, size: bracketSize, thickness: bracketThickness, length: bracketLength)
                        .fill(Color.white)
                        .frame(width: bracketSize, height: bracketSize)
                        .position(x: centerX - frameSize/2, y: centerY - frameSize/2)
                    
                    // Top Right Bracket (Curved)
                    CornerBracketShape(corner: .topRight, size: bracketSize, thickness: bracketThickness, length: bracketLength)
                        .fill(Color.white)
                        .frame(width: bracketSize, height: bracketSize)
                        .position(x: centerX + frameSize/2, y: centerY - frameSize/2)
                    
                    // Bottom Left Bracket (Curved)
                    CornerBracketShape(corner: .bottomLeft, size: bracketSize, thickness: bracketThickness, length: bracketLength)
                        .fill(Color.white)
                        .frame(width: bracketSize, height: bracketSize)
                        .position(x: centerX - frameSize/2, y: centerY + frameSize/2)
                    
                    // Bottom Right Bracket (Curved)
                    CornerBracketShape(corner: .bottomRight, size: bracketSize, thickness: bracketThickness, length: bracketLength)
                        .fill(Color.white)
                        .frame(width: bracketSize, height: bracketSize)
                        .position(x: centerX + frameSize/2, y: centerY + frameSize/2)
                }
            }
            
            // Bottom Section
            VStack {
                Spacer()
                
                VStack(spacing: 0) {
                    // Identify/Diagnose Section
                    HStack(spacing: 0) {
                        Spacer()
                        
                        // Identify Button
                        Button(action: {
                            showIdentify = true
                        }) {
                            Text("Identify")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 5)
                                .background(
                                    showIdentify ? Color.white.opacity(0.16) : Color.clear
                                )
                                .cornerRadius(68)
                        }
                        
                        // Diagnose Text
                        Button(action: {
                            showIdentify = false
                        }) {
                            Text("Diagnose")
                                .font(.system(size: 16, weight: .regular, design: .default))
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    
                    // Bottom Navigation Bar
                    HStack(spacing: 0) {
                        // Gallery Button
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 52, height: 52)
                                .background(Color.white.opacity(0.16))
                                .cornerRadius(26)
                        }
                        
                        Spacer()
                        
                        // Central Camera Button (with magnifying glass icon)
                        Button(action: {
                            if let image = selectedImage {
                                // If image is already selected, start scanning
                                showScanning = true
                            } else {
                                // Capture photo
                                cameraManager.capturePhoto()
                            }
                        }) {
                            ZStack {
                                // Background Image from Assets
                                Image("identify-icon-bg")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 72, height: 72)
                                    .clipShape(Circle())
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 3)
                                    .frame(width: 72, height: 72)
                                
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 30, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        .offset(y: -10)
                        
                        Spacer()
                        
                        // Refresh/Camera Switch Button
                        Button(action: {
                            cameraManager.switchCamera()
                        }) {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 52, height: 52)
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
                .background(Color.black)
            }
        }
        .onAppear {
            cameraManager.setupCamera()
        }
        .onDisappear {
            cameraManager.stopCamera()
        }
        .onChange(of: cameraManager.capturedImage) { newImage in
            if let image = newImage {
                selectedImage = image
                // Start scanning automatically when image is captured
                showScanning = true
            }
        }
        .fullScreenCover(isPresented: $showScanning) {
            if let image = selectedImage {
                ScanningView(image: image) {
                    showScanning = false
                    showIdentifyView = true
                }
            }
        }
        .fullScreenCover(isPresented: $showIdentifyView) {
            if let image = selectedImage {
                IdentifyView(image: image)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, showNextOptions: $showNextOptions)
        }
    }
}

// Corner Bracket Shape
enum BracketCorner {
    case topLeft, topRight, bottomLeft, bottomRight
}

struct CornerBracketShape: Shape {
    var corner: BracketCorner
    var size: CGFloat
    var thickness: CGFloat
    var length: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius: CGFloat = 15
        
        switch corner {
        case .topLeft:
            // Start from left vertical line (bottom end) - like bottom right but rotated
            path.move(to: CGPoint(x: 0, y: length))
            // Draw vertical line towards corner
            path.addLine(to: CGPoint(x: 0, y: cornerRadius))
            // Draw curved corner (smooth rounded)
            path.addArc(
                center: CGPoint(x: cornerRadius, y: cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            // Draw horizontal line right
            path.addLine(to: CGPoint(x: length, y: 0))
            
        case .topRight:
            // Start from right vertical line (bottom end)
            path.move(to: CGPoint(x: size, y: length))
            // Draw vertical line towards corner
            path.addLine(to: CGPoint(x: size, y: cornerRadius))
            // Draw curved corner (smooth rounded)
            path.addArc(
                center: CGPoint(x: size - cornerRadius, y: cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(0),
                endAngle: .degrees(270),
                clockwise: true
            )
            // Draw horizontal line left
            path.addLine(to: CGPoint(x: size - length, y: 0))
            
        case .bottomLeft:
            // Exact mirror of bottom right - same L-shape with smooth rounded corner
            // Bottom right: starts from right (x: size), goes down, curves, goes left
            // Bottom left: starts from left (x: 0), goes down, curves, goes right
            path.move(to: CGPoint(x: 0, y: size - length))
            path.addLine(to: CGPoint(x: 0, y: size - cornerRadius))
            path.addArc(
                center: CGPoint(x: cornerRadius, y: size - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(180),
                endAngle: .degrees(90),
                clockwise: true
            )
            path.addLine(to: CGPoint(x: length, y: size))
            
        case .bottomRight:
            // Start from right vertical line (top end)
            path.move(to: CGPoint(x: size, y: size - length))
            // Draw vertical line towards corner
            path.addLine(to: CGPoint(x: size, y: size - cornerRadius))
            // Draw curved corner (smooth rounded)
            path.addArc(
                center: CGPoint(x: size - cornerRadius, y: size - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            // Draw horizontal line left
            path.addLine(to: CGPoint(x: size - length, y: size))
        }
        
        return path.strokedPath(.init(lineWidth: thickness, lineCap: .round, lineJoin: .round))
    }
}

// Camera Manager
class CameraManager: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isFlashOn = false
    @Published var isSessionReady = false
    @Published var capturedImage: UIImage?
    var captureSession: AVCaptureSession?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var photoOutput: AVCapturePhotoOutput?
    private var currentCamera: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    func setupCamera() {
        // Check permission status first
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        if authStatus == .authorized {
            // Permission already granted, setup immediately
            self.configureSession()
        } else if authStatus == .notDetermined {
            // Request permission
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.configureSession()
                    }
                } else {
                    print("Camera permission denied")
                }
            }
        } else {
            print("Camera permission denied or restricted")
        }
    }
    
    private func configureSession() {
        // Create session on background thread
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let session = AVCaptureSession()
            session.sessionPreset = .photo
            
            // Begin configuration
            session.beginConfiguration()
            
            guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                print("Camera not available")
                session.commitConfiguration()
                return
            }
            
            do {
                let input = try AVCaptureDeviceInput(device: camera)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                // Photo Output
                let photoOutput = AVCapturePhotoOutput()
                if session.canAddOutput(photoOutput) {
                    session.addOutput(photoOutput)
                }
                
                // Commit configuration
                session.commitConfiguration()
                
                // Update on main thread
                DispatchQueue.main.async {
                    self.captureSession = session
                    self.currentCamera = camera
                    self.photoOutput = photoOutput
                    self.isSessionReady = true
                }
                
                // Start session
                session.startRunning()
            } catch {
                print("Error setting up camera: \(error)")
                session.commitConfiguration()
            }
        }
    }
    
    func stopCamera() {
        captureSession?.stopRunning()
    }
    
    func toggleFlash() {
        isFlashOn.toggle()
    }
    
    func switchCamera() {
        guard let session = captureSession else { return }
        
        session.beginConfiguration()
        
        // Remove existing inputs
        session.inputs.forEach { session.removeInput($0) }
        
        // Switch camera
        let position: AVCaptureDevice.Position = currentCamera?.position == .back ? .front : .back
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else {
            session.commitConfiguration()
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(input) {
                session.addInput(input)
                currentCamera = camera
            }
        } catch {
            print("Error switching camera: \(error)")
        }
        
        session.commitConfiguration()
    }
    
    func capturePhoto() {
        guard let photoOutput = photoOutput else { return }
        
        let settings = AVCapturePhotoSettings()
        if isFlashOn && currentCamera?.hasFlash == true {
            settings.flashMode = .on
        }
        
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            print("Error capturing photo: \(error!.localizedDescription)")
            return
        }
        
        // Convert captured photo to UIImage
        if let imageData = photo.fileDataRepresentation(),
           let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.capturedImage = image
            }
        }
    }
}

// Camera Preview
struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cameraManager: CameraManager
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .black
        context.coordinator.view = view
        
        // Setup preview layer when session is ready
        DispatchQueue.main.async {
            context.coordinator.setupPreviewLayer()
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.view = uiView
        if let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            previewLayer.frame = uiView.bounds
        }
        // Retry setup if preview layer is missing
        if uiView.layer.sublayers?.first(where: { $0 is AVCaptureVideoPreviewLayer }) == nil {
            context.coordinator.setupPreviewLayer()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(cameraManager: cameraManager)
    }
    
    class Coordinator {
        var cameraManager: CameraManager
        var view: UIView?
        var previewLayer: AVCaptureVideoPreviewLayer?
        private var cancellable: AnyCancellable?
        
        init(cameraManager: CameraManager) {
            self.cameraManager = cameraManager
            
            // Observe when session becomes ready
            cancellable = cameraManager.$isSessionReady
                .sink { [weak self] isReady in
                    if isReady {
                        self?.setupPreviewLayer()
                    }
                }
        }
        
        func setupPreviewLayer() {
            guard let view = view else { return }
            
            // Remove existing preview layer if any
            view.layer.sublayers?.forEach { if $0 is AVCaptureVideoPreviewLayer { $0.removeFromSuperlayer() } }
            
            // Setup preview layer when session is ready
            if let session = cameraManager.captureSession, cameraManager.isSessionReady {
                let previewLayer = AVCaptureVideoPreviewLayer(session: session)
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.frame = view.bounds
                view.layer.addSublayer(previewLayer)
                self.previewLayer = previewLayer
                cameraManager.previewLayer = previewLayer
            }
        }
    }
}

// Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var showNextOptions: Bool
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let provider = results.first?.itemProvider else {
                picker.dismiss(animated: true)
                return
            }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                // Load image immediately
                provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                    DispatchQueue.main.async {
                        self?.parent.selectedImage = image as? UIImage
                        self?.parent.showNextOptions = true
                        picker.dismiss(animated: true)
                    }
                }
            } else {
                picker.dismiss(animated: true)
            }
        }
    }
}

// Zoomable Image View
struct ZoomableImageView: UIViewRepresentable {
    let image: UIImage
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .black
        scrollView.bouncesZoom = true
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        
        context.coordinator.imageView = imageView
        context.coordinator.scrollView = scrollView
        
        // Set up image view frame after layout
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.setupImageView(imageView: imageView, scrollView: scrollView)
        }
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if let imageView = context.coordinator.imageView {
            imageView.image = image
            setupImageView(imageView: imageView, scrollView: uiView)
        }
    }
    
    private func setupImageView(imageView: UIImageView, scrollView: UIScrollView) {
        guard let image = imageView.image else { return }
        
        let imageSize = image.size
        var scrollViewSize = scrollView.bounds.size
        
        // Ensure we have valid scroll view size
        if scrollViewSize.width == 0 || scrollViewSize.height == 0 {
            scrollViewSize = UIScreen.main.bounds.size
        }
        
        // Calculate scale to fit image in scroll view (aspect fit)
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        // Use minScale as is - it will fit the image to screen
        let finalMinScale = minScale
        
        // Set image view frame to original image size
        imageView.frame = CGRect(origin: .zero, size: imageSize)
        imageView.contentMode = .scaleAspectFit
        
        // Set scroll view content size to image size
        scrollView.contentSize = imageSize
        
        // Set zoom scales - minimum should fit the image, maximum allows zoom in
        scrollView.minimumZoomScale = finalMinScale
        scrollView.maximumZoomScale = 5.0
        
        // Set initial zoom to fit the image
        scrollView.zoomScale = finalMinScale
        
        // Center the image after setting zoom
        DispatchQueue.main.async {
            self.centerImage(in: scrollView, imageView: imageView)
        }
    }
    
    private func centerImage(in scrollView: UIScrollView, imageView: UIImageView) {
        let boundsSize = scrollView.bounds.size
        var frameToCenter = imageView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        imageView.frame = frameToCenter
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var imageView: UIImageView?
        var scrollView: UIScrollView?
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imageView
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            centerImage(in: scrollView)
        }
        
        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            // When zoomed out to minimum, ensure image is centered
            if scale <= scrollView.minimumZoomScale {
                centerImage(in: scrollView)
            }
        }
        
        private func centerImage(in scrollView: UIScrollView) {
            guard let imageView = imageView else { return }
            
            let boundsSize = scrollView.bounds.size
            var frameToCenter = imageView.frame
            
            if frameToCenter.size.width < boundsSize.width {
                frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
            } else {
                frameToCenter.origin.x = 0
            }
            
            if frameToCenter.size.height < boundsSize.height {
                frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
            } else {
                frameToCenter.origin.y = 0
            }
            
            imageView.frame = frameToCenter
        }
    }
}

#Preview {
    CameraView()
}

