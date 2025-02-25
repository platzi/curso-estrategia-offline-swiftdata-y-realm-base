//
//  IconImage.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import SwiftUI

enum CustomIcon: String {
    case arrowUp = "arrow_up"
    case arrowDown = "arrow_down"
    case close
    case filter
    case plus
}

struct IconImage: View {

    let icon: CustomIcon
    let size: CGFloat
    let color: Color

    init(_ icon: CustomIcon, size: CGFloat = 24, color: Color = .primary) {
        self.icon = icon
        self.size = size
        self.color = color
    }

    var body: some View {
        Image(icon.rawValue)
            .renderingMode(.template)
            .resizable()
            .frame(width: self.size, height: self.size)
            .foregroundStyle(self.color)
    }
}

#Preview {
    IconImage(.plus, size: 24, color: .dark)
}
