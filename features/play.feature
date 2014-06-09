Feature: playing

  Scenario: Successful hit
    Given a user visits the game page
    When they take a hit
    Then they should get a card

  Scenario: UnSuccessful hit
    Given a user visits the game page
    When they take a hit
    Then they shouldnt get a card
