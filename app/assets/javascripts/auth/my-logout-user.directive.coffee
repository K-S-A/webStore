'use strict'

angular.module('mainApp').directive 'myLogoutUser', [
  'Auth'
  '$timeout'
  (Auth, $timeout) ->
    restrict: 'A'
    scope:
      user: '=myLogoutUser'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'click', ->
        Auth.logout().then ->
          scope.user = {}
          scope.user.notice = 'Выход выполнен успешно!'
          rmMessage()
        , (error) ->
          console.log(error)

      rmMessage = ->
        $timeout ->
          scope.user.alert = scope.user.notice = null
        , 5000

]
