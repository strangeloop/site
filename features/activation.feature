Feature: A conference attendee can click on a special URL and create
an account using a third party for authentication

  Scenario: Attendee can click an activation link
      Given an admin exists
      And an attendee exists
      When I am on my activation page
      Then I should see "Email"
      And I should see "Password"
      And I should see "Password Confirmation"
      And I should see login via Twitter link
      And I should see login via Github link
      And I should see login via Google activation link

  Scenario: Attendee can click an activation link
      Given an admin exists
      And an attendee exists
      And I am on my bad activation token page
      Then I should see "Invalid Token"
