//
//  Message.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import Foundation

public struct Chat: Sendable, Identifiable, Decodable, Encodable {
    public let id: String
    let name: String
    private var last_updated: String
    public private(set) var messages: [Message]

    var formattedTime: String {
        TimeFormatter.formatChatTime(last_updated) ?? ""
    }

    public init(id: String, name: String, last_updated: String, messages: [Message]) {
        self.id = id
        self.name = name
        self.last_updated = last_updated
        self.messages = messages
    }

    mutating func appendMessage(_ message: Message) {
        messages.append(message)
        updateLast_update(message.last_updated)
    }

    private mutating func updateLast_update(_ last_update: String) {
        last_updated = last_update
    }
}
