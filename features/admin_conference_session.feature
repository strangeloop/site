Feature: As a conference organizer, I should be able to manage and search
  through conference sessions for the current and previous years so that
  I can maintain the publically viewable content for the site.

  Background: The site requires a user before serving public content
    Given an admin exists
    And I am a logged in admin

  Scenario: Admin can edit conference session details
    Given a talk session exists
    And I am on the default conference session page
    And I change the Title field to "New title"
    And I change the Abstract field to "New abstract"
    And I change the Talk Duration field to "20 Minutes"
    When I push the Save button
    Then I should be on the dashboard page
    Then I visit the default conference session page
    And I should see the Title field with "New title"
    And I should see the Abstract field with "New abstract"

  Scenario: Admin can create new conference session for previous year's talk
    Given I am on the conference sessions admin index page
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
    Then I follow "Manage Conference Sessions from 2010"
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
    Given I am on the conference sessions admin index page
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
    Then I follow "Manage Conference Sessions from 2010"
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
    Given I am on the conference sessions admin index page
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
    Then I follow "Manage Conference Sessions from 2010"
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

  @72
  Scenario: Conference Session admin shows current year's sessions by default
    Given there are conference sessions for the current and previous years
    When I am on the conference sessions admin index page
    Then I should see the current the current year's session
    And I should see a link to view sessions from the previous year


