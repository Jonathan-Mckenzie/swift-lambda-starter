// swift-tools-version:5.3
 // The swift-tools-version declares the minimum version of Swift required to build this package.
    
 import PackageDescription
    
 let package = Package(
   name: "SwiftLambdaStarter",
   platforms: [
    .macOS(.v10_13)
   ],
   products: [
     .executable(name: "SwiftLambdaStarter", targets: ["SwiftLambdaStarter"]),
     .library(name: "IpWhitelistCheckerLib", targets: ["IpWhitelistCheckerLib"])
   ],
   dependencies: [
     .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", .upToNextMajor(from:"0.2.0")),
   ],
   targets: [
     .target(
       name: "SwiftLambdaStarter",
       dependencies: [
            .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
            .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-runtime"),
            "IpWhitelistCheckerLib"
       ]
     ),
    .target(
        name: "IpWhitelistCheckerLib",
        dependencies: [],
        resources: [.copy("Resources/whitelist.txt")]
    ),
    .testTarget(
        name: "SwiftLambdaStarterTests",
        dependencies: [
            "SwiftLambdaStarter",
            "IpWhitelistCheckerLib"
        ]
    )
   ]
 )
