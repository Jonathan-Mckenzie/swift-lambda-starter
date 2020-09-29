import XCTest
@testable import SwiftLambdaStarterLib

final class IpWhitelistCheckerTests: XCTestCase {
    
    
    func testEmptyIps() {
        let checker = IpWhitelistChecker([])
        XCTAssertFalse(checker.isValid("127.0.0.1"))
    }
    
    func testWIthOneIp() {
        let checker = IpWhitelistChecker(["127.0.0.1"])
        XCTAssertTrue(checker.isValid("127.0.0.1"))
        XCTAssertFalse(checker.isValid("192.168.1.1"))
    }
    
    func testWithMoreThanOneIp() {
        let checker = IpWhitelistChecker(["127.0.0.1", "192.168.1.1"])
        XCTAssertTrue(checker.isValid("127.0.0.1"))
        XCTAssertTrue(checker.isValid("192.168.1.1"))
        XCTAssertFalse(checker.isValid("192.168.0.1"))
    }

    func testExternalList() {
        let list: [String] = IpAddresses.list;
        XCTAssertTrue(list.contains("192.168.0.1"))
        XCTAssertTrue(list.contains("192.168.1.1"))
        XCTAssertTrue(list.contains("127.0.0.1"))
        XCTAssertFalse(list.contains("216.58.193.206"))
    }

    static var allTests = [
        ("testEmptyIps", testEmptyIps),
        ("testWIthOneIp", testWIthOneIp),
        ("testWithMoreThanOneIp", testWithMoreThanOneIp),
        ("testExternalList", testExternalList),
    ]
    
}
