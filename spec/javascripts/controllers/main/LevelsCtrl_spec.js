//= require application
//= require angular-mocks
//
describe("LobbyCtrl", function(){
    var mockScope = {};
    var controller;
    var backend;

    beforeEach(angular.mock.module("Blackjack"));

    beforeEach(angular.mock.inject(function ($httpBackend) {
      backend = $httpBackend;
      backend.expect("GET", "/api/v1/game_levels")
        .respond({"game_levels": ['Beginner', 'Intermediate', 'High Roller']});
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

    it("levels exists", function (){
        expect(mockScope.levels).to.exist;
    });

    //FIXME: test all of them
    it("has Beginner level", function (){
        expect(mockScope.levels[0]).to
          .equal('Beginner');
    });

    //TODO test that it redirects
    it("responds to 'play' by changing location", function(){
      //FIXME: hard-coded
      mockScope.play("Beginner");
      console.log('hi');
      expect(location.path()).to.equal('/game');
    });

    //TODO test that it posts data




    
    
});
