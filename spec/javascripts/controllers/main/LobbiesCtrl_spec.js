//= require application
//= require angular-mocks

describe("LobbyCtrl", function(){
    var mockScope = {};
    var controller;
    var backend;

    beforeEach(angular.mock.module("Blackjack"));
    // TODO: Some sort of factory
    var games = [
      {"id":1,"player_id":1,"level":"Beginner","player_bet":1,"player_hand":"MyString","dealer_hand":"MyString"},
      {"id":2,"player_id":1,"level":"Intermediate","player_bet":1,"player_hand":"MyString","dealer_hand":"MyString"},
      {"id":3,"player_id":1,"level":"High Roller","player_bet":1,"player_hand":"MyString","dealer_hand":"MyString"}];    
    beforeEach(angular.mock.inject(function ($httpBackend) {
      backend = $httpBackend;
      backend.expect("GET", "/api/v1/players/1/games")
        .respond(games);
    }));

    beforeEach(angular.mock.inject(function($controller, $rootScope, $http, $location) {
        location = $location;
        mockScope = $rootScope.$new();
        controller = $controller("LobbyCtrl", {
            $scope: mockScope,
            $http: $http
        });
        backend.flush();
    }));


    it("scope exists", function (){
        expect(mockScope).to.exist;
    });

    it("games exists", function (){
        expect(mockScope.games).to.exist;
    });

    //FIXME: test all of them
    it("has Beginner level", function (){
        expect(mockScope.games[0]['level']).to
          .equal('Beginner');
    });
});
