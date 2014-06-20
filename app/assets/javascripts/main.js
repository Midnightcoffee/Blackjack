//= require_self

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"]);

// FIXME: routeProviders could be chained?
Blackjack.config(function ($routeProvider){

  $routeProvider.when("/", {
            templateUrl: "assets/main/lobby.html"
  });

  $routeProvider.when("/games/:id", {
            templateUrl: "assets/main/game.html",
            controller: "GameCtrl"
  });

  $routeProvider.otherwise({
    redirectTo: "/"
  });
});

Blackjack.controller("TotalChipsCtrl", function($scope, $http){

  // FIXME hard coded player id
  $http.get("/api/v1/total_chips/1").success(function (data) {
    $scope.player = data;
  });
});

Blackjack.controller("LevelCtrl", function($scope, $http, $location){

  $scope.choose = { level: 'Beginner' };
  $scope.master = {};

  $http.get("/api/v1/game_levels").success(function (data) {
    $scope.levels = data["game_levels"];
  });

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

Blackjack.controller("PlayCtrl", function($scope, $http, $location){

  $scope.play = function(level) {

    $scope.levelChoosen = angular.copy(level);
    data = {level: $scope.levelChoosen};

    // FIXME hard coded game level 
    // TODO better way to transfer and pack json?
    $http.post("/api/v1/games", data)
      .success(function (data) {
        game_id = data["game_id"];
        $location.path('/games/'.concat(game_id));
      })
      .error(function() {
        //TODO: Anything useful here?
        console.log('ERROR');
      });
   };
});

