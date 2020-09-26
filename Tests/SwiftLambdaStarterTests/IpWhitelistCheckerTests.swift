import XCTest
@testable import IpWhitelistCheckerLib

final class IpWhitelistCheckerTests: XCTestCase {
    
    
    func testForSmoke() {
        let checker = IpWhitelistChecker()
        XCTAssertTrue(checker.isValid("127.0.0.1"))
    }
    
    
    static var allTests = [
        ("testForSmoke", testForSmoke)
    ]
    
}
