Feature: As a user I can see talks I might want to attend
  Background: The site requires a user before serving public content
    Given an admin exists

  Scenario: Conference organizer approves proposals
    Given a proposal exists
    And there are no conference sessions
    And I am a logged in organizer
    And I am on the default proposal review page
    When I press "Approve"
    Then I am on the default conference session page
    And I should see "Title"
    And I should see "Abstract"
    And I should see "Talk Type"
    And I should see "Talk Length"   
    And I should see "Name"
    
  Scenario: Site visitors see published keynote
    Given a keynote session exists
    When I am on the sessions page
    Then I should see "Keynote: Hank Moody"
    And I should see a link with "Unemployable" to "http://unemployable.com"
    And I should see a link with "@hankypanky" to "http://twitter.com/hankypanky"
    And I should see "God Hates Us All"
    And I should see "Single father, living a player lifestyle in California."


    
