Feature: Use property based testing for content test

  Background:
    # Using this url for all scenarios until it's changed.
    * url 'https://jsonplaceholder.typicode.com/'

  Scenario: Posting a new post and validate the response schema
    Given path 'posts'
    * print 'Using post body: ', postBody
    * def newPost =
        """
        {
          title : 'A new karate post',
          body : '#(postBody)',
          userId : 1
        }
"""
    * request newPost
    When method post
    Then status 201
    * set newPost $.id = '#number? _ > 0'
    * match response == newPost