//
//  TimeFormatter.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import Foundation

public struct TimeFormatter {

    static func formatChatTime(_ time: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yy HH:mm:ss"

        guard let date = isoFormatter.date(from: time) else {
            return nil
        }

        return outputFormatter.string(from: date)
    }

    static func groupData(_ data: [Chat]) -> [GroupedChats] {
        // we want to sort by date
        let sortFormatter = DateFormatter()
        sortFormatter.dateFormat = "dd/MM/yy"

        let grouped = Dictionary(grouping: data) { chat -> String in
            // we extract the data from the string
            let components = chat.formattedTime.components(separatedBy: " ")
            return components.first ?? chat.formattedTime
        }
        // we sort the data
        return grouped.sorted {
            guard let d1 = sortFormatter.date(from: $0.key),
                  let d2 = sortFormatter.date(from: $1.key) else { return false }
            return d1 > d2
        }
    }

    static func sortMessages(_ messages: [Message]) -> [Message] {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy HH:mm:ss"

        return messages.sorted {
            guard let d1 = formatter.date(from: $0.formattedTime), let d2 = formatter.date(from: $1.formattedTime) else { return false }
            return d1 < d2
        }
    }
}
