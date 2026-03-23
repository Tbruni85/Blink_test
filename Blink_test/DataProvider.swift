//
//  DataProvider.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import Foundation

public protocol DataProviderProviding: Actor {
    func fetchData() throws -> [Chat]
    func saveData(_ chats: [Chat]) throws
}

public enum DataProviderError: Error {
    case bundleURLNotFound
}

public actor DataProvider: DataProviderProviding {

    let fileURL: URL = {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("conversations.json")
    }()

    private func checkSaveFileExists() {
        guard !FileManager.default.fileExists(atPath: fileURL.path),
              let bundleURL = Bundle.main.url(forResource: "conversations", withExtension: "json") else { return }
        try? FileManager.default.copyItem(at: bundleURL, to: fileURL)
    }

    public func fetchData() throws -> [Chat] {

        checkSaveFileExists()

        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Chat].self, from: data)
    }

    public func saveData(_ chats: [Chat]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(chats)
        try data.write(to: fileURL, options: .atomic)
    }
}
