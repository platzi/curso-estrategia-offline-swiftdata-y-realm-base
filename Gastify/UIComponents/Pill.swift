//
//  Pill.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import SwiftUI

enum PillStatus {
    case selected
    case unselected
}

struct Pill: View {

    let label: String
    let color: Color
    let status: PillStatus
    let action: () -> Void

    init(label: String,
         color: Color = .primary,
         status: PillStatus = .selected,
         action: @escaping () -> Void) {
        self.label = label
        self.color = color
        self.status = status
        self.action = action
    }

    private var backgroundColor: Color {
        self.status == .selected ? color : Color.white
    }

    private var textColor: Color {
        self.status == .selected ? Color.white : color
    }

    var body: some View {
        Button(action: {
            self.action()
        }) {
            if self.status == .selected {
                Text(label)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .foregroundStyle(self.textColor)
                    .font(.label(size: .small))
                    .background(self.backgroundColor
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))))
            } else {
                Text(label)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .foregroundStyle(self.textColor)
                    .font(.label(size: .small))
                    .background(self.textColor
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)).stroke(style:  StrokeStyle(lineWidth: 1, lineCap: .round))))
            }
        }
    }
}

#Preview {
    Group {
        Pill(label: "Este mes") {}
        Pill(label: "Este mes", status: .unselected) {}
    }
}
