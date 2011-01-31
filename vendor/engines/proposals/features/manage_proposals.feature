@proposals
Feature: Proposals
  In order to have proposals on my website
  As an administrator
  I want to manage proposals

  Background:
    Given I am a logged in refinery user
    And I have no proposals

  @proposals-list @list
  Scenario: Proposals List
   Given I have proposals titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of proposals
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @proposals-valid @valid
  Scenario: Create Valid Proposal
    When I go to the list of proposals
    And I follow "Add New Proposal"
    And I fill in "Status" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 proposal

  @proposals-invalid @invalid
  Scenario: Create Invalid Proposal (without status)
    When I go to the list of proposals
    And I follow "Add New Proposal"
    And I press "Save"
    Then I should see "Status can't be blank"
    And I should have 0 proposals

  @proposals-edit @edit
  Scenario: Edit Existing Proposal
    Given I have proposals titled "A status"
    When I go to the list of proposals
    And I follow "Edit this proposal" within ".actions"
    Then I fill in "Status" with "A different status"
    And I press "Save"
    Then I should see "'A different status' was successfully updated."
    And I should be on the list of proposals
    And I should not see "A status"

  @proposals-duplicate @duplicate
  Scenario: Create Duplicate Proposal
    Given I only have proposals titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of proposals
    And I follow "Add New Proposal"
    And I fill in "Status" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 proposals

  @proposals-delete @delete
  Scenario: Delete Proposal
    Given I only have proposals titled UniqueTitleOne
    When I go to the list of proposals
    And I follow "Remove this proposal forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 proposals
 