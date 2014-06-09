Feature: playing

  Scenario: Successful hit
    Given a user visits the game page
    When they take a hit
    Then they should get a card
    #TODO: and see a response? How do i check html and model

  Scenario: UnSuccessful hit
    Given a user visits the game page
    When they take a hit
    Then they shouldnt get a card
