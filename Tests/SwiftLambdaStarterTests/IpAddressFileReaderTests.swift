import XCTest
@testable import IpWhitelistCheckerLib

final class IpAddressFileReaderTests: XCTestCase {
    
    func testForSmoke() {
        let reader = try! IpAddressFileReader("whitelist.txt")
        let ipAddresses = reader.ipAddresses;
        XCTAssertTrue(ipAddresses.count > 0)
        XCTAssertTrue(ipAddresses.contains("99.84.231.120"))
    }
    
    static var allTests = [
        ("testForSmoke", testForSmoke)
    ]
    
}

