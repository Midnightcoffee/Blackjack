//= require_self

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"]);

// FIXME: routeProviders could be chained?
Blackjack.config(function ($routeProvider){

  $routeProvider.when("/", {
            templateUrl: "assets/main/lobby.html",
            controller: "LobbyCtrl",
            resolve: {
                data: function (levelsResource) {
                  return levelsResource.query();
              }
            }
  });

  $routeProvider.when("/games/:id", {
            templateUrl: "assets/main/game.html",
            controller: "GameCtrl",
            resolve: {
              load: function ($route, gameFactory) {
                return gameFactory.getGameState($route.current.params.id);
              }
            }
  });

  $routeProvider.otherwise({
    redirectTo: "/"
  });
});

Blackjack.controller("PlayerCtrl", function($scope, $http, playerFactory){


  // FIXME hard coded player id
  // FIXME player on scope 
  $scope.player = playerFactory.data;

});



//TODO: better nameing convention games vs levels.
Blackjack.controller("LobbyCtrl", function($scope, $http, data){
  //extra object "data" allows it to below to multiply controllers
  $scope.games = data;
});


// FIXME: bet vs amount
Blackjack.controller("GameCtrl", function($scope, $http, $location, $routeParams, gameFactory){

  $scope.gameId = $routeParams.gameId;
  


  //hard coded player id
  // $http.get("/api/v1/players/1/games/1").success(function (data) {
  //   $scope.game = data;
  // });

  $scope.gameState = get

  $scope.amount = 0;
  $scope.bet = function(){
    data = {bet: $scope.amount}
    // FIXME: hard coded player id, only one game currently
    $http.put("/api/v1/players/1/games/1/bet", data)
      .success(function () {
        // hand code game id

        $http.get("/api/v1/players/1/games/1").success(function (data) {
          $scope.game = data;
        });

      })
  };
});

Blackjack.factory("gameFactory", function($http, $q) {

  return {

    data : {},
    getGameState : function(id){
      var urlBase = "/api/v1/players/1/games/";
      var defer = $q.defer();
      var data = this.data;
      $http.get(urlBase.concat(id)).success(function (data) {
        defer.resolve(data);
      });
      //TODO: on failure?
      return defer.promise;
    }
  };
});

Blackjack.factory("levelsResource", function($resource) {
  return $resource("/api/v1/games/levels");

});




// Blackjack.factory("gameLevelsFactory", function($http, $q) {

//   return {

//     data : {},
//     levels : function(id){
//       var url = "/api/v1/games/levels";
//       var defer = $q.defer();
//       var data = this.data;
//       $http.get(url).success(function (data) {
//         defer.resolve(data);
//       });
//       //TODO: on failure?
//       return defer.promise;
//     }
//   };
// });

Blackjack.factory("playerFactory", function($http, $q) {

  return {
    data: {},
    getPlayerState : function(id){
      //FIXME shared logic between other controllers.
      var urlBase = "/api/v1/players/";
      var defer = $q.defer();
      var data = this.data;
      $http.get(urlBase.concat(id)).success(function (data) {
        defer.resolve(data);
      });
      //TODO: on failure?
      return defer.promise;
    }
  };

});
  

