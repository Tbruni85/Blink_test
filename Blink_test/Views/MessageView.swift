//
//  MessageView.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import SwiftUI

struct MessageView: View {

    let message: Message
    let userUUID: UUID

    var body: some View {
        if userUUID.uuidString == message.id {
            VStack(alignment: .leading) {
                Text(message.text)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemGreen))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(message.formattedTime)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        } else {
            VStack(alignment: .trailing) {
                Text(message.text)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemCyan))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(message.formattedTime)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 4)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
        }
    }
}
