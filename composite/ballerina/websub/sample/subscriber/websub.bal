package ballerina.websub.sample.subscriber;

import ballerina.io;
import ballerina.net.http;
import ballerina.net.websub;

endpoint websub:SubscriberServiceEndpoint websubEP {
    host:"localhost",
    port:8181
};

@websub:SubscriberServiceConfig {
    basePath:"/websub",
    subscribeOnStartUp:true,
    topic: "http://www.websubpubtopic.com",
    hub: "https://localhost:9999/websub/hub",
    leaseSeconds: 3600000,
    secret: "Kslk30SNF2AChs2"
}
service<websub:SubscriberService> websubSubscriber bind websubEP {

    onVerifyIntent (endpoint client, http:Request request) {
        http:Response response = {};
        response = websub:buildSubscriptionVerificationResponse(request);
        io:println("Intent verified for subscription request");
        _ = client -> respond(response);
    }

    onNotification (endpoint client, http:Request request) {
        http:Response response = { statusCode:202 };
        _ = client -> respond(response);
        websub:WebSubNotification webSubNotification;
        websub:WebSubError webSubError;
        webSubNotification, webSubError = websub:processWebSubNotification(request);
        if (webSubError == null) {
            io:println("WebSub Notification Received: " + webSubNotification.payload.toString());
        } else {
            io:println("Error occurred processing WebSub Notification: " + webSubError.errorMessage);
        }
    }

}

