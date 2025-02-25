//
//  LoadingView.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .tint(Color.primary)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.dark.opacity(0.4))
    }
}

#Preview {
    LoadingView()
}
