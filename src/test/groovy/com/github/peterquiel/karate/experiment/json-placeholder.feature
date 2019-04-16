Feature: Experimenting with karates web api testing capabilities.

  Background:
    # Using this url for all scenarios until it's changed.
    * url 'https://jsonplaceholder.typicode.com/'

  Scenario: Get posts from json placeholder
#    appending path to the already configured url is pretty easy
    Given path 'posts'
    When method get
  #    Simple status asserts, but `assert that status is 200` would be more expressive
    Then status 200
#    Use karate schema validation to check if response is an array of 100 elements
    * match response == '#[100]'

  Scenario: Posting a new post and validate the response schema
    Given path 'posts'
    * def newPost =
        """
        {
          title : 'A new karate post',
          body : 'Karate is an awesome web api testing dsl',
          userId : 1
        }
"""
    * request newPost
    When method post
    Then status 201
#    add an 'id' field that is schema validated - see https://github.com/intuit/karate#schema-validation
    * set newPost $.id = '#number? _ > 0'
    * match response == newPost



