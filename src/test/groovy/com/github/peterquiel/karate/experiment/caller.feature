Feature: Calls another feature

  Scenario: caller
    * def called = call read('be-called.feature') {jsParameter : " foo bar\n"}
    * print called.test