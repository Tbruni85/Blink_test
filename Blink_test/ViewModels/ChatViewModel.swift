//
//  ChatViewModel.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 22/03/2026.
//

import Combine
import Foundation

@MainActor
public class ChatViewModel: ObservableObject {
    
    private let chatID: String
    private let chatsViewModel: ChatsViewModel
    private var cancellable: AnyCancellable?
    
    var chat: Chat {
        guard case .data(let groups) = chatsViewModel.viewState, let chat = groups.flatMap(\.value).first(where: { $0.id == chatID }) else {
            return Chat(id: "", name: "", last_updated: "", messages: [])
        }
        return chat
    }
    
    var userUUID: UUID { chatsViewModel.userUUID }
    
    init(chatID: String, chatsViewModel: ChatsViewModel) {
        self.chatID = chatID
        self.chatsViewModel = chatsViewModel
        
        cancellable = chatsViewModel.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
    }
    
    func sendMessage(_ text: String) {
        Task {
            let message = Message(id: userUUID.uuidString, text: text, last_updated: ISO8601DateFormatter().string(from: Date()))
            await chatsViewModel.appendMessage(message, to: chatID)
        }
    }
}
