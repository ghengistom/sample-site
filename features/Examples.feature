Feature: Show various examples
  In order to learn how to use the product
  As a user
  I want to view Examples
  
  Scenario Outline: View examples
    Given I have examples titled "Only 2009", "Only 2010", "Only 2011"
    When I go to the list of examples
    Then I should see "Only 2009"
    And I should see "Only 2010"
    And I should see "Only 2011"