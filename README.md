# Ballerina WebSub Samples

This repository contains samples demonstrating the Ballerina WebSub implementation's functionality/capabilities.

[WebSub Subscriber Service Sample](websub_subscriber.bal) demonstrates a WebSub subscriber service which defines both 
the allowed resources - onVerifyIntent and onNotification.

[WebSub Publisher Sample](websub_publisher.bal) demonstrates a publisher bringing up a Ballerina Hub and publishing 
against it directly and also considering it a remote Ballerina WebSub Hub.

[WebSub Hub Client Sample](websub_hub_unsubsribe_main.bal) demonstrates using the Ballerina WebSub Hub Client Endpoint 
to explicitly send an unsubscription request.

[WebSub Subscriber Service for GitHub Sample](github_websub_subscriber.bal) demonstrates using Ballerina's WebSub 
implementation in partially WebSub compliant scenarios. Here signature validation is performed for a Webhook registered 
via the GitHub UI.

1. Start up the service
```cmd
ballerina run github_websub_subscriber.bal
```
        
2. Expose the service running on localhost to the internet
```cmd
./ngrok http 8181
```
3. Add a webhook to a GitHub repository, which you have admin access to.

    <GITHUB_REPO> → Settings → Webhooks → Add webhook and specify:
    
    i. Payload URL: <ngrok_url>/githubWebhook/listener  
      
    ii. Content type: application/json
    
    iii. Select “Which events would you like to trigger this webhook?”
    
    For example select “Let me select individual events.” and select “Issues” and “Issue Comments”
    
    iv. Specify "XKslk30SNF2AChs2" as the secret
    
    v. Tick “Active” to mark the webhook as active
    
    vi. Add webhook
    
4. Test the webhook by creating an issue, and adding comments on the issue.
5. Test intercepting requests that fail signature validation by changing the secret on GitHub and then triggering 
notifications. Since the secret specified as an annotation is different from that on GitHub, signature validation will 
fail
