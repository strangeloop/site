@conference_sessions
Feature: Conference Sessions
  In order to have conference_sessions on my website
  As an administrator
  I want to manage conference_sessions

  Background:
    Given I am a logged in refinery user
    And I have no conference_sessions

  @conference_sessions-list @list
  Scenario: Conference Sessions List
   Given I have conference_sessions titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of conference_sessions
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @conference_sessions-valid @valid
  Scenario: Create Valid Conference Session
    When I go to the list of conference_sessions
    And I follow "Add New Conference Session"
    And I fill in "Title" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 conference_session

  @conference_sessions-invalid @invalid
  Scenario: Create Invalid Conference Session (without title)
    When I go to the list of conference_sessions
    And I follow "Add New Conference Session"
    And I press "Save"
    Then I should see "Title can't be blank"
    And I should have 0 conference_sessions

  @conference_sessions-edit @edit
  Scenario: Edit Existing Conference Session
    Given I have conference_sessions titled "A title"
    When I go to the list of conference_sessions
    And I follow "Edit this conference_session" within ".actions"
    Then I fill in "Title" with "A different title"
    And I press "Save"
    Then I should see "'A different title' was successfully updated."
    And I should be on the list of conference_sessions
    And I should not see "A title"

  @conference_sessions-duplicate @duplicate
  Scenario: Create Duplicate Conference Session
    Given I only have conference_sessions titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of conference_sessions
    And I follow "Add New Conference Session"
    And I fill in "Title" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 conference_sessions

  @conference_sessions-delete @delete
  Scenario: Delete Conference Session
    Given I only have conference_sessions titled UniqueTitleOne
    When I go to the list of conference_sessions
    And I follow "Remove this conference session forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 conference_sessions
 