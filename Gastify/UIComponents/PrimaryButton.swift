//
//  PrimaryButton.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import SwiftUI

struct PrimaryButton: View {

    let label: String
    let disabled: Bool
    let action: () -> Void

    init(label: String,
         disabled: Bool = false,
         action: @escaping () -> Void) {
        self.label = label
        self.disabled = disabled
        self.action = action
    }

    var body: some View {
        Button(action: self.action) {
            Text(self.label)
                .font(.label(weight: .medium))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 10).fill(self.disabled ? Color.tertiary.opacity(0.5) : Color.primary))
        }
        .disabled(self.disabled)
    }
}

#Preview {
    Group {
        PrimaryButton(label: "Botón") {}
        PrimaryButton(label: "Botón", disabled: true) {}
    }.padding()
}
