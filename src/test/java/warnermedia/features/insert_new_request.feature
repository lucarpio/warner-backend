@warner_poc_post @run
Feature: Insert new request

    Background: Carga de variables
        * def req_insert_request = read('../request/insert_request.json')
        * def res_insert_request = read('../response/insert_request.json')
        * def utils_class = Java.type('utils.util')
        * def util = new utils_class()

    Scenario Outline: Insert new request - happy path
        * def body = { contentID: <contentID>, typeID: <typeID>, language: <language>, nextAiring: <nextAiring>, feedID: <feedID> }

        Given url ambiente.urlWM
        And path path_insert_request
        And request body
        When method post
        Then status 200
        And print response
        And match response == res_insert_request

        Examples:
            | contentID    | typeID | language | nextAiring                     | feedID |
            | 'B3AT3-A/01' | 2      | 'ESP'    | '2020-12-02T13:22:00.81+00:00' | 122    |