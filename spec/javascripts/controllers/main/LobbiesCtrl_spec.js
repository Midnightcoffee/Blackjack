//= require application
//= require angular-mocks

describe("LobbyCtrl", function(){
    var mockScope = {};
    var controller;
    var backend;

    beforeEach(angular.mock.module("Blackjack"));
    // TODO: Some sort of factory possible revert back to game_level
    var levels = ['Beginner', 'Intermediate', 'High Roller'];
    beforeEach(angular.mock.inject(function ($httpBackend) {
      backend = $httpBackend;
      backend.expect("GET", "/api/v1/games/levels")
        .respond(levels);
    }));

    beforeEach(angular.mock.inject(function($controller, $rootScope, $http) {
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
        expect(mockScope.levels[0]).to
          .equal('Beginner');
    });
});
