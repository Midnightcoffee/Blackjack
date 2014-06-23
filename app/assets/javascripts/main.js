//= require_self

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"]);

// FIXME: routeProviders could be chained?
Blackjack.config(function ($routeProvider){

  $routeProvider.when("/", {
            templateUrl: "assets/main/lobby.html",
            controller: "LobbyCtrl"
  });

  $routeProvider.when("/games/:id", {
            templateUrl: "assets/main/game.html",
            controller: "GameCtrl"
  });

  $routeProvider.otherwise({
    redirectTo: "/"
  });
});

Blackjack.controller("PlayerCtrl", function($scope, $http){

  // FIXME hard coded player id
  // FIXME player on scope 
  $http.get("/api/v1/players/1").success(function (data) {
    //TODO is this an example of reading, which is discouraged?
    $scope.player = data;
  }); 

});

Blackjack.controller("LobbyCtrl", function($scope, $http, $location){

  $scope.choose = { level: 'Beginner' };
  $scope.master = {};

  $http.get("/api/v1/players/1/games").success(function (data) {
    $scope.games = data;
  });

  $scope.play = function(level) {

    //todo have server send id of game and level
    $scope.levelChoosen = angular.copy(level);
    data = {level: $scope.levelChoosen};
    $location.path('/games/'.concat(game_id));

   };
});


// FIXME: bet vs amount
Blackjack.controller("GameCtrl", function($scope, $http, $location, $routeParams){

  $scope.gameId = $routeParams.gameId;
  // $http.put("/api/v1/games/1").success(function (data) {
  //   $scope.game = data;
  // });

  $scope.amount = 0;
  $scope.bet = function(){

    data = {bet: $scope.amount}
    // FIXME: hard coded game, only one game currently
    // TODO: his should be game/1/bet
    $http.put("/api/v1/game/1/bet", data)
      .success(function () {

        $http.get("/api/v1/game").success(function (data) {
          $scope.game = data;
        });

      })
  };
});

