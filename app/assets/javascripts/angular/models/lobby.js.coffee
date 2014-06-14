Blackjack = angular.module("Blackjack")


#TODO: specify the method e.g PUT vs GET?
Blackjack.factory "Lobby", ($resource) ->
    $resource("/api/v1/lobby/")
