#= require_self


Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"])
Blackjack.config ($routeProvider) ->
    $routeProvider
        .when "/",
            template: "{{ lobby.level }} {{ lobby.total_chips }}"
            controller: "LobbyCtrl"


Blackjack.factory "Lobby", ($resource) ->
    $resource("/api/v1/lobby/")

Blackjack.controller "LobbyCtrl", ($scope, Lobby) ->
    $scope.getLobby = () ->
        $scope.lobby = Lobby.get()
    $scope.getLobby()
