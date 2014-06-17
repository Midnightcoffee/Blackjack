//= require_self

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"]);

Blackjack.config(function ($routeProvider){

  $routeProvider.when("/", {
            templateUrl: "assets/main/lobby.html",
            controller: "LobbyCtrl"
  });

  $routeProvider.when("/game", {
            templateUrl: "assets/main/game.html",
            controller: "GameCtrl"
  });

  $routeProvider.otherwise("/", {
            templateUrl: "assets/main/lobby.html",
            controller: "LobbyCtrl"
  });
});

Blackjack.controller("LobbyCtrl", function($scope, $http){
  $http.get("/api/v1/lobby").success(function (data) {
    $scope.lobby = data;
  });
});

Blackjack.controller("GameCtrl", function($scope, $http){
  $http.get("/api/v1/game").success(function (data) {
    $scope.game = data;
  });
});
