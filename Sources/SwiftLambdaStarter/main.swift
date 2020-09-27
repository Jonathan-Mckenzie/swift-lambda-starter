import Foundation
import AWSLambdaRuntime
import AWSLambdaEvents
import IpWhitelistCheckerLib

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
let ipChecker = IpWhitelistChecker([])

/*
 TODO:
 - (done) only allow certain IPs to access this lambda function
 - set an environment variable to replace "friend" in the responses
 */

Lambda.run { (context, request: APIGateway.V2.Request, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) in
    
    // debug requests coming in
    context.logger.debug("\(request)");
    
    guard request.context.http.path == "/test" else {
        return callback(.success(APIGateway.V2.Response(statusCode: HTTPResponseStatus.notFound)))
    }
    
    guard ipChecker.isValid(request.context.http.sourceIp) else {
        return callback(.success(APIGateway.V2.Response(statusCode: HTTPResponseStatus.forbidden)))
    }
    
    let response: APIGateway.V2.Response
    
    switch (request.context.http.path, request.context.http.method) {
    case ("/test", .GET):
        response = APIGateway.V2.Response(
            statusCode: HTTPResponseStatus.ok,
            headers: ["content-type": "application/json"],
            body: try! jsonEncoder.encodeAsString(Output(message: "hello friend."))
        )
        break
    case ("/test", .POST):
        do {
            let input = try jsonDecoder.decode(Input.self, from: request.body ?? "")
            let body = try jsonEncoder.encodeAsString(Output(message: input.name + ", hello friend."))
            response = APIGateway.V2.Response(statusCode: HTTPResponseStatus.ok, multiValueHeaders: ["content-type": ["application/json"]], body: body )
        } catch {
            response = APIGateway.V2.Response(statusCode: HTTPResponseStatus.badRequest, body: "missing name")
        }
        break
    default:
        response = APIGateway.V2.Response(statusCode: HTTPResponseStatus.badRequest)
    }
    
    callback(.success(response))
}




