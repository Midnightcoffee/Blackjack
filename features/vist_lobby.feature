Feature: Exploring the lobby

  Scenario: Successful visit
    Given a user visits the lobby
    Then they should see an option to create a beginner game
      And a player stats widget.
  
