Feature: Call functions after every scenario

  Background:
    * def fn = read('classpath:after-scenario-with-params.js')
    * configure afterScenario =
    """
      function() {
        fn(karate.info, 'hello world');
      }
    """

  Scenario: Just a simple hello world scenario
    * print "simple scenario..."
#    * def fn = read('classpath:after-scenario-with-params.js')
#    * def test = call fn "test"