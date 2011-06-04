Feature: As a site administrator, I can track conference sponsors and display their details
  on the site so that attendees can connect with them when needed.

  Scenario: Admin adds a new sponsorship level
    Given I am a logged in admin
    And I am on the sponsorship admin page
    When I follow "Manage Sponsorship Levels"
    And I follow "Add New Sponsorship Level"
    And I change the Name field to "Platinum"
    And I change the Year field to "2011"
    And I change the Position field to "1"
    And I push the Save button
    Then I should see "'Platinum' was successfully added"

  Scenario: Admin adds a new sponsorship
    Given I am a logged in admin
    And a sponsorship level exists
    And I am on the sponsorship admin page
    When I follow "Add New Sponsorship"
    And I change the Sponsor Name field to "Mario.com"
    And I change the Description field to "They give us money"
    And I change the URL field to "http://foo.com"
    And I change the Contact Name field to "Mario"
    And I change the Contact Phone field to "314-555-1212"
    And I change the Contact Email field to "mario@foo.com"
    And I select "Platinum" from "Sponsorship Level"
    And I change the Year field to "2011"
    And I push the Save button
    Then I should see "'Mario.com' was successfully added"

