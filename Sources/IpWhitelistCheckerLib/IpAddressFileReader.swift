import Foundation

enum FileReaderError: String, Error {
    case IncorrectFilename = "Filename must be in the format of \"file.extension\""
    case FileNotFound = "Ip Address file was not found in bundle"
}

public class IpAddressFileReader {
    
    public var ipAddresses: [String] = []
    
    private var filenameWithoutExtension: String = ""
    private var filenameExtension: String = ""
    
    public init(_ filename: String) throws {
        do {
            try processFilename(filename)
        } catch {
            throw error
        }

        var contents: String = ""
        let fileUrl: Optional<String> = Bundle.module.path(forResource: filenameWithoutExtension, ofType: filenameExtension)

        guard fileUrl != nil else {
            throw FileReaderError.FileNotFound
        }

        do {
            contents = try String(contentsOfFile: fileUrl!, encoding: String.Encoding.utf8)
        } catch {
            throw error
        }

        processIpAddresses(contents)
    }
    
    private func processFilename(_ filename: String) throws {
        let parts: [String] = filename.components(separatedBy: ".")
        
        guard parts.count == 2 else {
            throw FileReaderError.IncorrectFilename
        }

        filenameWithoutExtension = parts[0];
        filenameExtension = parts[1];
    }

    private func processIpAddresses(_ fileContents: String) {
        ipAddresses = fileContents.components(separatedBy: .newlines).filter { $0 != "" }
    }

}

