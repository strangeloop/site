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
    And I should see "Talk type"
    
  Scenario: Site visitors see published keynote
    Given a keynote session exists
    When I am on the sessions page
    Then I should not see "Workshops"
    And I should not see "Talks"
    And I should see "Hank Moody"
    And I should see a link with "Unemployable" to "http://unemployable.com"
    And I should see a link with "@hankypanky" to "http://twitter.com/hankypanky"
    And I should see "God Hates Us All"
    And I should see "Single father, living a player lifestyle in California."

  Scenario: Site visitors see published workshops
    Given a workshop session exists
    When I am on the sessions page
    Then I should see "Workshops"
    And I should not see "Keynotes"
    And I should not see "Talks"
    And I should see "Winning with Tiger Blood"
    And I should see a link with "Charlie Sheen" to "http://winning.com"
    And I should see a link with "@adonisdna" to "http://twitter.com/adonisdna"

  Scenario: Site visitors see published talks
    Given a talk session exists
    When I am on the sessions page
    Then I should not see "Keynotes"
    Then I should not see "Workshops"
    And I should see "Talks"
    And I should see "Sample Talk"
    And I should see a link with "Earl Grey" to "http://teabaggery.com"
    And I should see a link with "@earlofgrey" to "http://twitter.com/earlofgrey"

  Scenario: Site visitor views a session detail
    Given a keynote session exists
    And I am on the sessions page
    When I follow "God Hates Us All"
    Then I should be on the session details page for God Hates Us All
    Then I should see "Hank Moody"
    And I should see a link with "Unemployable" to "http://unemployable.com"
    And I should see a link with "@hankypanky" to "http://twitter.com/hankypanky"
    And I should see "God Hates Us All"
    And I should see "A writer tries to juggle his career, his relationship with his daughter and his ex-girlfriend, as well as his appetite for beautiful women."
    And I should see "Single father, living a player lifestyle in California."
    

    
