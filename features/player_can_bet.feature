Feature: Player can bet

  Scenario: Successful bet
    Given a user joins a game
    When they bet
    Then their bet should be placed
      And they should review cards
      And they should see the dealers card
      #TODO: add more
  
