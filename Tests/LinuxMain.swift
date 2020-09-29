import XCTest

import SwiftLambdaStarterTests
import IpWhitelistCheckerTests
import EnvironmentTests

var tests = [XCTestCaseEntry]()
tests += SwiftLambdaStarterTests.allTests()
tests += IpWhitelistCheckerTests.allTests()
tests += EnvironmentTests.allTests()
XCTMain(tests)
