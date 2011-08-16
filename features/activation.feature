Feature: A conference attendee can click on a special URL and create
an account using a third party for authentication
  
  Scenario: Attendee can click an activation link
      Given an admin exists
      And an attendee exists
      And I am on my activation page
      Then I should see "Google"
      
  Scenario: Attendee can click an activation link
      Given an admin exists
      And an attendee exists
      And I am on my bad activation token page
      Then I should see "Invalid Token"
