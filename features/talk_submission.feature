Feature: As an anonymous user I can enter a talk along with
  speaker information so that it can be reviewed and determined
  if it is appropriate for the conference
  
  Scenario: Users can enter a talk
      Given a refinery user exists
      When I go to the new talks page
      When I fill in the following:
      | Title | Squashing NP Hard Problems with Clojure |
      | Abstract | Using only functions, sequences and three toothpicks I will make 3 SAT solvable in O(n) time |
      | Comments | Already have my solution approved by Karp |
      | Prereqs | Solving other NP-Hard problems in O(n) time |
      | Av requirement | Just need a projector capable of displaying two lines of code |
      When I select "Deep Dive" in "Talk type"
      When I select "5 Minutes" in "Talk length"
      When I select "No" in "talk_video_approval"
      When I press "Create Talk"
      Then I should see "Squashing NP Hard Problems with Clojure"
      Then I should see "Deep Dive"
      Then I should see "5 Minutes"
      Then I should see "Karp"
      Then I should see "projector"
      

