//
//  GarmentDescription.swift
//  OnboardingPage
//

import Foundation
import FoundationModels

/// What the on-device model sees in the garment photo.
/// The option spellings match the keywords in `FashionRules` so rules can match.
@Generable
struct GarmentDescription {
    @Guide(
        description: "The category of the main garment. Use 'not clothing' if no garment is visible.",
        .anyOf([
            "dress",
            "top",
            "shirt",
            "blouse",
            "trousers",
            "jeans",
            "shorts",
            "skirt",
            "jacket",
            "coat",
            "not clothing"
        ])
    )
    var category: String

    @Guide(
        description: "The silhouette of the garment, when applicable.",
        .anyOf([
            "straight",
            "a-line",
            "fit-and-flare",
            "pencil",
            "full",
            "tapered",
            "wide-leg",
            "flared",
            "bootcut"
        ])
    )
    var shape: String?

    @Guide(
        description: "How fitted the garment appears, when applicable.",
        .anyOf(["tight", "regular", "loose"])
    )
    var fit: String?

    @Guide(
        description: "The neckline, when visible.",
        .anyOf([
            "v-neck",
            "halter",
            "round",
            "scoop",
            "boat",
            "square",
            "high",
            "off-shoulder"
        ])
    )
    var neckline: String?

    @Guide(
        description: "A short list of visible design details. Use these exact words when they apply: peplum, ruffle, wrap, belted, empire waist, draped, fitted waist."
    )
    var designDetails: String

    @Guide(description: "The overall style, such as casual, formal, or sporty.")
    var overallStyle: String
}
