//
//  Blink_testApp.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import SwiftUI

@main
struct Blink_testApp: App {
    var body: some Scene {
        WindowGroup {
            let dataProvider = DataProvider()
            let viewModel = ChatsViewModel(dataProvider: dataProvider)
            ChatsListView(viewModel: viewModel)
        }
    }
}
