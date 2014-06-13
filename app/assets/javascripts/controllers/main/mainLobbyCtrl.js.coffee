#= require lobby
Blackjack = angular.module("Blackjack")



Blackjack.controller "LobbyCtrl", ($scope, Lobby) ->
    console.log('foo')
    $scope.getLobby = () ->
        $scope.lobby = Lobby.get()

