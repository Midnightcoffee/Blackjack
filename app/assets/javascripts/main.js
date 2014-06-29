//= require_self

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"]);

// FIXME: routeProviders should be chained?
Blackjack.config(function ($routeProvider){

  $routeProvider.when("/", {
            templateUrl: "assets/main/lobby.html",
            controller: "LobbyCtrl",
            resolve: {
                games: function (gamesResource) {
                  return gamesResource.getLevels();
              }
            }
  });

  $routeProvider.when("/games/:id", {
            templateUrl: "assets/main/game.html",
            controller: "GameCtrl",
            resolve: {
              game: function (gamesResource) {
                return gamesResource.getCurrent();
              }
            }
  });

  $routeProvider.otherwise({
    redirectTo: "/"
    //FIXME do i need to reference the controller and resolve here as well?
  });
});

// --------------- Controllers ----------------------------
Blackjack.controller("PlayerCtrl", function($scope, playersResource){
  $scope.players = playersResource.get();
});

Blackjack.controller("LobbyCtrl", function($scope, games){
  $scope.games = games;
});

Blackjack.controller("GameCtrl", function($scope, $http, game, gamesResource){
  
  $scope.game = game;


  $scope.amount = 0;
  //FIXME: the offical docs for ng-submit don't pass data as a argument,
  //is this just an oversight? Why is it better to pass them as values.
  $scope.bet = function(){
    //FIXME hard coded
    data = {player_bet: $scope.amount};
    //FIXME: hard coded player id, only one game currently
    $http.put("/api/v1/players/1/games/1/bet", data).
      success(function (data) {
        $scope.game = data;

      })
    };
  $scope.hit = function(){
    //FIXME hard coded
    //FIXME: hard coded player id, only one game currently
    $http.put("/api/v1/players/1/games/1/hit").
      success(function (data) {
        $scope.game = data;

      })
    };

  $scope.stand = function(){
    //FIXME hard coded
    //FIXME: hard coded player id, only one game currently
    $http.put("/api/v1/players/1/games/1/stand").
      success(function (data) {
        $scope.game = data;

      })
    };
});

// --------------- FACTORIES ----------------------------
//
Blackjack.factory("playersResource", function($resource, $http) {
  //FIXME: hardcoded  player id
  return $resource("/api/v1/players/1");
});

Blackjack.factory("gamesResource", function($resource) {
  return {
    getCurrent: function () {
      //FIXME: hardcoded
      return $resource("/api/v1/players/1/games/1").get(); 
    
    },

    getLevels: function () {
      return $resource("/api/v1/games/levels").query();  
    },

    betAmount: function () {
      //FIXME: hardcoded
      return $http("PUT", "/api/v1/players/1/games/1/bet").query();  
    }
  }
});

