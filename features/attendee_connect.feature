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
    Given I am a logged in attendee
    And I am on the edit profile page
    And I change the First Name field to "Mario"
    And I change the Middle Name field to "Crimefighter"
    And I change the Last Name field to "Aquino"
    And I change the Home Town field to "St. Louis"
    And I change the Email field to "mario@foo.com"
    And I change the Company Name field to "Foo, Inc."
    And I change the Company URL field to "http://mycompany.com"
    And I change the Twitter ID field to "marioaquino"
    And I change the Github ID field to "marioaquino"
    And I change the Blog URL field to "http://marioaquino.blogspot.com"
    When I press the Update Profile button
    Then I should be on the profile page for Mario Crimefighter Aquino
    And I should see "Mario Crimefighter Aquino"
    And I should see "St. Louis"
    And I should see "Foo, Inc." as a link to "http://mycompany.com"
    And I should see "@marioaquino" as a link to "http://twitter.com/marioaquino"
    And I should see "marioaquino" as a link to "http://github.com/marioaquino"
    And I should see "http://marioaquino.blogspot.com" as a link to "http://marioaquino.blogspot.com"

  Scenario: Authenticated attendee updates profile
    Given I am a logged in attendee
    And I am on the homepage
    And I follow "Attendee 1"
    And I follow "Update My Profile"
    And I change the First Name field to "Mario"
    And I change the Middle Name field to "Crimefighter"
    And I change the Last Name field to "Aquino"
    When I press the Update Profile button
    Then I should be on the profile page for Mario Crimefighter Aquino
    And I should see "Mario Crimefighter Aquino"

  Scenario: Login page for unauthenticated site visitor
    Given I am on the homepage
    When I follow "Login"
    Then I should see "Login with GMail"
    And I should see "Login with LinkedIn"
    And I should see "Login with Twitter"
    And I should see "Login with Yahoo!"
