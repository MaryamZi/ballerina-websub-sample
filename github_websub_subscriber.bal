import ballerina/log;
import ballerina/mime;
import ballerina/net.http;
import ballerina/net.websub;

endpoint websub:SubscriberServiceEndpoint websubEP {
    host:"localhost",
    port:8181
};

@websub:SubscriberServiceConfig {
    basePath:"/githubwebhook",
    secret: "XKslk30SNF2AChs2"
}
service<websub:SubscriberService> githubwebhookListener bind websubEP {

    onNotification (endpoint client, http:Request request) {
        http:Response response = { statusCode:202 };
        _ = client -> respond(response);

        match (request.getJsonPayload()) {
            json jsonPayload => { log:printInfo("WebSub Notification Received: " + jsonPayload.toString()); }
            mime:EntityError => { log:printError("Error occurred extracting WebSub Notification"); }
        }

    }

}
