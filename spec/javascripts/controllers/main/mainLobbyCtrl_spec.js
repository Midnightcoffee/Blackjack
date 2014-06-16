//= require application
//= require angular-mocks


// coffee!
// describe "LobbyCtrl", ->
//     beforeEach module('Blackjack')

//     beforeEach inject(($injector, $controller, $rootScope) ->
//         @scope = $rootScope.$new()
//         @subject = $controller("LobbyCtrl", {$scope: @scope, lobby: {level: "Beginner", total_chips: 100}})
//     )

//     it "has a lobby property", ->
//         expect(@scope.lobby).to.exist

//     it "has a lobby property", ->
//         v = @scope.lobby
//         expect(v).to.equal(1)



describe("LobbyCtrl", function(){
    var mockScope = {};
    var controller;
    var backend;

    beforeEach(angular.mock.module("Blackjack"));

    beforeEach(angular.mock.inject(function ($httpBackend) {
      backend = $httpBackend;
      backend.expect("GET", "/api/v1/lobby").respond({"level": "Beginner", "total_chips": 100});
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

    it("lobby exists", function (){
        expect(mockScope.lobby).to.exist;
    });

    it("level is Beginner", function (){
        expect(mockScope.lobby['level']).to.equal('Beginner');
    });

    it("total_chips is 100", function (){
        expect(mockScope.lobby['total_chips']).to.equal(100);
    });

});
        

