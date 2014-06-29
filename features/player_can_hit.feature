Feature: Player can hit

  Scenario: Successful hit (not bust)
    Given the player and games exists
      And a player joins a game
      And they bet
      And they should see the option to hit
    Then they should be able to hit
      And they should see their card
    
  Scenario: UnSuccessful hit
    Given the player and games exists
      And a player joins a game
      And they bet
      And they should see the option to hit
    Then they should be able to hit
      And they should NOT see their card
