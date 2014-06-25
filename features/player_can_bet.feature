Feature: Player can bet

  Scenario: Successful bet
    Given the player and games exists
      And a player joins a game
    When they bet
    Then their bet should be placed
      And they should see their cards
      And they should see the dealers card
      And see the option to hold
      And see the option to hit
      And not see the option to bet
      #TODO: add more
  
