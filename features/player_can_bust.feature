Feature: Player can bust

  Scenario: Successful bust
    Given the player and games exists
      And a player joins a rigged against them game
      And they bet
      And they should see the option to hit
    Then they should be able to hit
      #TODO: mock feature
      And they should bust
