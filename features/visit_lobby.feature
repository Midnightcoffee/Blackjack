Feature: Visit Lobby

  Scenario: Successful visit
    Given a user visits the lobby
    Then they should see an options to join a game.
      And a player stats widget.
      And that player stats widget shows his total chip count.
  
