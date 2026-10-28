//
//  BodyShape.swift
//  OnboardingPage
//
//  Created by deemaalqassem on 16/05/1448 AH.
//

import Foundation

enum BodyShape: Hashable {
    case pear
    case hourglass
    case apple
    case invertedTriangle

    static func from(bust: Double, waist: Double, hips: Double) -> BodyShape {
        let waistRatio = waist / max(bust, hips, 1)

        if waistRatio <= 0.75 &&
            abs(bust - hips) / max(bust, hips, 1) <= 0.10 {
            return .hourglass
        } else if hips > bust * 1.10 {
            return .pear
        } else if bust > hips * 1.10 {
            return .invertedTriangle
        } else {
            return .apple
        }
    }

    var title: String {
        switch self {
        case .hourglass:        return "Hourglass-Type"
        case .pear:             return "Pear-Type"
        case .invertedTriangle: return "Inverted Triangle-Type"
        case .apple:            return "Apple-Type"
        }
    }

    var imageName: String {
        switch self {
        case .hourglass:        return "hourglass"
        case .pear:             return "pear"
        case .invertedTriangle: return "Inverted Tringle"
        case .apple:            return "apple"
        }
    }
}
