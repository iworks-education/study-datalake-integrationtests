Feature: API used by the Shield agent team, responsible for managing Avengers registration data 

Background:
* url endpoint
* def cognito_conf = clientid + ',' + userpoolid + ',' + username + ',' + password


 * def getToken =
"""
function(cognito_conf) {
 var TokenGenerator = Java.type('com.iwe.authorization.TokenGenerator');
 var sg = new TokenGenerator(cognito_conf);
 return sg.getToken();
}
"""
* def token = call getToken cognito_conf

Scenario: Creates a new Study Task and search by Tag

Given path 'study'
And header Authorization = 'Bearer ' + token
And request 
"""
{
    "topic": "AWS",
    "dateTimeCreation": "2020-07-17T13:00:00Z",
    "tag": "lambda",
    "url": "https://aws.amazon.com/lambda/",
    "description": "AWS Lambda lets you run code without provisioning or managing servers",
    "consumed": false
}
"""
When method post
Then status 502

* def studyTaskRegistered = response

# Get Study Task by Tag
Given path 'study', 'AWS', 'findByTag'
And param tag = 'lambda'
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match $[0] == studyTaskRegistered

Scenario: Creates a list of studies and search by period

Given path 'study'
And header Authorization = 'Bearer ' + token
And request 
"""
{
    "topic": "devops",
    "dateTimeCreation": "2020-07-20T13:00:00Z",
    "tag": "codebuild",
    "url": "https://aws.amazon.com/codebuild/",
    "description": "AWS CodeBuild is AWSome",
    "consumed": false
}
"""
When method post
Then status 201

Given path 'study'
And header Authorization = 'Bearer ' + token
And request 
"""
{
    "topic": "devops",
    "dateTimeCreation": "2020-07-21T13:00:00Z",
    "tag": "codedeploy",
    "url": "https://aws.amazon.com/codedeploy/",
    "description": "AWS CodeDeploy is AWSome",
    "consumed": false
}
"""
When method post
Then status 201

* def studyTaskRegistered = response

# Get Study Task Period
Given path 'study', 'devops', 'findByPeriod'
And param starts = '2020-07-20T13:00:00Z'
And param ends = '2020-07-21T13:00:00Z'
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match $ == '#[2]'

Scenario: Creates a list of studies and search for consumed

Given path 'study'
And header Authorization = 'Bearer ' + token
And request 
"""
{
    "topic": "machinelearning",
    "dateTimeCreation": "2020-07-20T13:00:00Z",
    "tag": "sagemaker",
    "url": "https://aws.amazon.com/sagemaker/",
    "description": "Amazon Sagemaker is AWSome",
    "consumed": true
}
"""
When method post
Then status 201

Given path 'study'
And header Authorization = 'Bearer ' + token
And request 
"""
{
    "topic": "machinelearning",
    "dateTimeCreation": "2020-07-21T13:00:00Z",
    "tag": "rekognition",
    "url": "https://aws.amazon.com/rekognition/",
    "description": "Amazon Rekognition is AWSome",
    "consumed": true
}
"""
When method post
Then status 201

* def studyTaskRegistered = response

# Get Study Task Period
Given path 'study', 'machinelearning', 'findByIsConsumed'
And param isconsumed = 'true'
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match $ == '#[2]'