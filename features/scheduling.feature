Feature: As a conference organizer, I can manage where and when
  conference sessions are scheduled so that speakers and attendees
  know where and when to go for each conference session.

  Background: The site requires a user before serving public content
    Given an admin exists

  Scenario: Conference organizer views all rooms for the current conference year
    Given there are no rooms
    And I am a logged in organizer
    And I am on the conference sessions admin index page
    When I follow "Manage Conference Rooms"
    Then I should see "No rooms exist for the current conference year"

  Scenario: Conference organizer adds a room
    Given I am a logged in organizer
    And I am on the conference sessions admin index page
    And I follow "Manage Conference Rooms"
    And I follow "Add a Room"
    When I change the Name field to "West Room 1"
    And I change the Capacity field to "200"
    And I change the Position field to "1"
    And I push the Save button
    Then I should be on the room index page
    And I should see "West Room 1 (cap. 200)"

  Scenario: Conference organizer views all session times for the current conference year
    Given there are no session times
    And I am a logged in organizer
    And I am on the conference sessions admin index page
    When I follow "Manage Conference Session Times"
    Then I should see "No session times exist for the current conference year"

  Scenario: Conference organizer adds a session time
    Given I am a logged in organizer
    And I am on the conference sessions admin index page
    And I follow "Manage Conference Session Times"
    And I follow "Add a Session Time"
    When I select "June 7, 2011, 14:00" as the "Start Time" date and time
    And I select "1" from "Duration (Hours:Minutes)"
    And I push the Save button
    Then I should be on the session times index page
    And I should see "Tuesday from 02:00 to 03:00 PM"

  Scenario: Conference organizer selects session time and room for conference session
    Given a talk session exists
    And a session time from this year exists
    And a room exists
    And I am a logged in organizer
    And I am on the conference sessions admin index page
    And I follow "Edit this conference session"
    When I select "Tuesday from 12:30 to 01:30 PM" from "Session Time"
    And I select "Room 1 (cap. 200)" from "Room"
    And I push the Save button
    Then I should be on the conference sessions admin index page
    And I should see "'Sample Talk' was successfully updated."

  Scenario: Conference organizer views all tracks for the current conference year
    Given there are no tracks
    And I am a logged in organizer
    And I am on the conference sessions admin index page
    When I follow "Manage Conference Tracks"
    Then I should see "No tracks exist for the current conference year"

  Scenario: Conference organizer adds a track
    Given I am a logged in organizer
    And I am on the conference sessions admin index page
    And I follow "Manage Conference Tracks"
    And I follow "Add a Track"
    When I change the Name field to "Ruby"
    And I change the Color field to "#ff0000"
    And I push the Save button
    Then I should be on the track index page
    And I should see "Ruby"

  Scenario: Conference organizer selects track for conference session
    Given a talk session exists
    And a track exists
    And I am a logged in organizer
    And I am on the conference sessions admin index page
    And I follow "Edit this conference session"
    When I select "Ruby" from "Track"
    And I push the Save button
    Then I should be on the conference sessions admin index page
    And I should see "'Sample Talk' was successfully updated."

  Scenario: Site visitor views populated schedule page

  Scenario: Schedule page shows message to come back later for schedule
    Given a talk session exists
    And I am a logged in organizer
    And schedule details are configured to be hidden
    When I am on the schedule page
    Then I see the come back later message
