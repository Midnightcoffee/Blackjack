//= require application
//= require angular-mocks

// describe("GameCtrl", function(){
//     var mockScope = {};
//     var controller;
//     var backend;

//     beforeEach(angular.mock.module("Blackjack"));

//     beforeEach(angular.mock.inject(function ($httpBackend) {
//       backend = $httpBackend;
//       backend.expect("GET", "/api/v1/game").respond(
//         {"player_hand": "Spade,10|Spade,Ace"});
//     }));

//     beforeEach(angular.mock.inject(function($controller, $rootScope, $http) {
//         mockScope = $rootScope.$new();
//         controller = $controller("GameCtrl", {
//             $scope: mockScope,
//             $http: $http
//         });
//         backend.flush();
//     }));


//     it("scope exists", function (){
//         expect(mockScope).to.exist;
//     });

//     it("lobby exists", function (){
//         expect(mockScope.game).to.exist;
//     });

//     it("player_hand is spade 10, space ace", function (){
//         expect(mockScope.game['player_hand']).to.equal("Spade,10|Spade,Ace");
//     });


// });
 
