Feature: Play at intermediate level

  Scenario: Successful bet
    Given the player and games exists
      And a player joins intermediate game
    When they bet within the correct limits
    Then they should see their intermediate bet
      And their intermediate bet should be placed
      And they should see their intermediate cards
      And they should see the intermediate dealers card
      And they should see the option to stand
      And they should see the option to hit
      And they should NOT see the option to bet

  Scenario: UnSuccessful bet
    Given the player and games exists
      And a player joins intermediate game
    When they bet
    Then they should NOT see their bet
      And their bet should NOT be placed
      And they should NOT see the option to stand
      And they should NOT see the option to hit
      And they should see the option to bet
