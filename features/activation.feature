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
      Then I should see "Sorry but the link you followed seems to be missing some important bits"

  Scenario: Attendee gets error message when not entering password
      Given an admin exists
      And an attendee exists
      When I am on my activation page
      Then I should see "Email"
      And I should see "Password"
      And I should see "Password Confirmation"
      And I press "Register"
      Then I should see "Failed to create password"

  Scenario: Attendee gets error message when not entering password confirmation
      Given an admin exists
      And an attendee exists
      When I am on my activation page
      Then I should see "Email"
      And I should see "Password"
      And I should see "Password Confirmation"
      Then I fill in "Password" with "somelongvalue"      
      And I press "Register"
      Then I should see "Failed to create password"      
      
  Scenario: Attendee can create attendee credentials with a password
      Given an admin exists
      And an attendee exists
      When I am on my activation page
      Then I should see "Email"
      And I should see "Password"
      And I should see "Password Confirmation"
      Then I fill in "Password" with "somelongvalue"
      Then I fill in "Password Confirmation" with "somelongvalue"
      And I press "Register"
      Then I should see "Welcome! You have signed up successfully."
      Then I should see "My Conference Schedule"

