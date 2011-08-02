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
    Given I am logged in as an attendee
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
    And I change the Blog URL field to "http://marioaquino.blogspot.com"
    When I press "Update Profile"
    Then I should be on the profile page for Mario Crimefighter Aquino
    And I should see "Mario Crimefighter Aquino"
    And I should see "St. Louis"
    And I should see a link with "Foo, Inc." to "http://mycompany.com"
    And I should see a link with "@marioaquino" to "https://twitter.com/marioaquino"
    And I should see a link with "marioaquino" to "https://github.com/marioaquino"
    And I should see a link with "http://marioaquino.blogspot.com" to "http://marioaquino.blogspot.com"

  @javascript
  Scenario: Authenticated attendee updates profile
    Given a homepage exists
    And I am logged in as an attendee
    And I am on the homepage
    And I follow "Kaiser Von Sozhay"
    And I follow "Update My Profile"
    And I change the First Name field to "Mario"
    And I change the Middle Name field to "Crimefighter"
    And I change the Last Name field to "Aquino"
    When I press "Update Profile"
    Then I should be on the profile page for Mario Crimefighter Aquino
    And I should see "Mario Crimefighter Aquino"

  Scenario: Login page for unauthenticated site visitor
    Given I am on the homepage
    When I follow "Login"
    Then I should see "Login with GMail"
    And I should see "Login with LinkedIn"
    And I should see "Login with Twitter"
    And I should see "Login with Yahoo!"

  Scenario: Authenticated attendees can see paginated list of current year attendees
    Given I am logged in as an attendee
    When I am on the attendees page
    Then I should see a link with "Kaiser Von Sozhay" to "/attendees/kaiser-von-sozhay"
    And I should see a link with "Happy Town" to "http://happytown.com"
    And I should see a link with "@kaiser" to "https://twitter.com/kaiser"

  @javascript
  Scenario: Authenticated attendees can select a talk they are interested in
    Given I am logged in as an attendee
    And a talk exists
    And I am on the detail page for that talk
    When I click "Interested"
    Then I should see "Will attend"
    And I should not see "Interested"
    And I should see "Changed my mind"

  @javascript
  Scenario: Authenticated attendees can deselect a talk they don't plan to attend
    Given I am logged in as an attendee
    And a talk exists
    And I am interested in that talk
    And I am on the detail page for that talk
    When I click "Changed my mind"
    Then I should see "Interested"
    And I should not see "Changed my mind"
    And I should not see "Will attend"

  Scenario: Authenticated attendees are urged to select which talks they want to attend on their profile page
    Given I am logged in as an attendee
    When I am my profile page
    Then I should see "You have not indicated your interest in attending any talks"
    And I should see "Please visit the sessions page" as a link to the Sessions page

  Scenario: Authenticated attendee sees a list of talks they are interested in attending
    Given I am logged in as an attendee
    And a talk exists
    And I am interested in that talk
    When I am on my profile page
    Then I should see "My Schedule"
    And I should see "A cool talk"
    And I should see "Monday"
    And I should see "09:30 AM - 10:20 AM"

  Scenario: Site admin sees the count of attendees interested in a conference session
    Given a talk session with an interested attendee exists
    And I am a logged in admin
    When I am on the conference sessions admin index page
    Then I should see "1 interested attendee"
