Feature: As an anonymous user I can enter a talk along with
  speaker information so that it can be reviewed and determined
  if it is appropriate for the conference
  
  Scenario: Users can enter a talk
      Given an admin exists
      And I go to the new talks page
      And I fill in the following:
      | Title | Squashing NP Hard Problems with Clojure |
      | Abstract | Using only functions, sequences and three toothpicks I will make 3 SAT solvable in O(n) time |
      | Reviewer Comments | Already have my solution approved by Karp |
      | Prerequisites | Solving other NP-Hard problems in O(n) time |
      | Audio/Video Requirement | Just need a projector capable of displaying two lines of code |
      | First Name | Clem |
      | Last Name | Esterbill |
      | Email | clem_esterbill@fictionaldns.com |
      | Bio | Background info here |
      | Phone | 555-555-5555 |
      | City | St. Louis |
      | State | MO |
      
      And I select "Deep Dive" in "Talk Type"
      And I select "No" in "Video Approval"
      And I select "United States" in "Country"
      And I fill in "Tags" with "theory, clojure"      
      
      When I press "Send Talk Proposal"
      Then I should see "Squashing NP Hard Problems with Clojure"
      And I should see "Deep Dive"
      And I should see "50 Minutes"
      And I should see "Karp"
      And I should see "projector"
      And I should see "Clem Esterbill"
      And I should see "clem_esterbill@fictionaldns.com"
      And I should see "Background info here"
      And I should see "555-555-5555"
      And I should see "St. Louis"
      And I should see "MO"
      And I should see "United States"
      And I should see "theory"
      And I should see "clojure"   
      And an email should be sent
      
      
      
      

