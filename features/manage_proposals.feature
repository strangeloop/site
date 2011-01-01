Feature: Manage proposals
  In order to speak at the conference
  as a potential speaker
  I want to be able to submit or rescind a talk proposal for the conference
  
  Scenario: Register new proposal
    Given an admin exists
    And I am on the new proposal page
    When I fill in "Title" with "title 1"
    And I fill in "Speaker name" with "speaker_name 1"
    And I fill in "Speaker email" with "speaker_email 1"
    And I fill in "Description" with "description 1"
    And I press "Submit proposal"
    Then I should see "title 1"
    And I should see "speaker_name 1"
    And I should see "speaker_email 1"
    And I should see "description 1"

