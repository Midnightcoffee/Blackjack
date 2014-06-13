Blackjack = angular.module("Blackjack")

Blackjack.factory "Lobby", ($resource) ->
    $resource("/api/v1/lobby/")
