import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftLambdaStarterTests.allTests),
        testCase(IpWhitelistCheckerTests.allTests),
        testCase(EnvironmentTests.allTests)
    ]
}
#endif
