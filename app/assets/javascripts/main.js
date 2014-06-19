//= require_self

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"]);

// FIXME: routeProviders could be chained?
Blackjack.config(function ($routeProvider){

  $routeProvider.when("/", {
            templateUrl: "assets/main/lobby.html",
            controller: "LobbyCtrl"
  });

  $routeProvider.when("/game", {
            templateUrl: "assets/main/game.html",
            controller: "GameCtrl"
  });

  $routeProvider.otherwise({
    redirectTo: "/"
  });
});

Blackjack.controller("LobbyCtrl", function($scope, $http, $location){
  $scope.master = {};

  $http.get("/api/v1/lobby").success(function (data) {
    $scope.lobby = data;
  });

  $scope.play = function(level) {

    $scope.levelChoosen = angular.copy(level);
    data = {level: $scope.levelChoosen}

    $http.post("/api/v1/lobby", data)
      .success(function () {
        $location.path('/game') 
      })
      .error(function() {
        //TODO: Anything useful here?
        console.log('ERROR');
      });
   };
});
// FIXME: bet vs amount
Blackjack.controller("GameCtrl", function($scope, $http){

  $http.get("/api/v1/game").success(function (data) {
    $scope.game = data;
  });

  $scope.amount = 0;
  // FIXME is this intro to callback hell?
  $scope.bet = function(){

    data = {bet: $scope.amount}
    // FIXME: if game exists it should be a PUT..
    // FIXME: hard coded game, only one game currently
    $http.put("/api/v1/game/1", data)
      .success(function () {

        //API/v1/bet return 
        //resource bet
        // REST is not crud
        // very clear from rake routes.

        $http.get("/api/v1/game").success(function (data) {
          $scope.game = data;
        });

      })
    
  };
});


