//
//  OnboardingData.swift
//  OnboardingPage
//
//  Created by Fatimah Aljifry on 14/05/1448 AH.
//

import SwiftUI
import Observation

@Observable
class OnboardingData {

    var bust = ""
    var waist = ""
    var hips = ""
    var height = ""
    
    var bodyShape: BodyShape? {
        guard let b = number(from: bust),
              let w = number(from: waist),
              let h = number(from: hips)
        else { return nil }

        return BodyShape.from(bust: b, waist: w, hips: h)
    }

    static let bustRange = 60.0...160.0
    static let waistRange = 40.0...160.0
    static let hipsRange = 60.0...170.0
    static let heightRange = 120.0...220.0

    var filled: [Bool] {
        let results = [
            isValid(bust, in: Self.bustRange),
            isValid(waist, in: Self.waistRange),
            isValid(hips, in: Self.hipsRange),
            isValid(height, in: Self.heightRange)
        ]

        var everythingBeforeIsValid = true

        return results.map { isValid in
            everythingBeforeIsValid =
                everythingBeforeIsValid && isValid

            return everythingBeforeIsValid
        }
    }

    var page1Complete: Bool {
        filled[0] && filled[1]
    }

    var page2Complete: Bool {
        filled[2] && filled[3]
    }

    var bustError: String? {
        error(for: bust, in: Self.bustRange)
    }

    var waistError: String? {
        error(for: waist, in: Self.waistRange)
    }

    var hipsError: String? {
        error(for: hips, in: Self.hipsRange)
    }

    var heightError: String? {
        error(for: height, in: Self.heightRange)
    }

    func isValid(
        _ text: String,
        in range: ClosedRange<Double>
    ) -> Bool {
        guard let value = number(from: text) else {
            return false
        }

        return range.contains(value)
    }

    private func error(
        for text: String,
        in range: ClosedRange<Double>
    ) -> String? {
        let trimmed = text.trimmingCharacters(in: .whitespaces)

        if trimmed.isEmpty {
            return nil
        }

        if isValid(text, in: range) {
            return nil
        }

        return "Enter a value between \(Int(range.lowerBound)) and \(Int(range.upperBound)) cm."
    }

    func number(from text: String) -> Double? {
        var cleaned = text.trimmingCharacters(in: .whitespaces)

        let arabicDigits = Array("٠١٢٣٤٥٦٧٨٩")

        for (index, digit) in arabicDigits.enumerated() {
            cleaned = cleaned.replacingOccurrences(
                of: String(digit),
                with: String(index)
            )
        }

        cleaned = cleaned
            .replacingOccurrences(of: "٫", with: ".")
            .replacingOccurrences(of: ",", with: ".")

        let allowed = Set("0123456789.")

        guard !cleaned.isEmpty,
              cleaned.allSatisfy({ allowed.contains($0) }),
              cleaned.filter({ $0 == "." }).count <= 1
        else {
            return nil
        }

        return Double(cleaned)
    }
}
