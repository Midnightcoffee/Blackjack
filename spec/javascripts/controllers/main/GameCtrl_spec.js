//= require application
//= require angular-mocks

describe("GameCtrl", function(){
    var games;
    var mockScope = {};
    var controller;
    var backend;
    //TODO: possible abstract hands to just 'data'
    var dealer_hand = "Heart,Ace|Heart,10|";
    var player_hand = "Spade,Ace|Spade,10|";
    var player_bet = 20;


    beforeEach(angular.mock.module("Blackjack"));

    beforeEach(angular.mock.inject(function ($httpBackend, $routeParams) {
      backend = $httpBackend;
      //TODO: hardcoded and respond with all attributes
      //
      backend.when("PUT", "/api/v1/players/1/games/1/bet", {player_bet: 20})
        .respond({player_bet: player_bet, player_hand: player_hand, dealer_hand: dealer_hand});

      //TODO: hardcoded
      backend.when("PUT", "/api/v1/players/1/games/1/hit")
        .respond({player_bet: player_bet, player_hand: player_hand, dealer_hand: dealer_hand});

      backend.when("PUT", "/api/v1/players/1/games/1/stand")
        .respond({player_bet: player_bet, player_hand: player_hand, dealer_hand: dealer_hand});
    }));
    

    beforeEach(angular.mock.inject(function($controller, $rootScope, $http) {
        

        mockScope = $rootScope.$new();
        controller = $controller("GameCtrl", {
            $scope: mockScope,
            //TODO is this an acceptable stub? It should be a mock right?
            game: {level: "Beginner", id: 1},
            $http: $http,
            $routeParams: {id: 1}
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
    it("a bet sends a PUT request ", function() {
      mockScope.amount = 20;
      mockScope.bet();
      backend.flush();
      expect(mockScope.game['player_hand']).to.equal(player_hand);
      expect(mockScope.game['dealer_hand']).to.equal(dealer_hand);
    });

    it("a hit sends a PUT request ", function() {
      mockScope.hit();
      backend.flush();
      expect(mockScope.game['player_hand']).to.equal(player_hand);
      expect(mockScope.game['dealer_hand']).to.equal(dealer_hand);
    });

    it("a stand sends a PUT request ", function() {
      mockScope.stand();
      backend.flush();
      expect(mockScope.game['player_hand']).to.equal(player_hand);
      expect(mockScope.game['dealer_hand']).to.equal(dealer_hand);
    });
});
