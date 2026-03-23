//
//  ConversationsViewModel.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import Combine
import Foundation

public enum ChatsViewState {
    case idle
    case loading
    case data([GroupedChats])
    case error(String)

    var groupedChats: [GroupedChats]? {
        if case .data(let chats) = self { return chats }
        return nil
    }
}

public typealias GroupedChats = (key: String, value: [Chat])

@MainActor
public class ChatsViewModel: ObservableObject {

    @Published var viewState: ChatsViewState = .idle

    public let userUUID: UUID
    private let dataProvider: DataProviderProviding

    init(dataProvider: DataProviderProviding) {
        self.dataProvider = dataProvider
        self.userUUID = UUID()
    }

    public func fetchData() async {
        do {
            viewState = .loading
            let data = try await dataProvider.fetchData()
            viewState = .data(TimeFormatter.groupData(data))
        } catch {
            viewState = .error("Failed to fetch the list of chats.")
        }
    }

    func appendMessage(_ message: Message, to chatID: String) async {
        // we cannot append data if there are any, so viewState must be .data
        guard case .data(var groups) = viewState else { return }

        for groupIndex in groups.indices {
            if let chatIndex = groups[groupIndex].value.firstIndex(where: { $0.id == chatID }) {
                groups[groupIndex].value[chatIndex].appendMessage(message)
                viewState = .data(groups)
                await saveData(groups)
                return
            }
        }
    }

    private func saveData(_ chats: [GroupedChats]) async {
        let chats = chats.flatMap(\.value)
        do {
            try await dataProvider.saveData(chats)
        } catch {
            print("Failed to persist chats: \(error)")
        }
    }
}
