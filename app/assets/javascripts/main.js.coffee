#= require_self
#= require_tree ./angular

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"])
Blackjack.config ($routeProvider) ->
    $routeProvider
        .when "/",
            templateUrl: "/assets/main/lobby.html.haml"
            controller: "LobbyCtrl"

