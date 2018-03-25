./../ballerina run ballerina/websub/sample/publisher/ &
sleep 10s #allow hub start up before subscriber service starts up
./../ballerina run ballerina/websub/sample/subscriber/
