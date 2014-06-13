#= require application
#= require angular-mocks



describe "LobbyCtrl", ->
    beforeEach module('Blackjack')

    beforeEach inject(($injector, $controller) ->
        @scope = {}
        @subject = $controller("LobbyCtrl", {$scope: @scope, lobby: {level: "Beginner", total_chips: 100}})
    )

    it "has a lobby property", ->
    expect(@scope.lobby).to.exist


        

