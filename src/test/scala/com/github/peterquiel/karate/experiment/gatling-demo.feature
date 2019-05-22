Feature: Gatling Demo Setup

  Scenario: Reading configuration from json or yaml file from gatling
    * print 'Yaml config read form karate-config.js:'
    * print yamlConfig
    * json configFromJsonFile = karate.read("classpath:config.json")
    * print 'Config from Json File:'
    * print configFromJsonFile
    * json configFromYamlFile = karate.read("classpath:config.yml")
    * print 'Config from Yaml File:'
    * print configFromYamlFile

#    Do some web requests to keep gatling happy
  Scenario: Get posts from json placeholder
    * url 'https://jsonplaceholder.typicode.com/'
    Given path 'posts'
    When method get
    Then status 200
    * match response == '#[100]'
