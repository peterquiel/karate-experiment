

Feature: Calling a cleanup feature after every scenario

  Background:
    * configure afterScenario =
        """
      function() {
        karate.call("../experiment/clean-up.feature", {name : "mr. pink"});
      }
      """

  Scenario: First scenario with an after scenario clean up call
    * print "first scenario..."

  Scenario: Second scenario with an after scenario clean up call
    * print "second scenario..."
