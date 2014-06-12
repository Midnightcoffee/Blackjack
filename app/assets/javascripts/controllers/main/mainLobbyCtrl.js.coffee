Blackjack.controller "LobbyCtrl", $(scope, Lobby) ->
    $scope.getLobby = () ->
        $scope.lobby = Lobby.get()

