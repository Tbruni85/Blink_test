//
//  ErrorView.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import SwiftUI

struct ErrorView: View {

    private struct Constants {
        static let imageSize: CGFloat = 70
        static let messageTopPadding: CGFloat = 30
        static let buttonTopPadding: CGFloat = 30
    }

    let message: String
    let action: () -> Void

    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: Constants.imageSize))
                .foregroundStyle(.red)
            Text(message)
                .font(.title2)
                .foregroundStyle(.red)
                .padding(.top, Constants.messageTopPadding)
            Button {
                action()
            } label: {
                Text("Retry")
                    .foregroundStyle(.red)
            }
            .padding(.top, Constants.buttonTopPadding)
        }
    }
}

#Preview {
    ErrorView(message: "Error", action: {})
}
