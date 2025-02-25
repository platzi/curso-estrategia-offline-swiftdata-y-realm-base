//
//  Fonts.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//
import SwiftUI

private enum CustomFonts: String {
    case RobotoRegular = "Roboto-Regular"
    case RobotoMedium = "Roboto-Medium"
    case RobotoMonoRegular = "RobotoMono-Regular"
    case RobotoMonoMedium = "RobotoMono-Medium"
}

enum CustomFontsSize: CGFloat {
    case small = 14.0
    case medium = 16.0
    case large = 24.0
    case extraLarge = 36.0
}

enum CustomFontsWeight {
    case regular
    case medium
}

extension Font {
    static func title(size: CustomFontsSize = .extraLarge, weight: CustomFontsWeight = .medium) -> Font {
        switch weight {
        case .medium:
            return Font.custom(CustomFonts.RobotoMonoMedium.rawValue, size: size.rawValue)
        case .regular:
            return Font.custom(CustomFonts.RobotoMonoRegular.rawValue, size: size.rawValue)
        }
    }

    static func label(size: CustomFontsSize = .medium, weight: CustomFontsWeight = .regular) -> Font {
        switch weight {
        case .medium:
            return Font.custom(CustomFonts.RobotoMedium.rawValue, size: size.rawValue)
        case .regular:
            return Font.custom(CustomFonts.RobotoRegular.rawValue, size: size.rawValue)
        }
    }
}
