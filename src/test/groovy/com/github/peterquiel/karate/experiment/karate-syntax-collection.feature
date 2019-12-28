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

  Scenario: Karate Strings
    * def singleQuoteString = 'just a string'
    * def doubleQuoteString = "no difference between single and double quote"
    * string aStringStepDef = "don't know why there is an extra step definition for a string, .. just use def"
    * print jsExpInString

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
      | placement | name                          |
      | 1         | "Big Trouble in Little China" |
      | 2         | "The Karate Kid"              |
      | 3         | "Police Story"                |

    Then match bikes ==
    """
    [
      {placement: 1, name: "Big Trouble in Little China" }
      {placement: 2, name: "The Karate Kid"              }
      {placement: 3, name: "Police Story"                }
    ]
    """

  Scenario: Read CSV file and convert that to json
    Given json dataFromCsv = read('classpath:data.csv')
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


  Scenario: Contains any test case
      #  contains any expects json arrays or object on left and right side. Type of left and right side must be the same.
    * match  ['active', 'deleted'] contains any ['status', 'active']
    * match  {'foo':'bar'} contains any {'foo':'bar', 'mr':'pink'}


  Scenario: Type conversion
    * text foo =
    """
    name,type
    Billie,LOL
    Bob,Wild
    """
    * csv bar = foo
    * match bar == [{ name: 'Billie', type: 'LOL' }, { name: 'Bob', type: 'Wild' }]


  Scenario Outline: inline json
    * match __row == { first: 'hello', second: { a: 1 } }
    * match first == 'hello'
    * match second == { a: 1 }

    Examples: Just a view examples
      | first | second!  |
      | hello | { a: 1 } |

  Scenario: Matching text
    * def yourResponse = "12:10:33.960 [print] Kyc Status changed from NotStarted to Accepted.Reason: Output Address AddressLine : 6927 14TH AVE"
    * match yourResponse contains "NotStarted to Accepted"
    * match yourResponse !contains "does not contain"
    * assert new RegExp("NotStarted to Accepted").test(yourResponse)


  Scenario Outline: Reading examples from csv. Placeholders like <name> and <likes> will be replaced by example data.
    * print '<name>'
    * print '<likes>'
    Examples:
      | read('classpath:data.csv') |


#  Scenario: Documentary string..
#  This is is currently - 0.9.5.RC3 - a bug and doesn't terminate.
#    Given url "https://www.google.de"
#      """
#      This is text to document your scenario in detail.
#      """
#    When method get
#    Then status 200

  Scenario: Documentary string  whit karate embed
    Given url "https://www.google.de"
    * karate.embed('This is text to document your scenario in detail.', 'text/plain')
    When method get
    Then status 200

  # following scenarios reproduce test result listing bug
  Scenario: First 'scenario' with single quotes in title
    * print 1

  Scenario: Second 'scenario' with single quotes in title
    * print 1 + 1

  Scenario: First scenario without quotes in title
    * print 1 + 1 + 1


    Scenario: how-to-validate-multiple-possible-values-in-karate-using-a-schema
    * def schema =
"""
{
    "itemType":{
        "hardware":[
            "VIDEO CARD",
            "SOLID STATE DRIVE",
            "HARD DRIVE"
        ]
    }
}
"""
    * def response =
"""
{
    "itemType": {
        "hardware": "HARD DRIVE"
    }
}
"""
      * match schema.itemType.hardware contains response.itemType.hardware
#
#    * match response == { itemType: { hardware: '#? schema.itemType.hardware.contains(_)' } }
#    * def isValidHardware = function(x){ return schema.itemType.hardware.contains(x) }
#    * match response == { itemType: { hardware: '#? isValidHardware(_)' } }