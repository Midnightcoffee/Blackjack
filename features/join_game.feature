Feature: Join Game


  Scenario: Successful join
    Given the player and games exists
      And they visit the lobby
     
    When they click "Beginner"
    Then they should be put into the game room.
      And a player stats widget.
      And that player stats widget shows his total chip count.
