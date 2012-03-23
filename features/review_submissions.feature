Feature: As a conference talks reviewer
  I need to see talks ready to be reviewed
  So that I can curate the talks for an upcoming conference

  Scenario: Non-reviewer visits Proposal
    Given a proposal exists
    And I am a logged in admin
    When I am on the default proposal review page
    Then I should not see "Your Rating"

  Scenario: Reviewer visits Proposals tab before any talk submitted
    Given I am a logged in reviewer
    And there are no submitted talks
    When I follow "Proposals"
    Then I should see "There are no Talks ready for review"

  Scenario: Reviewer views list of submitted Proposals
    Given the following talks have been submitted:
       | title     | by       | status    |
       | Free Beer | Bud Hops | submitted |
    And I am a logged in reviewer
    When I follow "Proposals (1)"
    Then I should see "Proposed Talks"
    And I should see "Free Beer"
    And I should see "Bud Hops"
    And I should see "submitted"

  Scenario: Reviewer views submitted proposal
    Given the following talks have been submitted:
      | title     | by       | abstract              | bio    | av req    | approve video | talk type |  status    |
      | Free Beer | Bud Hops | Talk about cold gold. | My bio | Projector | Yes           | Intro     |  submitted |
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
    And I should see "submitted"

  Scenario: Conference Organizer views proposal review ratings
    Given a proposal exists
    And a reviewer exists
    And I am a logged in organizer
    And the proposal was rated with 3 stars by reviewer
    When I am on the default proposal review page
    Then I should see "Feedback from: reviewer"
    And I should see "3 out of 5"

  Scenario: Conference Organizer views reviewer comments
    Given a proposal exists
    And a reviewer exists
    And I am a logged in organizer
    And a comment "Like it" was added to the proposal by reviewer
    When I am on the default proposal review page
    Then I should see "Feedback from: reviewer"
    And I should see "Like it"

  @javascript
  Scenario: Reviewer comments on a proposal
    Given a proposal exists
    And I am a logged in reviewer
    And I am on the default proposal review page
    When I fill in "comment" with "My comments here"
    And I press "Add Comment"
    Then I should see "My comments here"
    And I should see "under review"

  @javascript
  Scenario: Reviewer submits a proposal rating
    Given a proposal exists
    And I am a logged in reviewer
    And I am on the default proposal review page
    When I rate the proposal with 3 stars
    Then the proposal I rated should have a 3 out of 5 star rating
    And I should see "under review"

  Scenario: Conference organizer approves proposal
    Given a proposal exists
    And a session time from this year exists
    And there are no conference sessions
    And I am a logged in organizer
    And I am on the default proposal review page
    And I check "sendmail"
    And I choose "Approve talk"
    When I press "Decide"
    Then I should see "accepted"
    And a congrats email should be sent to the submitter
    And I follow "Proposals"
    And I should see "accepted"
    Then I am on the default conference session page
    And I should see "Title"

  Scenario: Conference organizer tries to approve proposal without a session time
    Given a proposal exists
    And there are no conference sessions
    And I am a logged in organizer
    And I am on the default proposal review page
    And I choose "Approve talk"
    And I check "sendmail"
    When I press "Decide"
    Then I should see "You must select a session time"

  Scenario: Conference organizer approves proposal, does not want email sent
    Given a proposal exists
    And a session time from this year exists
    And there are no conference sessions
    And I am a logged in organizer
    And I am on the default proposal review page
    And I choose "Approve talk"
    When I press "Decide"
    Then I should see "accepted"
    And no email should be sent
    And I follow "Proposals"
    And I should see "accepted"
    And I am on the default conference session page
    Then I should see "Title"

  Scenario: Conference organizer rejects an approved proposal
    Given a proposal exists
    And there are no conference sessions
    And I am a logged in organizer
    And I am on the default proposal review page
    And I check "sendmail"
    And I choose "Reject talk"
    When I press "Decide"
    Then I should see "rejected"
    And a rejection email should be sent to the submitter
    And I follow "Proposals"
    Then I should see "rejected"

  Scenario: Conference organizer rejects an approved proposal
    Given a proposal exists
    And there are no conference sessions
    And I am a logged in organizer
    And I am on the default proposal review page
    And I choose "Reject talk"
    When I press "Decide"
    Then I should see "rejected"
    And no email should be sent
    And I follow "Proposals"
    Then I should see "rejected"

  @57
  Scenario: Reviewers see rating indicator for proposals they have already rated
    Given I am a logged in reviewer
    And I have rated a proposal
    When I see all proposals
    Then the proposal I rated should have a 3 out of 5 star rating

  @wip
  Scenario: Reviewer flags a proposal for follow-up
    Given a proposal exists
    When I flag the proposal for follow-up
    Then I should see the proposal has been flagged

  @wip
  Scenario: Reviewer clears follow-up flag on proposal
    Given a flagged proposal exists
    When I clear the follow-up flag on the proposal
    Then I should see the proposal is no longer flagged

