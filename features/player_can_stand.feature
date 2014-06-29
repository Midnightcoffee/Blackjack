Feature: Player can stand

  Scenario: Successful stand
    Given the player and games exists
      And a player joins a game
      And they bet
      And they should see the option to stand
    Then they should be able to stand
      And they should see the dealers remaining card
      And they should see the dealer play


    
