Feature: Testing the karate syntax features and use this as a small executable reference

  Background:
  # this section is optional !
  # steps here are executed before each Scenario in this file
  # variables defined here will be 'global' to all scenarios
  # and will be re-initialized before every scenario

  Scenario: Simple karate expressions
    Given def color = 'red '

    And def num = 5
    * print 'Num is ', num, '\n'
    * print 'Print takes js expressions as well: ', color + num
    * print 'Error logging could be improved; rubbish in expression leads to empty string:', doesNoExists + 10
    * print 'Default value from karate-config.js: ', someDefaultConfig

    Then assert color + num == 'red 5'

  Scenario: "Given, When and Then is obsolete"
    * print 'The given, when, then blocks are ignored in the end'
    * print 'You can leave them out'
    * print 'Or use them to structure your test'
    * print 'Malicious gossip claims that Gherkin is used by karate just for the hype'
    * print 'But I like the way this dsl is build Gherkin offers at least some IDE functions like execute in place'

  Scenario: Starting to play around with native json support
    Given
    * def somethingToEmbed = { "Doctor" : "Who" }
    #  Embedding syntax is a little awkward but works well and is really useful.
    # So the rule is - if a string value within a JSON (or XML) object declaration is enclosed between #( and ) - it will be https://open.spotify.com/artist/0MvSBMGRQJY3mRwIbJsqF1evaluated as a JavaScript expression.
    * def myFirstJson = { foo : "no bar", mr : "pink", fibo : [1,1,2,3,5,8], series: '#(somethingToEmbed)' }
    * def thirdFibo = myFirstJson.fibo[2]

      # Use set to manipulate json/xml structures
    And set myFirstJson.foo = 'bar'
      # adding a new value to a json structure
      # The $ is used as a reference to the root json element.
    * set myFirstJson $.newValue = { 'with-minus' : 'minus needs quotes'}
      # omit the array index to append
    * set myFirstJson.fibo[] = 13

    And print "nicely printed json: \n", karate.pretty(myFirstJson)

    Then assert myFirstJson.foo == "bar"
    And  assert thirdFibo == 2
    # When asserting for expected values in JSON or XML, always prefer using match instead of assert.
    And match myFirstJson.fibo == [1,1,2,3,5,8,13]

  Scenario: Needles to say, karates native xml support is awesome as well
    Given def embedIntoXml = <name>Stevens</name>
#    multi line expressions can be done
    * def myFirstXml =
    """
    <bikes>
      <name>Cucuma</name>
      <name>Canyon</name>
      #(embedIntoXml)
    </bikes>
    """

    And print "nicely print xml: \n", karate.pretty(myFirstXml)

    Then match myFirstXml.bikes.name[0] == "Cucuma"
#   Karate offers nice XPath support, but well, XML is not my topic so much.

  Scenario: Tables offer an elegant way to create json arrays
    Given table bikes
      | name      | likes |
      | 'Cucuma'  | 1     |
      | 'Canyon'  | 2     |
      | 'Stevens' | 3     |

    Then match bikes ==
    """
    [
      {name : "Cucuma", likes : 1}
      {name : "Canyon", likes : 2}
      {name : "Stevens", likes : 3}
    ]
    """

  Scenario: Yaml is supported as well
    Given yaml myFirstYaml =
  """
    name: John
    input:
      id: 1
      subType:
        name: Smith
        deleted: false
  """

  Scenario: Read CSV file and convert that to json
    Given json dataFromCsv = read('data.csv')
    Then match dataFromCsv ==
    """
    [
      {name : "Cucuma", likes : '1'}
      {name : "Canyon", likes : '2'}
      {name : "Stevens", likes : '3'}
    ]
    """

  Scenario: Read environment configuration
#      The configuration returned by the karate-config.js function are directly available as global properties.
    * print "Environment configuration for someUrlBase:", someUrlBase

    Scenario: Reading configuration from json or yaml file
      * json configFromJsonFile = karate.read("classpath:config.json")
      * print configFromJsonFile
      * json configFromYamlFile = karate.read("classpath:config.yml")
      * print configFromYamlFile


  Scenario: Setting and reading karate properties
    * def fun =
   """
    function () {
        var client = karate.get('client') || "loyalty";
        karate.log("the client set as: ", client);
    }
   """
    * eval karate.set('client', 'delivery')
    * call fun
