Feature: As a conference talks reviewer
  I need to see talks ready to be reviewed
  So that I can curate the talks for an upcoming conference

  Scenario: Reviewer visits Proposals tab before any talk submitted
    Given I am a logged in reviewer
    And there are no submitted talks
    When I follow "Proposals"
    Then I should see "There are no talks ready for review"

  Scenario: Reviewer visits Proposals when one talk has been submitted
    Given the following talks have been submitted:
      | title     | by       | track  | status    |
      | Free Beer | Bud Hops | JVM | submitted |
    And I am a logged in reviewer
    When I follow "Proposals (1)"
    Then I should see "Proposed Talks"
    And I should see "Free Beer"
    And I should see "Bud Hops"
    And I should see "JVM"
    And I should see "submitted"
    
