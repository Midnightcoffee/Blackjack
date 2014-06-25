//= require application
//= require angular-mocks

describe("GameCtrl", function(){
    var games;
    var mockScope = {};
    var controller;
    var backend;
    var hand = "Heart,Ace Heart,10";


    beforeEach(angular.mock.module("Blackjack"));

    beforeEach(angular.mock.inject(function ($httpBackend) {
      backend = $httpBackend;
      backend.expect("PUT", "/api/v1/players/1/games/1/bet", {bet: 20})
        .respond({bet: 20});

      backend.expect("GET", "/api/v1/players/1/games/1")
        .respond({bet: 20, player_hand: hand});
    }));
    

    beforeEach(angular.mock.inject(function($controller, $rootScope, $http) {
        

        mockScope = $rootScope.$new();
        controller = $controller("GameCtrl", {
            $scope: mockScope,
            //TODO is this an acceptable stub? It should be a mock right?
            game: {level: "Beginner", id: 1},
            $http: $http
        });
    }));


    it("scope exists", function (){
        expect(mockScope).to.exist;
    });

    it("games exists", function (){
        expect(mockScope.game).to.exist;
    });

    //FIXME: test all the attributes.
    it("has Beginner level", function (){
        expect(mockScope.game['level']).to
          .equal('Beginner');
    });

    //FIXME: how to describe test. break into two multiply tests
    it("a bet sends a PUT request and ", function() {
      mockScope.amount = 20;
      mockScope.bet();
      backend.flush();
      expect(mockScope.game['player_hand']).to.exist;
      expect(mockScope.game['player_hand']).to.equal(hand);
    });
});
