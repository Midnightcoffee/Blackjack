#= require_self
#= require_tree ./services/global
#= require_tree ./services/main
#= require_tree ./filters/global
#= require_tree ./filters/main
#= require_tree ./controllers/global
#= require_tree ./controllers/main
#= require_tree ./directives/global
#= require_tree ./directives/main
#= require_tree ./models/

# coffee

Blackjack = angular.module("Blackjack", ["ngRoute", "ngResource"])
.config([
    "$routeProvider"
    ($routeProvider) ->
        $routeProvider.when("/",
        controller: "LobbyCtrl"
        ).otherwise redirectTo: "/"
    ])

# Blackjack = angular
#     .module("Blackjack", ["ngRoute", "ngResource"])
#     .config(['$routeProvider', function($routeProvider) {
#         $routeProvider.when('/', {
#             controller: 'HomeCtrl'
#         }).when('/:status', {
#             controller: 'HomeCtrl',
#         }).otherwise({
#             redirectTo: '/'
#         });
#     }]);



