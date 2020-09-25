import Foundation
import AWSLambdaRuntime
import AWSLambdaEvents

extension JSONEncoder {
    func encodeAsString<T: Encodable>(_ value: T) throws -> String {
        try String(decoding: self.encode(value), as: Unicode.UTF8.self)
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        try self.decode(type, from: Data(string.utf8))
    }
}


struct Input: Codable {
    var name: String
}

struct Output: Codable {
    var message: String
}


let jsonEncoder = JSONEncoder()
let jsonDecoder = JSONDecoder()


Lambda.run { (context, request: APIGateway.V2.Request, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) in
    
    guard request.context.http.method == HTTPMethod.POST, request.context.http.path == "/hello" else {
        return callback(.success(APIGateway.V2.Response(statusCode: HTTPResponseStatus.notFound)))
    }
    
    do {
        let input = try jsonDecoder.decode(Input.self, from: request.body ?? "")
        let body = try jsonEncoder.encodeAsString(Output(message: input.name + " , hello friend."))
        let response = APIGateway.V2.Response(statusCode: HTTPResponseStatus.ok, multiValueHeaders: ["content-type": ["application/json"]], body: body )
        callback(.success(response))
    } catch {
        callback(.success(APIGateway.V2.Response(statusCode: HTTPResponseStatus.badRequest)))
    }
}




