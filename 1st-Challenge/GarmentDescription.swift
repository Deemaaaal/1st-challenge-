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
    // The model fills properties in order. Naming what is in the photo first,
    // then deciding whether it is clothing, makes the clothing check more reliable.
    @Guide(
        description: "In a few words, the main thing shown in the photo, for example 'black phone on a desk', 'blue denim jeans on a hanger', or 'woman wearing a red dress'."
    )
    var subject: String

    @Guide(
        description: "True if the photo shows a clothing garment, such as a dress, top, shirt, trousers, jeans, skirt, shorts, jacket, or coat, whether worn by a person, on a hanger, or laid flat. False if there is no garment, for example shoes, bags, jewelry, hats, furniture, food, animals, objects, screenshots, or scenery."
    )
    var isClothing: Bool

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
