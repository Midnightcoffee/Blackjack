Feature: Joining a Game


  Scenario: Successful join
    Given a user visits the lobby
    When they click "Beginner"
    Then they should join the game
      And they should be put into the game room
    
