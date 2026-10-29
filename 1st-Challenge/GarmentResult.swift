//
//  GarmentResult.swift
//  OnboardingPage
//

import SwiftUI

/// Loading animation, then the verdict and the styling box, shared by the four result screens.
/// Runs: photo → Foundation Model → GarmentDescription → FashionRules → verdict.
struct GarmentResult: View {
    let image: UIImage
    let bodyShape: BodyShape

    @State private var verdict: FitVerdict?
    @State private var errorMessage: String?
    @State private var contentHeight: CGFloat = 0

    private let cardColor = Color(red: 0.93, green: 0.90, blue: 0.85)
    private let orange = Color(red: 209.0 / 255.0, green: 113.0 / 255.0, blue: 24.0 / 255.0)
    private let dark = Color(red: 0.17, green: 0.16, blue: 0.15)

    private var isLoading: Bool {
        verdict == nil && errorMessage == nil
    }

    var body: some View {
        VStack(spacing: 20) {
            if isLoading {
                loadingView
            } else {
                resultView
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .task {
            await analyze()
        }
    }

    // MARK: - Loading

    // Loading animation, in the space the illustration used to take
    private var loadingView: some View {
        VStack(spacing: 16) {
            Image(systemName: "hanger")
                .font(.system(size: 64, weight: .light))
                .foregroundStyle(orange)
                .symbolEffect(.pulse, options: .repeating)

            Text("Analyzing your photo…")
                .font(.system(size: 16))
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
    }

    // MARK: - Result

    private var resultView: some View {
        VStack(spacing: 0) {
            // Verdict
            VStack(spacing: 6) {
                // One line for every verdict, so the box below always starts at the same height
                Text(headline)
                    .font(.system(size: 32, weight: .bold, design: .serif))
                    .foregroundStyle(accent)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                if showsShapeLine {
                    Text("For your \(bodyShape.title) shape")
                        .font(.system(size: 15))
                        .foregroundStyle(.gray)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
            .padding(.bottom, 40)

            // Styling box, a fixed distance under the verdict
            VStack(alignment: .leading, spacing: 12) {
                Text("Flattery and styling")
                    .font(.system(size: 20, weight: .bold))

                // Sizes to its text (up to 240 pt), and scrolls only when the text is longer
                ScrollView {
                    boxContent
                        .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { height in
                            contentHeight = height
                        }
                }
                .frame(height: min(contentHeight, 240))
                .scrollBounceBehavior(.basedOnSize)
            }
            .foregroundStyle(.black)
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(cardColor)
            .overlay(alignment: .leading) {
                // Thin strip in the verdict colour
                Rectangle()
                    .fill(accent)
                    .frame(width: 5)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Spacer(minLength: 0)
        }
    }

    private var boxContent: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                sectionLabel("WHY")
                Text(whyText)
                    .font(.system(size: 16))
                    .fixedSize(horizontal: false, vertical: true)
            }

            if let verdict, let tip = verdict.tip {
                VStack(alignment: .leading, spacing: 6) {
                    sectionLabel(verdict.tipLabel)
                    Text(tip)
                        .font(.system(size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold))
            .tracking(1.2)
            .foregroundStyle(orange)
    }

    // MARK: - Text and colour

    private var headline: String {
        if errorMessage != nil { return "Unavailable" }
        return verdict?.title ?? ""
    }

    /// Dark for Suitable, orange for Consider an alternative, grey otherwise.
    private var accent: Color {
        switch verdict?.kind {
        case .suitable:            return dark
        case .considerAlternative: return orange
        default:                   return .gray
        }
    }

    private var showsShapeLine: Bool {
        errorMessage == nil && verdict?.kind != .notClothing
    }

    private var whyText: String {
        if let errorMessage {
            return "\(errorMessage) Retake the photo to try again."
        }
        return verdict?.why ?? ""
    }

    // MARK: - Analysis

    private func analyze() async {
        do {
            let result = try await GarmentAnalyzer.describe(image)
            withAnimation(.easeOut(duration: 0.4)) {
                verdict = FashionRules.verdict(for: result, bodyShape: bodyShape)
            }
        } catch GarmentAnalyzer.AnalysisError.modelUnavailable {
            withAnimation(.easeOut(duration: 0.4)) {
                errorMessage = "Apple Intelligence isn't available on this device, so the photo can't be analyzed."
            }
        } catch {
            withAnimation(.easeOut(duration: 0.4)) {
                errorMessage = "We couldn't analyze this photo."
            }
        }
    }
}
