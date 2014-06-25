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
              data: function (gamesResource) {
                return gamesResource.getCurrentGame();
              }
            }
  });

  $routeProvider.otherwise({
    redirectTo: "/"
  });
});

// --------------- Controllers ----------------------------
Blackjack.controller("PlayerCtrl", function($scope, playersResource){
  $scope.players = playersResource.get();
});

Blackjack.controller("LobbyCtrl", function($scope, games){
  $scope.games = games;
});

Blackjack.controller("GameCtrl", function($scope, $http, $location, $routeParams, 
                                          data, gamesResource){
  $scope.gameId = $routeParams.gameId;
  
  $scope.game = data;
  $scope.game

  $scope.amount = 0;
  //FIXME: the offical docs for ng-submit don't pass data as a argument,
  //is this just an oversight? Why is it better to pass them as values.
  $scope.bet = function(){
    data = {bet: $scope.amount}
    // FIXME: hard coded player id, only one game currently
    

    // $http.put("/api/v1/players/1/games/1/bet", data)
    //   .success(function () {
    //     // hand code game id

    //     $http.get("/api/v1/players/1/games/1").success(function (data) {
    //       $scope.game = data;
    //     });

    //   })
  };
});

// --------------- FACTORIES ----------------------------
//
Blackjack.factory("levelsResource", function($resource) {
  return $resource("/api/v1/games/levels");
});

Blackjack.factory("playersResource", function($resource) {
  //FIXME: hardcoded  player id
  return $resource("/api/v1/players/1");
});

Blackjack.factory("gamesResource", function($resource) {
  return {
    getCurrentGame: function () {
      return $resource("/api/v1/players/1/games/" + ":id").query(); 
    
    },

    getLevels: function () {
      return $resource("/api/v1/games/levels").query();  
    }
  }
});

