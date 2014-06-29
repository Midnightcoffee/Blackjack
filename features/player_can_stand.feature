Feature: Player can stand

  Scenario: Successful stand
    Given the player and games exists
      And a player joins a game
      And they bet
      And they should see the option to stand
    Then they should be able to stand
      #TODO: mock feature
      And they should see the option to bet


    
