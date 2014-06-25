//= require application
//= require angular-mocks

describe("LobbyCtrl", function(){
    var games;
    var mockScope = {};
    var controller;

    beforeEach(angular.mock.module("Blackjack"));

    beforeEach(angular.mock.inject(function($controller, $rootScope) {

        mockScope = $rootScope.$new();
        controller = $controller("LobbyCtrl", {
            $scope: mockScope,
            //TODO is this an acceptable stub? It should be a mock right?
            games: [{level: "Beginner", id: 1}]
        });
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
