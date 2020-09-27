import Foundation

public class IpAddressFileReader {
    
    public var ipAddresses: [String.SubSequence]
    
    public init(_ pathToFile: String) {
        var contents: String = ""
        
        

        let whitelistUrl: Optional<String> = Bundle.module.path(forResource: "whitelist", ofType: "txt")
        print("whitelist url: \(whitelistUrl ?? "<path not found>")")
        contents = try! String(contentsOfFile: whitelistUrl ?? "")
        print("whitelist contents: \(contents)")
        

        ipAddresses = []
    }
    
    
    
}

