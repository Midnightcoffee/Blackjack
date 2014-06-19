//= require application
//= require angular-mocks
//
describe("LevelCtrl", function(){
    var mockScope = {};
    var controller;
    var backend;

    beforeEach(angular.mock.module("Blackjack"));

    beforeEach(angular.mock.inject(function ($httpBackend) {
      backend = $httpBackend;
      backend.expect("GET", "/api/v1/game_levels")
        .respond({"game_levels": ['Beginner', 'Intermediate', 'High Roller']});
    }));

    beforeEach(angular.mock.inject(function($controller, $rootScope, $http) {
        mockScope = $rootScope.$new();
        controller = $controller("LevelCtrl", {
            $scope: mockScope,
            $http: $http
        });
        backend.flush();
    }));


    it("scope exists", function (){
        expect(mockScope).to.exist;
    });

    it("levels exists", function (){
        expect(mockScope.levels).to.exist;
    });

    it("has at least one right level", function (){
        expect(mockScope.levels[0]).to
          .equal('Beginner');
    });

});
