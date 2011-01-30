Feature: As a conference talks reviewer
  I need to see talks ready to be reviewed
  So that I can curate the talks for an upcoming conference

  Background:
    Given I am a logged in reviewer

  Scenario: Reviewers visit reviews tab
    Given there are no submitted talks
    When I follow "Proposals"
    Then I should see "There are no talks ready for review"
