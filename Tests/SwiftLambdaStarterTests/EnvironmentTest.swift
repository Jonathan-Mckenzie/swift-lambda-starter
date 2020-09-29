import XCTest
import Foundation
@testable import SwiftLambdaStarterLib

final class EnvironmentTests: XCTestCase {

    func testSingleton() {
        let e = EnvironmentService.shared
        let e2 = EnvironmentService.shared
        XCTAssertTrue(e === e2);
    }

    func testDefaultValue() {
        XCTAssertTrue(EnvironmentService.shared.greetingNoun == "friend")
    }

    static let allTests = [
        ("testSingleton", testSingleton),
        ("testDefaultValue", testDefaultValue)
    ]
}