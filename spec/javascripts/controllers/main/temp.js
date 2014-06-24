//= require application
//= require angular-mocks

// TODO: given all the various possible returned values from api/v1/players/1games/1
// whats the best way to test this controller?
// Dynamic control
// describe("GameCtrl", function(){
//     var mockScope = {};
//     var controller;
//     var backend;

//     beforeEach(angular.mock.module("Blackjack"));

//     beforeEach(angular.mock.inject(function ($httpBackend) {
//       backend = $httpBackend;
//       //FIXME hard code player and game
//       backend.expect("GET", "/api/v1/players/1/games/1").respond(
//         {"level": "Beginner", "bet": 0});


//     }));



//     beforeEach(angular.mock.inject(function($controller, $rootScope, $http, $routeParams) {


//         params = $routeParams;
//         mockScope = $rootScope.$new();
//         controller = $controller("GameCtrl", {
//             $scope: mockScope,
//             $http: $http
//         });
//     }));


//     it("scope exists", function (){
//         expect(mockScope).to.exist;
//     });

//     it("game data exists", function (){
//         expect(mockScope.game).to.exist;
//     });

//     it("game level is Beginner", function (){
//         expect(mockScope.game['level']).to.equal("Beginner");
//     });
    
//     // TODO test bet how?
//     it("Succesfful - is able to bet", function (){
//       mockScope.amount = 20;
//       //FIXME right code for updated?
//       backend.expectPUT('/api/v1/players/1/games/1/bet', {bet: 20}).respond(200,'');
//       mockScope.bet({bet: 20});
//       backend.flush();
//       expect(mockScope.game).to.exist;
//       expect(mockScope.game['bet']).to.exist;
//       expect(mockScope.game['bet']).to.equal(20);

//     });

// });
 
