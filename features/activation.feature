Feature: A conference attendee can click on a special URL and create an account using a third party for authentication

  Background:
    Given an admin exists
    And an attendee exists

  Scenario: Attendee can click an activation link
    Given I am on my activation page
    Then I should see "Email"
    And I should see "Password"
    And I should see "Password Confirmation"
    And I should see login via Twitter link
    And I should see login via Github link
    And I should see login via Google activation link

  Scenario: Attendee can click an activation link
    Given I am on my bad activation token page
    Then I should see "Sorry but the link you followed seems to be missing some important bits"

  Scenario: Attendee gets error message when not entering password
    Given I am on my activation page
    And I should see "Email"
    And I should see "Password"
    And I should see "Password Confirmation"
    When I press "Register"
    Then I should see "Registration failed, please try again: password can't be blank"

  Scenario: Attendee gets error message when not entering password confirmation
    Given I am on my activation page
    And I fill in "Password" with "somelongvalue"
    When I press "Register"
    Then I should see "Registration failed, please try again: password doesn't match confirmation"

  Scenario: Attendee can create attendee credentials with a password
    Given I am on my activation page
    And I fill in "Password" with "somelongvalue"
    And I fill in "Password Confirmation" with "somelongvalue"
    When I press "Register"
    Then I should see "Welcome! You have signed up successfully."
    And I should see "My Conference Schedule"

  Scenario: Attendee can login with new credentials
    Given I am on my activation page
    And I fill in "Password" with "somelongvalue"
    And I fill in "Password Confirmation" with "somelongvalue"
    When I press "Register"
    Then I should see "Welcome! You have signed up successfully."
    When I sign out
    And I click sign in
    And I fill in my email address
    And I fill in "Password" with "somelongvalue"
    And I press "Login"
    Then I should see "Conference Attendees"

  Scenario: Attendee forgets password
    Given a registered attendee exists
    And I am on the homepage
    And I click sign in
    And I follow "Forgot your password?"
    And I fill in my registered email address
    When I press "Reset Password"
    Then I should see "You will receive an email with instructions about how to reset your password in a few minutes."

  Scenario: Invalid password supplied to password reset form
    Given I am on the homepage
    And I click sign in
    And I follow "Forgot your password?"
    And I fill in "Registration Email" with "foo@bar.com"
    When I press "Reset Password"
    Then I should see "Email not found"
