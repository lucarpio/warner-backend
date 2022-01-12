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