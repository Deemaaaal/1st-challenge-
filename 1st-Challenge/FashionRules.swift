//
//  FashionRules.swift
//  OnboardingPage
//

import Foundation

struct StyleRule: Identifiable {
    let id = UUID()
    let bodyShape: BodyShape
    let garmentTypes: [String]
    let keywords: [String]
    let recommendation: String
    let reason: String
    let source: String
}

/// The result shown on the result screen.
struct FitVerdict {
    enum Kind {
        case suitable
        case considerAlternative
        case noTip
        case notClothing
    }

    let kind: Kind
    let why: String
    let alternative: String?

    var title: String {
        switch kind {
        case .suitable:            return "Suitable"
        case .considerAlternative: return "Consider an alternative"
        case .noTip:               return "No tip yet"
        case .notClothing:         return "No garment found"
        }
    }
}

enum FashionRules {

    // MARK: - Normalize Garment Category

    static func normalizeCategory(_ value: String) -> String {
        let text = value.lowercased()

        if text.contains("dress") {
            return "dress"
        }

        if text.contains("skirt") {
            return "skirt"
        }

        if text.contains("jean") {
            return "jeans"
        }

        if text.contains("trouser")
            || text.contains("pants")
            || text.contains("pant ") {
            return "trousers"
        }

        if text.contains("shorts") {
            return "shorts"
        }

        if text.contains("coat") {
            return "coat"
        }

        if text.contains("jacket") {
            return "jacket"
        }

        if text.contains("blouse") {
            return "blouse"
        }

        if text.contains("shirt") {
            return "shirt"
        }

        if text.contains("top")
            || text.contains("t-shirt")
            || text.contains("tee")
            || text.contains("sweater")
            || text.contains("cardigan") {
            return "top"
        }

        return text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
    }

    // MARK: - Research-Based Rules

    static let rules: [StyleRule] = [

        // Pear (Triangle)

        StyleRule(
            bodyShape: .pear,
            garmentTypes: ["dress", "skirt"],
            keywords: ["a-line", "fit-and-flare"],
            recommendation: "Consider A-line or fit-and-flare styles.",
            reason: "These cuts can create a balanced overall silhouette.",
            source: "Research-based styling rule"
        ),

        StyleRule(
            bodyShape: .pear,
            garmentTypes: ["top", "shirt", "blouse"],
            keywords: ["v-neck", "halter"],
            recommendation: "Consider V-neck or halter-neck tops.",
            reason: "These necklines can draw attention toward the upper body.",
            source: "Research-based styling rule"
        ),

        StyleRule(
            bodyShape: .pear,
            garmentTypes: ["trousers", "jeans"],
            keywords: ["straight", "tapered"],
            recommendation: "Consider straight or tapered trousers.",
            reason: "These cuts can provide a clean, balanced line.",
            source: "Research-based styling rule"
        ),

        // Inverted Triangle

        StyleRule(
            bodyShape: .invertedTriangle,
            garmentTypes: ["top", "shirt", "blouse"],
            keywords: ["v-neck"],
            recommendation: "Consider a V-neck top.",
            reason: "A V-neck can create a visually elongated neckline.",
            source: "Research-based styling rule"
        ),

        StyleRule(
            bodyShape: .invertedTriangle,
            garmentTypes: ["trousers", "jeans"],
            keywords: ["wide-leg", "flared", "bootcut"],
            recommendation: "Consider wide-leg, flared, or bootcut bottoms.",
            reason: "These cuts can add visual volume to the lower silhouette.",
            source: "Research-based styling rule"
        ),

        StyleRule(
            bodyShape: .invertedTriangle,
            garmentTypes: ["skirt", "dress"],
            keywords: ["a-line", "fit-and-flare"],
            recommendation: "Consider A-line or fit-and-flare styles.",
            reason: "These cuts can create a more balanced silhouette.",
            source: "Research-based styling rule"
        ),

        // Hourglass

        StyleRule(
            bodyShape: .hourglass,
            garmentTypes: ["dress", "top", "shirt", "blouse", "jacket"],
            keywords: ["waist", "belted", "wrap", "fitted"],
            recommendation: "Consider styles that define the waist.",
            reason: "Waist-defining details can highlight the natural silhouette.",
            source: "Research-based styling rule"
        ),

        StyleRule(
            bodyShape: .hourglass,
            garmentTypes: ["skirt"],
            keywords: ["pencil", "a-line", "fit-and-flare"],
            recommendation: "Consider pencil, A-line, or fit-and-flare skirts.",
            reason: "These styles can complement a defined waist.",
            source: "Research-based styling rule"
        ),

        // Apple
        // Apple is also the fallback shape in `BodyShape.from`, so this wording stays soft ("may").

        StyleRule(
            bodyShape: .apple,
            garmentTypes: ["top", "shirt", "blouse", "dress"],
            keywords: ["v-neck"],
            recommendation: "V-neck tops or dresses may suit you.",
            reason: "A V-neck may create a visually elongated neckline.",
            source: "Research-based styling rule"
        ),

        StyleRule(
            bodyShape: .apple,
            garmentTypes: ["trousers", "jeans"],
            keywords: ["straight", "flared", "bootcut"],
            recommendation: "Straight, flared, or bootcut trousers may suit you.",
            reason: "These cuts may create a clean, balanced line.",
            source: "Research-based styling rule"
        )
    ]

    // MARK: - Match Rules to AI Analysis

    /// Rules for this body shape and garment category, whether or not the garment matches them.
    static func rules(
        for category: String,
        bodyShape: BodyShape
    ) -> [StyleRule] {
        rules.filter { rule in
            rule.bodyShape == bodyShape
                && rule.garmentTypes.contains { normalizeCategory($0) == category }
        }
    }

    /// Rules the analyzed garment actually matches.
    static func recommendations(
        for garment: GarmentDescription,
        bodyShape: BodyShape
    ) -> [StyleRule] {

        let normalizedCategory = normalizeCategory(garment.category)

        let garmentText = """
        \(garment.category)
        \(garment.shape ?? "")
        \(garment.fit ?? "")
        \(garment.neckline ?? "")
        \(garment.designDetails)
        \(garment.overallStyle)
        """

        return rules(for: normalizedCategory, bodyShape: bodyShape).filter { rule in
            rule.keywords.contains { keyword in
                garmentText.localizedCaseInsensitiveContains(keyword)
            }
        }
    }

    // MARK: - Verdict

    static func verdict(
        for garment: GarmentDescription,
        bodyShape: BodyShape
    ) -> FitVerdict {

        let category = normalizeCategory(garment.category)

        if category == "not clothing" {
            return FitVerdict(
                kind: .notClothing,
                why: "We couldn't find a garment in this photo. Try a clear photo of one item.",
                alternative: nil
            )
        }

        // Matching rule → Suitable, with the rule's reason.
        if let match = recommendations(for: garment, bodyShape: bodyShape).first {
            return FitVerdict(
                kind: .suitable,
                why: match.reason,
                alternative: nil
            )
        }

        // Rules exist for this item but none match → suggest the rule's recommendation.
        if let rule = rules(for: category, bodyShape: bodyShape).first {
            return FitVerdict(
                kind: .considerAlternative,
                why: "This \(category) doesn't show the cut or details usually suggested for your shape.",
                alternative: "\(rule.recommendation) \(rule.reason)"
            )
        }

        return FitVerdict(
            kind: .noTip,
            why: "No specific tip for this item yet.",
            alternative: nil
        )
    }
}
