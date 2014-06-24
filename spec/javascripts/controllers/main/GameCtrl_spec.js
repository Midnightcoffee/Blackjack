//= require application
//= require angular-mocks

describe('GameCtrl', function() {
    var $httpBackend, $rootScope, createController;

    beforeEach(angular.mock.module("Blackjack"));

    beforeEach(inject(function($injector) {
      // Set up the mock http service responses
      $httpBackend = $injector.get('$httpBackend');
      // backend definition common for all tests
      // $httpBackend.when('GET', '/api/v1/players/1/games/1')
      // .respond({level: 'Beginner'});

      // Get hold of a scope (i.e. the root scope)
      $rootScope = $injector.get('$rootScope');
      // The $controller service is used to create instances of controllers
      var $controller = $injector.get('$controller');

      createController = function() {

        return $controller('GameCtrl', {'$scope' : $rootScope });
      };
    }));


    afterEach(function() {
      $httpBackend.verifyNoOutstandingExpectation();
      $httpBackend.verifyNoOutstandingRequest();
    });


    // it('should fetch game state', function() {
    //   $httpBackend.expectGET('/api/v1/players/1/games/1');
    //   var controller = createController();
    //   $httpBackend.flush();
    // });


    it('should send bet to server', function() {
      var controller = createController();
      $httpBackend.whenGET('/api/v1/players/1/games/1').
        respond(200, {level: "Beinnger"});
      $httpBackend.flush();

      // now you don’t care about the authentication, but
      // the controller will still send the request and
      // $httpBackend will respond without you having to
      // specify the expectation and response for this request

      //FIXME check status codes
      $httpBackend.whenPUT('/api/v1/players/1/games/1/bet', {bet: 10}).
        respond(200, {bet: 10});

      $httpBackend.whenGET('/api/v1/players/1/games/1').
        respond(200, {player_hand: "Ace"});
      


      $rootScope.amount = 10;
      $rootScope.bet();
      $httpBackend.flush();
      expect($rootScope.game).to.exist; 
      // expect($rootScope.game['player_hand']).to.exist; 
      // expect($rootScope.game['player_hand']).to.equal("Ace"); 


      // expect($rootScope.status).toBe('');
    });


    // it('should send auth header', function() {
    //   var controller = createController();
    //   $httpBackend.flush();

    //   $httpBackend.expectPOST('/add-msg.py', undefined, function(headers) {
    //     // check if the header was send, if it wasn't the expectation won't
    //     // match the request and the test will fail
    //     return headers['Authorization'] == 'xxx';
    //   }).respond(201, '');

    //   $rootScope.saveMessage('whatever');
    //   $httpBackend.flush();
    // });
});

