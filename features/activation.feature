Feature: A conference attendee can click on a special URL and create an account using a third party for authentication

  Background:
    Given an admin exists
    And an attendee exists

  @wip
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

  @wip
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
