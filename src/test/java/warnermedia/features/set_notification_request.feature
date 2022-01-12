@warner_poc_put @run
Feature: Set notification request

    Background: Carga de variables
        * def req_set_notification = read('../request/set_notification.json')
        * def res_set_notification = read('../response/set_notification.json')
        * def utils_class = Java.type('utils.util')
        * def util = new utils_class()

    Scenario Outline: Set notification request - happy path
        * set req_set_notification.contentID = <contentID>
        * set req_set_notification.feedID = <feedID>
        * set req_set_notification.typeID = <typeID>
        * set req_set_notification.language = <language>
        * set req_set_notification.statusID = <statusID>
        * set req_set_notification.statusMessage = <statusMessage>

        Given url ambiente.urlWM
        And path path_notification
        And header Content-Type = 'application/json'
        And request req_set_notification
        When method put
        Then status 200
        And print response
        And match response == res_set_notification

        Examples:
            | contentID    | feedID | typeID | language | statusID | statusMessage   |
            | 'B3AT3-A/01' | 122    | 2      | 'ESP'    | 600500   | 'QC file error' |