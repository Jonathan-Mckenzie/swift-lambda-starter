
public class IpWhitelistChecker {
    
    var ipSet: Set<String>
    
    public init(_ ips: [String]) {
        ipSet = Set(ips)
    }

    public func isValid(_ ipAddress: String) -> Bool {
        return ipSet.contains(ipAddress)
    }
    
}

