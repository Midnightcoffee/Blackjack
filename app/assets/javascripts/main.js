//= require_self

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"]);

// FIXME: routeProviders could be chained?
Blackjack.config(function ($routeProvider){

  $routeProvider.when("/", {
            templateUrl: "assets/main/lobby.html"
  });

  $routeProvider.when("/game", {
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
  $scope.master = {};

  $http.get("/api/v1/game_levels").success(function (data) {
    $scope.levels = data["game_levels"];
    console.log($scope.levels);
  });

  $scope.play = function(level) {

    $scope.levelChoosen = angular.copy(level);
    data = {level: $scope.levelChoosen}

    $http.post("/api/v1/game_authorizer", data)
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


