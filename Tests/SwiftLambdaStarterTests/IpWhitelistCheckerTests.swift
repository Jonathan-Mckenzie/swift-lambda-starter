import XCTest
@testable import IpWhitelistCheckerLib

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
    

    static var allTests = [
        ("testEmptyIps", testEmptyIps),
        ("testWIthOneIp", testWIthOneIp),
        ("testWithMoreThanOneIp", testWithMoreThanOneIp),
    ]
    
}
