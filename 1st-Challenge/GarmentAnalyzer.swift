//
//  GarmentAnalyzer.swift
//  OnboardingPage
//

import UIKit
import FoundationModels

/// Sends the garment photo to the on-device model and returns what it sees.
enum GarmentAnalyzer {

    enum AnalysisError: Error {
        case modelUnavailable
    }

    static func describe(_ image: UIImage) async throws -> GarmentDescription {
        guard SystemLanguageModel.default.isAvailable else {
            throw AnalysisError.modelUnavailable
        }

        let session = LanguageModelSession(
            instructions: """
            You are a fashion assistant. Describe only what is visible in the photo. \
            Do not invent details. Leave a field empty if it cannot be determined. \
            Respond in English.
            """
        )

        // Greedy sampling so the same photo always gives the same description.
        // Passing the UIImage keeps the photo's orientation.
        let response = try await session.respond(
            generating: GarmentDescription.self,
            options: GenerationOptions(samplingMode: .greedy)
        ) {
            """
            First name the main thing shown in this photo. \
            Then decide whether it is a clothing garment. \
            If it is not, set isClothing to false and category to "not clothing". \
            If it is, describe the main garment.
            """
            Attachment(image)
        }

        #if DEBUG
        // Shows exactly what the model returned, to check results in Xcode's console.
        let g = response.content
        print("""
        [GarmentAnalyzer] subject: \(g.subject) | isClothing: \(g.isClothing) | category: \(g.category) \
        | shape: \(g.shape ?? "nil") | fit: \(g.fit ?? "nil") | neckline: \(g.neckline ?? "nil") \
        | details: \(g.designDetails) | style: \(g.overallStyle)
        """)
        #endif

        return response.content
    }
}
