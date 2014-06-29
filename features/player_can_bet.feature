Feature: Player can bet

  Scenario: Successful bet
    Given the player and games exists
      And a player joins a game
    When they bet
    Then they should see their bet
      And their bet should be placed
      And they should see their cards
      And they should see the dealers card
      And they should see the option to hold
      And they should see the option to hit
      And they should NOT see the option to bet

    #TODO: add unsuccesfful bet
  
