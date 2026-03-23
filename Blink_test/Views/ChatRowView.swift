//
//  ChatRowView.swift
//  Blink_test
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import SwiftUI

struct ChatRowView: View {

    let chatName: String

    var body: some View {
        HStack {
            Text(chatName)
        }
        .padding()
    }
}
