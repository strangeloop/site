Feature: As a user I can see talks I might want to attend
  Background: The site requires a user before serving public content
    Given an admin exists

  Scenario: Conference organizer approves proposals
    Given a proposal exists
    And a session time from this year exists
    And there are no conference sessions
    And I am a logged in organizer
    And I am on the default proposal review page
    And I choose "Approve talk"
    When I press "Decide"
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
    And I should see the medium default speaker image
    And I should see a link with "Unemployable" to "http://unemployable.com"
    And I should see a link with "@hankypanky" to "https://twitter.com/hankypanky"
    And I should see "God Hates Us All"
    And I should see "Single father, living a player lifestyle in California."

  Scenario: Site visitors see published workshops
    Given a workshop session exists
    When I am on the workshops page
    Then I should see "Workshops"
    And I should not see "Keynotes"
    And I should not see "Talks"
    And I should see "Winning with Tiger Blood"
    And I should see the small default speaker image
    And I should see a link with "Charlie Sheen" to "http://winning.com"
    And I should see a link with "@adonisdna" to "https://twitter.com/adonisdna"

  Scenario: Site visitors see published talks
    Given a talk session exists
    When I am on the sessions page
    Then I should not see "Keynotes"
    Then I should not see "Workshops"
    And I should see "Talks"
    And I should see "Sample Talk"
    And I should see the small default speaker image
    And I should see a link with "Earl Grey" to "http://teabaggery.com"
    And I should see a link with "@earlofgrey" to "https://twitter.com/earlofgrey"

  @99
  Scenario: Site visitor views a session detail
    Given a keynote session exists
    And I am on the sessions page
    When I follow "God Hates Us All"
    Then I should be on the session details page for God Hates Us All
    Then I should see "Hank Moody"
    And I should see the medium default speaker image
    And I should see a link with "Unemployable" to "http://unemployable.com"
    And I should see a link with "@hankypanky" to "https://twitter.com/hankypanky"
    And I should see "God Hates Us All"
    And I should see "A writer tries to juggle his career, his relationship with his daughter and his ex-girlfriend, as well as his appetite for beautiful women."
    And I should see "Before watching this talk, shower, people!"
    And I should see "Zip, Zap, Zoop"
    And I should see "Single father, living a player lifestyle in California."

  Scenario: Check back message when no sessions scheduled
    Given there are no conference sessions
    When I am on the sessions page
    Then I should see the come back later message

  Scenario: No check-back message when sessions scheduled
    Given a keynote session exists
    When I am on the sessions page
    Then I should not see the come back later message

  Scenario: No check-back message when workshops scheduled
    Given a workshop session exists
    When I am on the workshops page
    Then I should not see the come back later message


