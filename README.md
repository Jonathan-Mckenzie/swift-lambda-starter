# Swift Lambda Starter

Starter project to explore the capabilities of creating http rest endpoints with lambdas written in Swift.


## Get up and Running

1. Launch xcode and import project
1. Set environment variable `LOCAL_LAMBDA_SERVER_ENABLED` to `true`
1. Run from xcode

## Test local environment
Runs a test http server that listens for /invoke and injects the request into the context of the lambda function.
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

## Build and Deploy

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

