import SwiftUI

struct Peartype: View {
    let image: UIImage
    var backToProfile: () -> Void = {}

    @Environment(\.dismiss) private var dismiss

    let backgroundColor = Color(red: 0.98, green: 0.97, blue: 0.95)

    var body: some View {

        ZStack {

            backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Your Results")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                GarmentResult(image: image, bodyShape: .pear)

                VStack(spacing: 6) {
                    // Retake photo goes back to the camera screen
                    Button("Retake photo") {
                        dismiss()
                    }
                    .buttonStyle(PrimaryButtonStyle())

                    // Profile goes back to the profile screen
                    Button("Profile") {
                        backToProfile()
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }

            }
            .padding(.horizontal, 24)
            .padding(.bottom, 6)

        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        Peartype(image: UIImage())
    }
    .environment(OnboardingData())
}

