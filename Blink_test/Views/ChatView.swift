//
//  ChatView.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import SwiftUI

struct ChatView: View {

    private struct Constants {
        static let inputFieldPadding: CGFloat = 10
        static let inputFieldCornerRadius: CGFloat = 20
        static let sendButtonSize: CGFloat = 36
        static let inputViewVerticalPadding: CGFloat = 8
    }

    let viewModel: ChatViewModel
    @State private var messageText = ""

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(TimeFormatter.sortMessages(viewModel.chat.messages), id: \.last_updated) { message in
                        MessageView(message: message, userUUID: viewModel.userUUID)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.inset)

                HStack {
                    TextField("Message...", text: $messageText)
                        .padding(Constants.inputFieldPadding)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: Constants.inputFieldCornerRadius))

                    Button {
                        sendMessage()
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: Constants.sendButtonSize, height: Constants.sendButtonSize)
                            .foregroundStyle(.blue)
                    }
                    .disabled(messageText.isEmpty)
                }
                .padding(.horizontal)
                .padding(.vertical, Constants.inputViewVerticalPadding)
            }
            .navigationTitle(viewModel.chat.name)
        }
    }

    private func sendMessage() {
        let trimmed = messageText.trimmingCharacters(in: .whitespaces)
        // discard space only message
        guard !trimmed.isEmpty else { return }
        viewModel.sendMessage(trimmed)
        messageText = ""
    }
}
