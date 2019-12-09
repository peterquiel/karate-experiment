Feature: Example of how to call a feature from java

  @withParameter
  Scenario: Doing simple karate
    * def simpleJson = {foo:'bar'}
    #    Referencing a passed in parameter is really simple
    * def hello = 'Hello ' + parameter
