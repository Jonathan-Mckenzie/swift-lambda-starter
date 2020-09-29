# Swift Lambda Starter

Starter project to both learn the Swift language and explore the capabilities of creating http rest endpoints using Lambdas. 
  
✅ Swift Lambda Runtime  
✅ AWS API Gateway  
✅ Testing framework  
✅ Unit Testing    
✅ Compile both an Executable and a Library      
✅ Build Toolchain  
✅ Environment Variables  
✅ Ip Address Whitelist  
✅ Guards against http paths  
✅ Switching logic on request type  
✅ Link to class from another module          
❌ Bundle resources (txt, json files) 
    
## Get up and Running

### Xcode
1. Launch xcode and import project
1. Edit Scheme -> Run -> Environment Variables
    1. `LOCAL_LAMBDA_SERVER_ENABLED` -> `true`
1. Run `SwiftLambdaStarter`
        
### Command-line
```
$ export LOCAL_LAMBDA_SERVER_ENABLED=true
$ swift build
$ .build/debug/SwiftLambdaStarter
```

## Test local environment
Runs a test http server that listens for /invoke and injects the request into the context of the lambda function.

### Xcode
- Test from Run dropdown

### Command-line
```
$ swift test
```

### Test local lambda server

```
POST: http://localhost:7000/invoke
```

```
Example Body:
{
    "routeKey":"POST /test",
    "version":"2.0",
    "rawPath":"/test",
    "stageVariables":{},
    "requestContext":{
        "timeEpoch":1601068350455,
        "domainPrefix":"TEST",
        "accountId":"12308123081",
        "stage":"$default",
        "domainName":"lambda.test.com",
        "apiId":"pb5dg6g3rg",
        "requestId":"LgLpnibOFiAEPCA=",
        "http":{
            "path":"/test",
            "userAgent":"Paw/3.1.10 (Macintosh; OS X/10.15.4) GCDHTTPRequest",
            "method":"POST",
            "protocol":"HTTP/1.1",
            "sourceIp":"142.250.68.14"
        },
        "time":"25/Sep/2020:12:47:41 +0000"
    },
    "body": "{\"name\":\"Elliot\"}",
    "isBase64Encoded":false,
    "rawQueryString":"",
    "headers":{
        "host":"lambda.test.com",
        "user-agent":"Paw/3.1.10 (Macintosh; OS X/10.15.4) GCDHTTPRequest",
        "content-length":"0"
    }
}
```

## Build and Deploy (command-line only)

### Setup

- Docker up and running
- Create a container that builds and bundles Swift projects:
```
$ ./scripts/create-build-container.sh
```
- Build and Package the project
```
$ ./scripts/build.sh <project name>
```
- The final build can be found in: `.build/lambda/<project name>/lambda.zip`

### Make changes to Ip Address Whitelist
- make edits to `<project dir>/scripts/whitelist.txt`
    - new line separated
- run script from project dir:
```
$ cd ./scripts
$ ./generate-whitelist.sh
```

#### Gotchas
- Create an API Gateway
    1. After creating lambda, navigate directly to API Gateway in aws console
    1. Create HTTP API
    1. Add lambda function as an integration
    1. Be sure to select version 2.0 
    
- Xcode quietly fails to launch the project
    1. Check if port 7000 is being used
    
- Resolving bundle resources appears to be broken when running in target release environment
    1. This problem occurred when bundling `whitelist.txt` with the source
    1. Amazon linux bundle path seems to be out of sync between runtime path
    1. keep a look out for future releases of Swift that addresses this
    
- No longer dependent on Xcode to build and test this project
    1. preferred IDE: CLion with Swift plugin
