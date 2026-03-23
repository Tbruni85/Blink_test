//
//  Message.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import Foundation

public struct Message: Sendable, Identifiable, Decodable, Equatable, Encodable {
    public let id: String
    let text: String
    let last_updated: String

    var formattedTime: String {
        TimeFormatter.formatChatTime(last_updated) ?? ""
    }

    public init(id: String, text: String, last_updated: String) {
        self.id = id
        self.text = text
        self.last_updated = last_updated
    }
}
