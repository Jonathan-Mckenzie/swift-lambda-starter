import Foundation

public class EnvironmentService {

    public static let shared = EnvironmentService()
    var greetingNoun: String

    private init() {
        greetingNoun = ProcessInfo.processInfo.environment["greetingNoun"] ?? "friend"
    }

}
