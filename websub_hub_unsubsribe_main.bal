import ballerina/io;
import ballerina/net.http;
import ballerina/net.websub;

endpoint websub:HubClientEndpoint websubHubClientEP {
   uri: "https://localhost:9999/websub/hub"
};

function main (string [] args) {
   websub:SubscriptionChangeRequest subscriptionChangeRequest = {topic:"http://www.websubpubtopic.com", callback:"http://localhost:8181/websub"};

   var subscriptionChangeResponse = websubHubClientEP -> unsubscribe(subscriptionChangeRequest);

   match (subscriptionChangeResponse) {
       websub:SubscriptionChangeResponse subs => io:println(“Successful”);
       websub:WebSubError err => io:println(“Unsuccessful”);
   }
}
