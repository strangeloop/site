Feature: As an anonymous user I can enter a talk along with
  speaker information so that it can be reviewed and determined
  if it is appropriate for the conference
  
  Scenario: Users can enter a talk
      Given an admin exists
      When I go to the new talks page
      When I fill in the following:
      | Title | Squashing NP Hard Problems with Clojure |
      | Abstract | Using only functions, sequences and three toothpicks I will make 3 SAT solvable in O(n) time |
      | Comments | Already have my solution approved by Karp |
      | Prereqs | Solving other NP-Hard problems in O(n) time |
      | Av requirement | Just need a projector capable of displaying two lines of code |
      | First name | Clem |
      | Last name | Esterbill |
      | Email | clem_esterbill@fictionaldns.com |
      | Bio | Background info here |
      | Phone | 555-555-5555 |
      
      And I select "Deep Dive" in "Talk type"
      And I select "5 Minutes" in "Talk length"
      And I select "No" in "talk_video_approval"

      And I select "MO" in "State"
      And I select "US" in "Country"
      And I press "Create Talk"
      
      Then I should see "Squashing NP Hard Problems with Clojure"
      And I should see "Deep Dive"
      And I should see "5 Minutes"
      And I should see "Karp"
      And I should see "projector"
      And I should see "Clem Esterbill"
      And I should see "clem_esterbill@fictionaldns.com"
      And I should see "Background info here"
      And I should see "555-555-5555"
      And I should see "MO"
      And I should see "US"
      
      
      

