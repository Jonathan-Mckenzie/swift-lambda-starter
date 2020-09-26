import XCTest
import class Foundation.Bundle

final class SwiftLambdaStarterTests: XCTestCase {
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        let fooBinary = productsDirectory.appendingPathComponent("swift-lambda-starter")

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        
        let expectation = self.expectation(description: "Http Requests")

        let json: [String: Any] = [
            "routeKey": "GET /test",
            "version": "2.0",
            "rawPath": "/test",
            "stageVariables": Dictionary<String, Any>(),
            "requestContext": [
                "timeEpoch": 1601068350455,
                "domainPrefix": "TEST",
                "accountId": "1231231123",
                "stage": "$default",
                "domainName": "lambda.test.com",
                "apiId": "pb5dg6g3rg",
                "requestId": "LgLpnibOFiAEPCA=",
                "http": [
                    "path": "/test",
                    "userAgent": "Paw/3.1.10 (Macintosh; OS X/10.15.4) GCDHTTPRequest",
                    "method": "GET",
                    "protocol": "HTTP/1.1",
                    "sourceIp": "142.250.68.14"
                ],
                "time": "25/Sep/2020:12:47:41 +0000"
            ],
            "body": "",
            "isBase64Encoded": false,
            "rawQueryString": "",
            "headers": [
                "host": "lambda.test.com",
                "user-agent": "Paw/3.1.10 (Macintosh; OS X/10.15.4) GCDHTTPRequest",
                "content-length": "0"
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        
        let url = URL(string: "http://localhost:7000/invoke")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        var responseJson: [String: Any] = [:]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            print("errors: \(String(describing: error))")
            print("response: \(String(describing: response))")
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("data: \(responseJSON)")
                responseJson = responseJSON
            }
            
            expectation.fulfill()
        }

        // fire the http request
        task.resume()
        
        // wait for the request call back to execute
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(responseJson["statusCode"] as! Int, 200)
        XCTAssertEqual(responseJson["body"] as! String, "{\"message\":\"hello friend.\"}")

        // kill the server
        process.terminate()
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
