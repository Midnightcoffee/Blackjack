//= require_self


// Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"])
// Blackjack.config ($routeProvider) ->
//     $routeProvider
//         .when "/",
//             templateUrl: "assets/main/lobby.html"
//             controller: "LobbyCtrl"


// Blackjack.factory "Lobby", ($resource) ->
//     $resource("/api/v1/lobby/")

// Blackjack.controller "LobbyCtrl", ($scope, Lobby) ->
//     $scope.getLobby = () ->
//         $scope.lobby = Lobby.get()
//     $scope.getLobby()

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"]);

Blackjack.config(function ($routeProvider){
  $routeProvider.when("/", {
            templateUrl: "assets/main/lobby.html",
            controller: "LobbyCtrl"
  });
});

Blackjack.controller("LobbyCtrl", function($scope, $http){
  $http.get("/api/v1/lobby").success(function (data) {
    $scope.lobby = data;
  });
});
