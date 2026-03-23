//
//  DataMappingTests.swift
//  Blink_testTests
//
//  Created by Tiziano Bruni on 21/03/2026.
//

import XCTest
@testable import Blink_test

final class DataMappingTests: XCTestCase {

    @MainActor
    func test_data_mapping() {
        let data = Bundle.main.decode([Chat].self, from: "conversations.json")
        XCTAssertNotNil(data)
    }
}
