//
//  DoesItFit.swift
//  OnboardingPage
//
//  Created by jood on 16/05/1448 AH.
//


import SwiftUI
import PhotosUI
import UIKit

struct DoesItFit: View {
@Environment(\.dismiss) private var dismiss

@State private var selectedPhoto: PhotosPickerItem?
@State private var garmentImage: UIImage?
@State private var showPicker = false
@Environment(OnboardingData.self) private var data
@State private var showResult = false
@State private var showCamera = false

private let backgroundColor = Color(
red: 0.98, green: 0.97, blue: 0.95
)

private let garmentBackground = Color(
red: 0.92, green: 0.90, blue: 0.82
)

private let accentColor = Color(
red: 0.65, green: 0.34, blue: 0.02
)

var body: some View {
ZStack {
backgroundColor
.ignoresSafeArea()

VStack(spacing: 0) {

// MARK: - Main Content

ScrollView(showsIndicators: false) {
VStack(alignment: .leading, spacing: 0) {

Text("Does it Fit?")
.font(.system(size: 34, weight: .bold))
.foregroundColor(.black)
.frame(
maxWidth: .infinity,
alignment: .leading
)
.padding(.top, 20)

Text(
"Add a photo of a garment and we will check fit and flattery against your measurements."
)
.font(.system(size: 17))
.foregroundColor(.black)
.fixedSize(
horizontal: false,
vertical: true
)
.padding(.top, 12)

// MARK: - Image Frame

GeometryReader { geometry in
ZStack {
RoundedRectangle(cornerRadius: 22)
.fill(garmentBackground)

if let garmentImage {
Image(uiImage: garmentImage)
.resizable()
.scaledToFill()
.frame(
width: geometry.size.width,
height: geometry.size.height
)
.clipped()
.clipShape(
RoundedRectangle(
cornerRadius: 22
)
)
} else {
RoundedRectangle(cornerRadius: 14)
.stroke(
Color(
red: 0.55,
green: 0.49,
blue: 0.36
),
style: StrokeStyle(
lineWidth: 1.5,
dash: [5, 4]
)
)
.padding(12)

VStack(spacing: 20) {
Text(
"Please Select Your Clothes Image"
)
.font(
.system(
size: 16,
weight: .semibold
)
)
.foregroundColor(.black)
.multilineTextAlignment(.center)

Image(
systemName: "photo.badge.plus"
)
.font(.largeTitle)
.foregroundStyle(.brown)
}
.padding(24)
}
}
.frame(
width: geometry.size.width,
height: geometry.size.height
)
.clipShape(
RoundedRectangle(cornerRadius: 22)
)
.contentShape(
RoundedRectangle(cornerRadius: 22)
)
.onTapGesture {
showPicker = true
}
}
.frame(height: 290)
.padding(.top, 24)

// MARK: - Privacy Note

Text(
"Photos stay on this iPhone and are not uploaded"
)
.font(.system(size: 11))
.foregroundColor(.gray)
.multilineTextAlignment(.center)
.frame(maxWidth: .infinity)
.padding(.top, 14)
.padding(.bottom, 20)
}
.padding(.horizontal, 24)
}

// MARK: - Bottom Buttons

VStack(spacing: 6) {

// Take Photo Button

Button {
if UIImagePickerController
.isSourceTypeAvailable(.camera) {
showCamera = true
}
} label: {
HStack(spacing: 10) {
Image(systemName: "camera")
Text("Take Photo")
}
.font(
.system(size: 19, weight: .semibold)
)
.foregroundColor(.white)
.frame(maxWidth: .infinity)
.frame(height: 54)
.background(Color(
    red: 209.0 / 255.0,
    green: 113.0 / 255.0,
    blue: 24.0 / 255.0
))
.clipShape(Capsule())
}
.buttonStyle(.plain)
.sheet(isPresented: $showCamera) {
CameraPicker(image: $garmentImage)
}

// Back Button

Button {
dismiss()
} label: {
Text("Back")
.font(
.system(size: 18, weight: .semibold)
)
.foregroundColor(.black)
.frame(maxWidth: .infinity)
.frame(height: 42)
.contentShape(Rectangle())
}
.buttonStyle(.plain)
}
.padding(.horizontal, 24)
.padding(.top, 10)
.padding(.bottom, 6)
.background(backgroundColor)
}
}
.toolbar(.hidden, for: .navigationBar)
    
.onChange(of: garmentImage) { _, newImage in
    if newImage != nil {
        showResult = true
    }
}
.navigationDestination(isPresented: $showResult) {
  switch data.bodyShape {
    case .pear:
        Peartype()
  case .hourglass:
      HourglassType()
  case .apple:
      Appleshape()
  case .invertedTriangle:
      InvertedTringleType()
    default:
        Text("Coming soon")
    }
}
    
.photosPicker(
isPresented: $showPicker,
selection: $selectedPhoto,
matching: .images
)
.onChange(of: selectedPhoto) { _, newPhoto in
guard let newPhoto else { return }

Task {
if let data = try? await newPhoto.loadTransferable(
type: Data.self
),
let image = UIImage(data: data) {
await MainActor.run {
garmentImage = image
}
}
}
}
}
}

// MARK: - Camera Picker

struct CameraPicker: UIViewControllerRepresentable {
@Binding var image: UIImage?

@Environment(\.dismiss) private var dismiss

func makeUIViewController(
context: Context
) -> UIImagePickerController {
let picker = UIImagePickerController()
picker.sourceType = .camera
picker.delegate = context.coordinator
return picker
}

func updateUIViewController(
_ uiViewController: UIImagePickerController,
context: Context
) {}

func makeCoordinator() -> Coordinator {
Coordinator(self)
}

final class Coordinator: NSObject,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

let parent: CameraPicker

init(_ parent: CameraPicker) {
self.parent = parent
}

func imagePickerController(
_ picker: UIImagePickerController,
didFinishPickingMediaWithInfo info:
[UIImagePickerController.InfoKey: Any]
) {
if let selectedImage =
info[.originalImage] as? UIImage {
parent.image = selectedImage
}

parent.dismiss()
}

func imagePickerControllerDidCancel(
_ picker: UIImagePickerController
) {
parent.dismiss()
}
}
}

// MARK: - Preview

#Preview {
    NavigationStack {
        DoesItFit()
    }
    .environment(OnboardingData())
}
