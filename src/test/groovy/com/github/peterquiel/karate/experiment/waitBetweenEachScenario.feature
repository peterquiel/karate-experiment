Feature: A test to show how to wait between each scenario

  Background: Configure the wait function
    * configure afterScenario =
        """
      function() {
        // load java type into js engine
        var Thread = Java.type('java.lang.Thread');
        Thread.sleep(5000); // sleep for 5 Seconds
      }
      """

  Scenario: First Scenario
    * print 1

  Scenario: Second Scenario
    * print 2

