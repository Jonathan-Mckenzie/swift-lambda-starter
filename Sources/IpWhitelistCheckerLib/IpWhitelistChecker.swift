

public class IpWhitelistChecker {
    
    var ipSet: Set<String>
    
    public init(_ ips: [String]) {
        ipSet = Set(ips)
    }
    
    // TODO: tie to check a list of IPs
    public func isValid(_ ipAddress: String) -> Bool {
        return ipSet.contains(ipAddress)
    }
    
}

