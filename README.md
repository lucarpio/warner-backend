# <img src="https://raw.githubusercontent.com/karatelabs/karate/master/karate-core/src/main/java/karate-logo.png" height="60" width="60"/> Karate Framework - Base Project (WarnerMedia API example)

- [Environment configuration](#environment-configuration)
  * [Java Development Kit](#java-development-kit)
  * [Eclipse IDE for Java Developers](#eclipse-ide-for-java-developers)
  * [Apache maven](#apache-maven)

- [Project plugins and dependencies](#project-plugins-and-dependencies)
  * [Dependencies](#dependencies)
  * [Plugins](#plugins)
    
- [Project structure](#project-structure)
  * [Features folder](#features-folder)
    + [Background](#background)
    + [Scenarios](#scenarios)
  * [Request folder](#request-folder)
  * [Response folder](#response-folder)
  * [Reusable_steps folder](#response-folder)
  * [Environment folder](#environment-folder)
  * [TestRunner file](#testrunner-file)
- [Run test by Eclipse IDE](#run-test-by-eclipse-ide)
- [Run test by console](#run-test-by-console)
- [Reports](#reports)


## Environment configuration
### Java Development Kit

Go to [this link to download JDK 1.8 ](https://www.oracle.com/sa/java/technologies/javase/javase-jdk8-downloads.html), go to *Java SE Development Kit* tab and download *Windows x64* version

#### Configure environment variable

1. Right click the Computer icon.
2. Choose Properties from the context menu.
3. Click the Advanced system settings link.
4. Click Environment Variables. 
5. In the section System Variables, create or edit **"JAVA_HOME"** variable and set path of java jdk. For example
```
Name  : JAVA_HOME
Value : C:\Program Files\Java\jdk1.8.0_211
```
6. In the section System Variables, create or edit **"path"** variable and set *%JAVA_HOME%\bin*. For example
```
Name  : path
Value : %JAVA_HOME%\bin
```


### Eclipse IDE for Java Developers

Download the stable version from [this link](https://www.eclipse.org/)  
During the instalation select **"Eclipse IDE for Java Developers"**



### Apache maven
Download the stable version from [this link](https://maven.apache.org/download.cgi). Select **Binary zip archive**

#### Configure environment variable
1. Right click the Computer icon.
2. Choose Properties from the context menu.
3. Click the Advanced system settings link.
4. Click Environment Variables. 
5. In the section System Variables, create or edit **"MAVEN_HOME"** variable and set path of apache maven. For example
```
Name  : MAVEN_HOME
Value : C:\Automatizacion\apache-maven-3.6.3
```
6. In the section System Variables, create or edit **"path"** variable and set *%MAVEN_HOME%\bin*. For example
```
Name  : path
Value : %MAVEN_HOME%\bin
```

## Project plugins and dependencies

### Dependencies
|      groupId      |     artifactId     | version |
| :---------------: | :----------------: | :-----: |
| com.intuit.karate |   karate-apache    |  0.9.5  |
| com.intuit.karate |   karate-junit5    |  0.9.5  |
|    commons-io     |     commons-io     |  0.9.5  |
|       junit       |       junit        | 4.13.2  |
| net.masterthought | cucumber-reporting |  5.3.1  |

### Plugins
|         groupId          |      artifactId       | version |
| :----------------------: | :-------------------: | :-----: |
| org.apache.maven.plugins | maven-compiler-plugin |  3.6.0  |
| org.apache.maven.plugins | maven-surefire-plugin | 2.22.2  |

## Project structure

```
└───systemic_qa_backend
    ├───.settings
    ├───src
    │   └───test
    │       └───java
    │           └───warnermedia
    │           │    ├───features
    │           │    ├───request
    │           │    └───response
    │           │
    │           └───core
    │           │    └───constants
    │           │
    │           └───utils
    │                └───util.java
    │
    └───target
```

### Features folder  
Contains list of features

get_content_request.feature
```Gherkin

@warner_poc_get @run
Feature: Get content request

    Background: Carga de variables
        * def res_get_contentrequest = read('../response/get_contentrequest.json')
        * def utils_class = Java.type('utils.util')
        * def util = new utils_class()

    Scenario Outline: Get content request - not found
        * def query = { feedID: <feedID>, contentID: <contentID>, typeID: <typeID> }

        Given url ambiente.urlWM
        And path path_content_request
        And params query
        When method get
        Then status 404
        And print response
        And match response == res_get_contentrequest
        And assert response.title == 'Not Found'

        Examples:
            | feedID | contentID  | typeID |
            | 122    | TEST_2     | 2      |
            | 122    | B3AT3-A_01 | 2      |
```
#### Background:
In this section we set:     
#### - Steps
Steps that will be replicated at the beginning of all scenarios
insert_new_request.feature

```Gherkin
* def req_insert_request = read('../request/insert_request.json')
```

#### - Util
Call feature that have helper steps   
example:
Util.feature

```Gherkin

@ignore
Feature:

Scenario:

* def random_string =
	 """ 
		function(length) {
		   var result           = '';
		   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
		   var charactersLength = characters.length;
		   for ( var i = 0; i < length; i++ ) {
		      result += characters.charAt(Math.floor(Math.random() * charactersLength));
		   }
		   return result;
		}
	 """
 
 * def random_number =
 	 """ 
		function(length) {
		   var result           = '';
		   var characters       = '123456789';
		   var charactersLength = characters.length;
		   for ( var i = 0; i < length; i++ ) {
		      result += characters.charAt(Math.floor(Math.random() * charactersLength));
		   }
		   return result;
		}
	  """	  
```

call from feature:

insert_new_request.feature

```Gherkin
* def utils_class = Java.type('utils.util')
* def util = new utils_class()
```

Use:
insert_new_request.feature

```Gherkin
* set req_insert_request.feedID = util.random_number(3) 
```

#### - Request
Calls to predefinited json structure to make a request  
Example:

insert_request.json

```json

{
  "contentID": "",
  "typeID": 1,
  "language": "",
  "nextAiring": "",
  "feedID": 1
}

```

call from feature:

```Gherkin
insert_new_request.feature

* def req_insert_request = read('../request/insert_request.json')
```

Use:

```Gherkin
    Scenario: Insert new request
        * set req_insert_request.contentID = util.random_string(8)
        * set req_insert_request.typeID = util.random_number(1)
        * set req_insert_request.language = 'ESP'
        * set req_insert_request.nextAiring = '2020-12-02T13:22:00.81+00:00'
        * set req_insert_request.feedID = util.random_number(3)

        Given url ambiente.urlWM
        And path path_insert_request
        And request req_insert_request
        When method post
        Then status 200
        And print response
        And match response == res_insert_request
```


#### - Response 
Calls to predefinited json structure to be validate type field or value
Example: 
insert_request.json

```json

{
    "idRequest": 1234,
    "contentID": "some string id",
    "statusID": 123,
    "statusDescription": "some description",
    "requestedDate": "some date",
    "statusDate": "some date"
}

```

Call:
```Gherkin
insert_new_request.feature

* def res_insert_request = read('../response/insert_request.json')
```

Use:
```Gherkin
 ...
 ....
    Given path path_create_user
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    And request req_insert_request
    When method post
    Then status 200
    And print response
    And match response == res_insert_request
    
```

#### Scenarios

```Gherkin
    Scenario: Insert new request
        * set req_insert_request.contentID = util.random_string(8)
        * set req_insert_request.typeID = util.random_number(1)
        * set req_insert_request.language = 'ESP'
        * set req_insert_request.nextAiring = '2020-12-02T13:22:00.81+00:00'
        * set req_insert_request.feedID = util.random_number(3)

        Given url ambiente.urlWM
        And path path_insert_request
        And request req_insert_request
        When method post
        Then status 200
        And print response
        And match response == res_insert_request
```
#### - Definitions

In this section we go to write the testcase with the follow definitions (some):
| definition | description                        |
| :--------- | :--------------------------------- |
| url        | set url                            |
| path       | set enpoint path                   |
| set        | set value to oject                 |
| def        | create variable                    |
| print      | print text or value in report      |
| header     | set header                         |
| request    | set request body                   |
| method     | set method and execute             |
| status     | validate response status           |
| match      | validate response schema or values |

Find more definitions [here](https://intuit.github.io/karate/)

#### - Tags
Can use tags to group and order testcases:

```Gherkin
@petstore_create_user_ok @petstore_user_01 
  Scenario: Create user successfully with random data
  Given ....
  When ....
  Then ....
....

@petstore_create_user_ok @petstore_user_01 
  Scenario: Create user successfully with defined data
  Given ....
  When ....
  Then ....
....

@petstore_create_user_error @petstore_user_03 
Scenario: Try to create user with invalid name
  Given ....
  When ....
  Then ....
....

```
After, for example, if you run @petstore_create_user_ok tag will run 2 scenarios. If you run @petstore_create_user_error will run 1 scenario. If you run @petstore_user_02 will run 1 scenario.

### Request folder:
Contains json request format   

```json
{
  "contentID": "",
  "typeID": 1,
  "language": "",
  "nextAiring": "",
  "feedID": 1
}

```

### Response folder:
To represent schema files, we have to define json files with something like that:
```json
{
    "idRequest": #number,
    "contentID": "#string",
    "statusID": #number,
    "statusDescription": "#string",
    "requestedDate": "#string",
    "statusDate": "#string"
}
```

### Environment folder:
Contains variables that only works in every environment.
A file must be created for each environment (config-dev.js, config-qa.js, config-preprod.js)

Example:
```js
config-qa.js

function environmentQA() {

	var ambiente = {
		url : 'https://petstore.swagger.io',
	};

	return ambiente;
}
```

Use:
```Gherkin
get_content_request.feature

...
...
  Given url ambiente.url
...
...

```



### TestRunner file

TestRunner file allow to configure the test executions:

Run all test:
```java
  @Karate.Test
  Karate testAll() {
    return Karate.run().relativeTo(getClass());
  }
```

Run specific test by tag:
```java
  @Karate.Test
  Karate testAll() {
    return Karate.run().tags("@SOME_TAG_HERE").relativeTo(getClass());
  }
```
**IMPORTANT: If you want to run by console, you have to write only one test runner configuration**

## Run test by Eclipse IDE
For running test by IDE have to be in testrunner class and **right click** -> **Run As** -> **JUnit Test**



## Run test by console
Configure testrunner with:

```java
  @Karate.Test
  Karate testAll() {
    return Karate.run().relativeTo(getClass());
  }
```
Open command promt, go to project folder and run this command:

To run with the sequential runner

```console
mvn clean verify -Dkarate.env=qa -Dkarate.options="--tags @pet_ejemplos" -Dtest=TestRunner
```
 
To run with the Parallel runner

```console
mvn clean verify -Dkarate.env=qa -Dkarate.options="--tags @pet_ejemplos" -Dtest=TestRunnerParallel
```

## Reports
Reports are in project folder **target\surefire-reports**