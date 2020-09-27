import XCTest

import SwiftLambdaStarterTests
import IpWhitelistCheckerTests

var tests = [XCTestCaseEntry]()
tests += SwiftLambdaStarterTests.allTests()
tests += IpWhitelistCheckerTests.allTests()
XCTMain(tests)
