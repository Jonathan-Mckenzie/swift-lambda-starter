import XCTest
@testable import IpWhitelistCheckerLib

final class IpAddressFileReaderTests: XCTestCase {
    
    func testForSmoke() {
        let reader = IpAddressFileReader("whitelist.txt")
        print(reader.ipAddresses)
    }
    
    static var allTests = [
        ("testForSmoke", testForSmoke)
    ]
    
}

