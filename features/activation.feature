Feature: A conference attendee can click on a special URL and create an account using a third party for authentication

  Background:
    Given an admin exists
    And an attendee exists

  Scenario: Attendee forgets password
    Given a registered attendee exists
    And I am on the homepage
    And I click sign in
    And I follow "Forgot your password?"
    Then I should see "Password reset instructions go here"

