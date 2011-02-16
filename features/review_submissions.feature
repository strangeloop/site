Feature: As a conference talks reviewer
  I need to see talks ready to be reviewed
  So that I can curate the talks for an upcoming conference

  Scenario: Reviewer visits Proposals tab before any talk submitted
    Given I am a logged in reviewer
    And there are no submitted talks
    When I follow "Proposals"
    Then I should see "There are no talks ready for review"

  Scenario: Reviewer views list of submitted Proposals
    Given the following talks have been submitted:
       | title     | by       | track | status    | 
       | Free Beer | Bud Hops | JVM   | submitted | 
    And I am a logged in reviewer
    When I follow "Proposals (1)"
    Then I should see "Proposed Talks"
    And I should see "Free Beer"
    And I should see "Bud Hops"
    And I should see "JVM"
    And I should see "submitted"
    
  Scenario: Reviewer views submitted proposal
    Given the following talks have been submitted:
      | title     | by       | abstract              | bio    | av req    | approve video | talk type | track | length     | status    | 
      | Free Beer | Bud Hops | Talk about cold gold. | My bio | Projector | Yes           | Intro     | JVM   | 50 Minutes | submitted | 
		And I am a logged in reviewer
		And I am on the review proposals page
    When I follow "Free Beer"
    Then I should see "Free Beer"
    And I should see "Bud Hops"
    And I should see "Talk about cold gold."
    And I should see "My bio"
    And I should see "Projector"
    And I should see "Yes"
    And I should see "Intro"
    And I should see "JVM"
    And I should see "50 Minutes"
    And I should see "submitted"

  Scenario: Reviewer submits a proposal rating
    Given a proposal exists
    And I am a logged in reviewer
    And I am on the default proposal review page
    When I rate the proposal with 3 out of 5 stars
    Then the default proposal should have a 3 out of 5 star rating

