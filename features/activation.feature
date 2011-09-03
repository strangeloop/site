Feature: A conference attendee can click on a special URL and create an account using a third party for authentication

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
    When I am on my bad activation token page
    Then I should see "Sorry but the link you followed seems to be missing some important bits"

  Scenario: Attendee gets error message when not entering password
    Given an admin exists
    And an attendee exists
    And I am on my activation page
    And I should see "Email"
    And I should see "Password"
    And I should see "Password Confirmation"
    When I press "Register"
    Then I should see "Failed to create password"

  Scenario: Attendee gets error message when not entering password confirmation
    Given an admin exists
    And an attendee exists
    And I am on my activation page
    And I fill in "Password" with "somelongvalue"
    When I press "Register"
    Then I should see "Failed to create password"

  Scenario: Attendee can create attendee credentials with a password
    Given an admin exists
    And an attendee exists
    And I am on my activation page
    And I fill in "Password" with "somelongvalue"
    And I fill in "Password Confirmation" with "somelongvalue"
    When I press "Register"
    Then I should see "Welcome! You have signed up successfully."
    And I should see "My Conference Schedule"

  Scenario: Attendee can login with new credentials
    Given an admin exists
    And an attendee exists
    When I am on my activation page
    Then I fill in "Password" with "somelongvalue"
    Then I fill in "Password Confirmation" with "somelongvalue"
    And I press "Register"
    Then I should see "Welcome! You have signed up successfully."
    Then I sign out
    Then I click sign in
    Then I fill in my email address
    And I fill in "Password" with "somelongvalue"
    Then I press "Login"
    Then I should see "Signed in successfully"
    Then I should see "My Conference Schedule"
