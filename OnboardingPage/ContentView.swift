import SwiftUI
import Playgrounds
struct ContentView: View {
    @State private var showSplash = true
    @State private var data = OnboardingData()

    var body: some View {
        ZStack {
            // First onboarding page, waiting underneath
            NavigationStack{
                measurementsView2()
            }
            // Splash on top, removed after a short delay
            if showSplash {
                SplashView()
                    .transition(.opacity.combined(with: .scale(scale: 1.05)))
                    .zIndex(1)
            }
        }
        .environment(data) 
        .task {
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation(.easeInOut(duration: 0.6)) {
                showSplash = false
            }
        }
    }
}

#Preview {
    ContentView()
}
