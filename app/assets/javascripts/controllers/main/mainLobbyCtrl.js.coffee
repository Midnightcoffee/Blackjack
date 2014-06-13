#= require models/lobby


Blackjack = angular.module("Blackjack")



Blackjack.controller "LobbyCtrl", ($scope, Lobby) ->
    $scope.getLobby = () ->
        $scope.lobby = Lobby.get()


