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
              game: function (gamesResource, $route) {
                return gamesResource.getCurrent($route.current.params.id);
              }
            }
  });

  $routeProvider.otherwise({
    redirectTo: "/"
    //FIXME do i need to reference a controller and resolve here as well?
  });
});

// --------------- Controllers ----------------------------
Blackjack.controller("PlayerCtrl", function($scope, playersResource){
  $scope.players = playersResource.get();
  $scope.$on('update-player', function(){
    $scope.players = playersResource.get()
  })
});

Blackjack.controller("LobbyCtrl", function($scope, games){
  $scope.games = games;
});

Blackjack.controller("GameCtrl", function($scope, $http, game, gamesResource, 
                                  $routeParams, playersResource, $rootScope){

  $scope.game = game;

  $scope.amount = 0;
  //FIXME: the offical docs for ng-submit don't pass data as a argument,
  //is this just an oversight? Why is it better to pass them as values.
  //
  $scope.bet = function(){
    data = {player_bet: $scope.amount};

    //FIXME: can bet,hit,stand use factories?
    //FIXME: They are very similar functions. Is there a way to minimize this code?
    $http.put("/api/v1/players/1/games/" + $routeParams["id"] + "/bet", data).
      success(function (data) {
        $scope.game = data;
        $rootScope.$broadcast("update-player")
      })
    };
  $scope.hit = function(){
    $http.put("/api/v1/players/1/games/" + $routeParams["id"] + "/hit").
      success(function (data) {
        $scope.game = data;
        $rootScope.$broadcast("update-player")
      })
    };

  $scope.stand = function(){
    $http.put("/api/v1/players/1/games/" + $routeParams["id"] + "/stand").
      success(function (data) {
        $scope.game = data;
        $rootScope.$broadcast("update-player")
      })
    };
});

// --------------- FACTORIES ----------------------------

Blackjack.factory("playersResource", function($resource, $http) {
  //FIXME: hardcoded  player id
  return $resource("/api/v1/players/1");
});

Blackjack.factory("gamesResource", function($resource) {
  return {
    getCurrent: function (id) {
      return $resource("/api/v1/players/1/games/:gameId", {gameId: id}).get(); 
    
    },

    getLevels: function () {
      return $resource("/api/v1/games/levels").query();  
    }

  }
});

