import XCTest

import SwiftLambdaStarterTests
import IpWhitelistCheckerTests
import IpAddressFileReaderTests

var tests = [XCTestCaseEntry]()
tests += SwiftLambdaStarterTests.allTests()
tests += IpWhitelistCheckerTests.allTests()
tests += IpAddressFileReaderTests.allTests()
XCTMain(tests)
