Feature: As an anonymous user I can enter a talk along with
  speaker information so that it can be reviewed and determined
  if it is appropriate for the conference

  Background:
    Given an admin exists

  Scenario: Users can enter a talk
      Given an admin exists
      And a talk track exists
      And I go to the talk submission page
      And I fill in the following:
      | Title | Squashing NP Hard Problems with Clojure |
      | Abstract | Using only functions, sequences and three toothpicks I will make 3 SAT solvable in O(n) time |
      | Reviewer Comments | Already have my solution approved by Karp |
      | Prerequisites | Solving other NP-Hard problems in O(n) time |
      | Audio/Video Requirement | Just need a projector capable of displaying two lines of code |
      | First Name | Clem |
      | Last Name | Esterbill |
      | Email | clem_esterbill@fictionaldns.com |
      | Twitter ID | clemtweets |
      | Company | Clemalamadingdong |
      | Company Website | http://clem.com |
      | Bio | Background info here |
      | Phone | 555-555-5555 |
      | City | St. Louis |
      | State | MO |

      And I select "Big Data" in "Track"
      And I select "No" in "Video Approval"
      And I select "United States" in "Country"
      And I fill in "Tags" with "theory, clojure"

      And I should see "Max length: 4000 characters."

      When I press "Send Talk Proposal"
      Then I should see "Squashing NP Hard Problems with Clojure"
      And I should see "Big Data"
      And I should see "Karp"
      And I should see "projector"
      And I should see "Clem Esterbill"
      And I should see "clem_esterbill@fictionaldns.com"
      And I should see a link with "@clemtweets" to "https://twitter.com/clemtweets"
      And I should see a link with "Clemalamadingdong" to "http://clem.com"
      And I should see "Background info here"
      And I should see "555-555-5555"
      And I should see "St. Louis"
      And I should see "MO"
      And I should see "United States"
      And I should see "theory"
      And I should see "clojure"
      And an email should be sent

  Scenario: Users can enter a short talk
      Given I go to the talk submission page
      And I fill in the following:
      | Title | Squashing NP Hard Problems with Clojure |
      | Abstract | Using only functions, sequences and three toothpicks I will make 3 SAT solvable in O(n) time |
      | Reviewer Comments | Already have my solution approved by Karp |
      | Prerequisites | Solving other NP-Hard problems in O(n) time |
      | Audio/Video Requirement | Just need a projector capable of displaying two lines of code |
      | First Name | Clem |
      | Last Name | Esterbill |
      | Email | clem_esterbill@fictionaldns.com |
      | Twitter ID | clemtweets |
      | Company | Clemalamadingdong |
      | Company Website | http://clem.com |
      | Bio | Background info here |
      | Phone | 555-555-5555 |
      | City | St. Louis |
      | State | MO |

      And I select "No" in "Video Approval"
      And I select "United States" in "Country"
      And I fill in "Tags" with "theory, clojure"

      And I should see "Max length: 4000 characters."

      When I press "Send Talk Proposal"
      Then I should see "Squashing NP Hard Problems with Clojure"
      And I should see "Karp"
      And I should see "projector"
      And I should see "Clem Esterbill"
      And I should see "clem_esterbill@fictionaldns.com"
      And I should see a link with "@clemtweets" to "https://twitter.com/clemtweets"
      And I should see a link with "Clemalamadingdong" to "http://clem.com"
      And I should see "Background info here"
      And I should see "555-555-5555"
      And I should see "St. Louis"
      And I should see "MO"
      And I should see "United States"
      And I should see "theory"
      And I should see "clojure"
      And an email should be sent

  @60
  Scenario: Proposal submission period expired
    Given the period for submitting workshop proposals has expired
    When I try to create a new workshop proposal
    Then I see a message that the workshop proposal period has expired



