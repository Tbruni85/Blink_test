//
//  ContentView.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import SwiftUI

struct ChatsListView: View {

    @ObservedObject var viewModel: ChatsViewModel

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .idle:
                    EmptyView()
                case .loading:
                    Spacer()
                    ProgressView("Loading chats...")
                        .progressViewStyle(.circular)
                    Spacer()
                case .data(let array):
                    List {
                        ForEach(array, id: \.key) { group in
                            Section("\(group.key)") {
                                ForEach(group.value) { chat in
                                    NavigationLink(destination: ChatView(viewModel: ChatViewModel(chatID: chat.id, chatsViewModel: viewModel))) {
                                        ChatRowView(chatName: chat.name)
                                    }
                                }
                            }
                            .listSectionSeparator(.hidden)

                        }
                    }
                    .listStyle(.inset)
                case .error(let message):
                    ErrorView(message: message) {
                        Task {
                            await viewModel.fetchData()
                        }
                    }
                }
            }
            .navigationTitle("Chats")
            .onAppear {
                Task { await viewModel.fetchData() }
            }

        }
    }
}

#Preview {
    ChatsListView(viewModel: ChatsViewModel(dataProvider: DataProvider()))
}
