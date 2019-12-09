Feature: Meant to be called by java test case

  Background:
    * url 'https://jsonplaceholder.typicode.com/'

  Scenario: Get posts from json placeholder
#    appending path to the already configured url is pretty easy
    Given path 'posts', '1'
    When method get
  #    Simple status asserts, but `assert that status is 200` would be more expressive
    Then status 200

  # custom assert statement, will be rewritten by execution hook - see ExecutionHookExampleTest.groovy
    * assert that response.id == 1
