Feature: As an authenticated conference attendee, I can fill out and edit a profile of myself,
  my interests, and the sessions I expect to attend so that I can connect with other attendees
  whose interests match my own.

  Email, twitter id, facebook id?, github id, cell #(?), auto-suggest fields for hobbies,
  languages of interest/expertise, home town (for linking w fellow travelers).
  Also see a list of sessions that you have indicated you want to attend...
  Link to an ical-compatable file with schedule data for the sessions you want to attend

  Background: The site requires a user before serving public content
    Given an admin exists

  Scenario: Authenticated attendee creates a profile
    Given I am logged in as a registered attendee
    And I am on the edit profile page
    And I change the First Name field to "Mario"
    And I change the Middle Name field to "Crimefighter"
    And I change the Last Name field to "Aquino"
    And I change the Home Town field to "St. Louis"
    And I change the Home Country select to "United States"
    And I change the Email field to "mario@foo.com"
    And I change the Company Name field to "Foo, Inc."
    And I change the Company URL field to "http://mycompany.com"
    And I change the Twitter ID field to "marioaquino"
    And I change the GitHub ID field to "marioaquino"
    And I change the WorkForPie ID field to "MarioAquino"
    And I change the Blog URL field to "http://marioaquino.blogspot.com"
    When I press "Update Profile"
    Then I should be on the profile page for Mario Crimefighter Aquino
    And I should see "Mario Crimefighter Aquino"
    And I should see "St. Louis"
    And I should see a link with "Foo, Inc." to "http://mycompany.com"
    And I should see a link with "@marioaquino" to "https://twitter.com/marioaquino"
    And I should see a link with "marioaquino" to "https://github.com/marioaquino"
    And I should see a link with "MarioAquino" to "http://workforpie.com/MarioAquino"
    And I should see a link with "http://marioaquino.blogspot.com" to "http://marioaquino.blogspot.com"

  Scenario: Login page for unauthenticated site visitor
    Given I am on the homepage
    When I follow "Login"
    Then I should see "Login with GMail"
    And I should see "Login with LinkedIn"
    And I should see "Login with Twitter"
    And I should see "Login with Yahoo!"

  Scenario: Authenticated attendees can see paginated list of current year attendees
    Given I am logged in as a registered attendee
    When I am on the attendees page
    Then I should see a link with "Kaiser Von Sozhay" to "/attendees/kaiser-von-sozhay"
    And I should see a link with "Happy Town" to "http://happytown.com"
    And I should see a link with "@kaiser" to "https://twitter.com/kaiser"

  Scenario: Non-authenticated visitors don't see talk selection buttons
    Given a scheduled talk session for this year exists
    When I am on the schedule page
    Then I should not see the add or remove icons

  Scenario: Authenticated attendees are urged to select which talks they want to attend on their profile page
    Given I am logged in as a registered attendee
    When I am on my profile page
    Then I should see "You have not indicated your interest in attending any talks"
    And I should see "visit the schedule page" as a link to the schedule page

  Scenario: Authenticated attendee sees a list of talks they are interested in attending
    Given I am logged in as a registered attendee
    And a scheduled talk session for this year exists
    And I am interested in that talk
    When I am on my profile page
    Then I should see "My Conference Schedule"
    And I should see "Sample Talk"
    And I should see "Tuesday"
    And I should see "12:30 PM - 01:30 PM"

  Scenario: Authenticated attendee can download an iCal schedule for the talks they are interested in attending
    Given I am logged in as a registered attendee
    And a scheduled talk session for this year exists
    And I am interested in that talk
    When I am on my profile page
    Then I should see "Download my Schedule" as a link to the iCal download

  @javascript
  Scenario: Login link only shown to unauthenticated visitors
    Given a homepage exists
    When I am on the homepage
    Then I should see "Login" as a link to the login page
    And I should not see "Log Out"

  @javascript
  Scenario: Logout link only shown to authenticated visitors
    Given a homepage exists
    And I am logged in as a registered attendee
    When I am on the homepage
    Then I should see "Log Out" as a link to the logout page
    And I should not see "Login"

  @javascript
  Scenario: Authenticated attendee updates profile
    Given a homepage exists
    And I am logged in as a registered attendee
    And I am on the homepage
    And I follow "Kaiser Von Sozhay"
    And I follow "Update My Profile"
    And I change the First Name field to "Mario"
    And I change the Middle Name field to "Crimefighter"
    And I change the Last Name field to "Aquino"
    When I press "Update Profile"
    Then I should be on the profile page for Mario Crimefighter Aquino
    And I should see "Mario Crimefighter Aquino"

  @javascript
  Scenario: Authenticated attendees can select a talk they are interested in
    Given I am logged in as a registered attendee
    And a scheduled talk session for this year exists
    And I am on the schedule page
    When I click the add icon
    Then I should see the remove icon
    And I should not see the add icon

  @javascript
  Scenario: Authenticated attendees can deselect a talk they don't plan to attend
    Given I am logged in as a registered attendee
    And a scheduled talk session for this year exists
    And I am interested in that talk
    And I am on the schedule page
    When I click the remove icon
    Then I should see the add icon
    And I should not see the remove icon

