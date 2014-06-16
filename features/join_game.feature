Feature: Joining a Game

  Scenario: Successful join
    Given a user visits the blackjack game room
    When they click "join game"
    Then they should join the game
    
