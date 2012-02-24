Feature: As a user I can see talks I might want to attend
  Background: The site requires a user before serving public content
    Given an admin exists

  Scenario: Conference organizer approves proposals
    Given a proposal exists
    And a session time from this year exists
    And there are no conference sessions
    And I am a logged in organizer
    And I am on the default proposal review page
    And I choose "Approve Talk"
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
    And I should see "Single father, living a player lifestyle in California."

  Scenario: Admin can edit conference session details
    Given a talk session exists
    And I am a logged in admin
    And I am on the default conference session page
    And I change the Title field to "New title"
    And I change the Abstract field to "New abstract"
    When I push the Save button
    Then I should be on the dashboard page
    Then I visit the default conference session page
    And I should see the Title field with "New title"
    And I should see the Abstract field with "New abstract"

  Scenario: Admin can create new conference session for previous year's talk
    Given I am a logged in admin
    And I am on the conference sessions admin index page
    And I follow "Add New Conference Session"
    And I change the Format select to "talk"
    And I change the Title field to "Old talk title"
    And I change the Abstract field to "Old talk abstract"
    And I change the Conf year field to "2010"
    And I change the First name field to "Stephen"
    And I change the Last name field to "Hawking"
    And I change the Email field to "steve@science.edu"
    And I change the Bio field to "I write books about the universe and stuff"
    When I push the Save button
    Then I should be on the conference sessions admin index page
    Then I follow "Edit this conference session"
    And I should see the Title field with "Old talk title"
    And I should see the Abstract field with "Old talk abstract"
    And I should see the Conf year field with "2010"
    And I should see the First name field with "Stephen"
    And I should see the Last name field with "Hawking"
    And I should see the Email field with "steve@science.edu"
    And I should see the Bio field with "I write books about the universe and stuff"
    Then I visit the session details page for Old talk title
    And I should see "Stephen Hawking"
    And I should see the medium default speaker image
    And I should see "Old talk title"
    And I should see "Old talk abstract"
    And I should see "I write books about the universe and stuff"

  Scenario: Admin can create new conference session for previous year's panel talk
    Given I am a logged in admin
    And I am on the conference sessions admin index page
    And I follow "Add New Conference Session"
    And I change the Format select to "panel"
    And I change the Title field to "Old talk title"
    And I change the Abstract field to "Old talk abstract"
    And I change the Conf year field to "2010"
    And I change the First name field to "Stephen"
    And I change the Last name field to "Hawking"
    And I change the Email field to "steve@science.edu"
    And I change the Bio field to "I write books about the universe and stuff"
    When I push the Save button
    Then I should be on the conference sessions admin index page
    Then I follow "Edit this conference session"
    And I should see the Title field with "Old talk title"
    And I should see the Abstract field with "Old talk abstract"
    And I should see the Conf year field with "2010"
    And I should see the First name field with "Stephen"
    And I should see the Last name field with "Hawking"
    And I should see the Email field with "steve@science.edu"
    And I should see the Bio field with "I write books about the universe and stuff"
    And I should see the Format field with "panel"
    Then I visit the session details page for Old talk title
    And I should see "Stephen Hawking"
    And I should see the medium default speaker image
    And I should see "Old talk title"
    And I should see "Old talk abstract"
    And I should see "I write books about the universe and stuff"

  Scenario: Admin can create new conference session for previous year's strange passions talk
    Given I am a logged in admin
    And I am on the conference sessions admin index page
    And I follow "Add New Conference Session"
    And I change the Format select to "strange passions"
    And I change the Title field to "Old talk title"
    And I change the Abstract field to "Old talk abstract"
    And I change the Conf year field to "2010"
    And I change the First name field to "Stephen"
    And I change the Last name field to "Hawking"
    And I change the Email field to "steve@science.edu"
    And I change the Bio field to "I write books about the universe and stuff"
    When I push the Save button
    Then I should be on the conference sessions admin index page
    Then I follow "Edit this conference session"
    And I should see the Title field with "Old talk title"
    And I should see the Abstract field with "Old talk abstract"
    And I should see the Conf year field with "2010"
    And I should see the First name field with "Stephen"
    And I should see the Last name field with "Hawking"
    And I should see the Email field with "steve@science.edu"
    And I should see the Bio field with "I write books about the universe and stuff"
    And I should see the Format field with "strange passions"
    Then I visit the session details page for Old talk title
    And I should see "Stephen Hawking"
    And I should see the medium default speaker image
    And I should see "Old talk title"
    And I should see "Old talk abstract"
    And I should see "I write books about the universe and stuff"

  Scenario: Check back message when no sessions scheduled
    Given there are no conference sessions
    When I am on the sessions page
    Then I should see the come back later message


