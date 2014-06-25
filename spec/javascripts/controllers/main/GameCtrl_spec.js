//= require application
//= require angular-mocks

describe("GameCtrl", function(){
    var games;
    var mockScope = {};
    var controller;


    beforeEach(angular.mock.module("Blackjack"));
    // TODO: Some sort of factory possible revert back to game_level
    // var levels = ['Beginner', 'Intermediate', 'High Roller'];
    // beforeEach(angular.mock.inject(function ($httpBackend) {
    //   backend = $httpBackend;
    //   backend.expect("GET", "/api/v1/games/levels")
    //     .respond(levels);
    // }));
    //

    beforeEach(angular.mock.inject(function($controller, $rootScope) {
        

        mockScope = $rootScope.$new();
        controller = $controller("GameCtrl", {
            $scope: mockScope,
            //TODO is this an acceptable stub? It should be a mock right?
            game: {level: "Beginner", id: 1}
        });
    }));


    it("scope exists", function (){
        expect(mockScope).to.exist;
    });

    it("games exists", function (){
        expect(mockScope.game).to.exist;
    });

    //FIXME: test all the attributes
    it("has Beginner level", function (){
        expect(mockScope.game['level']).to
          .equal('Beginner');
    });
});
