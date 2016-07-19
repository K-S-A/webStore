'use strict'

angular.module('mainApp').directive 'myLoginUser', [
  'Auth'
  '$timeout'
  (Auth, $timeout) ->
    restrict: 'A'
    scope:
      user: '=myLoginUser'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'submit', ->
        Auth.login(scope.user).then (user) ->
          scope.user = user
          scope.user.notice = 'Вход выполнен успешно!'
          rmMessage()
        , (error) ->
          console.log(error)

      rmMessage = ->
        $timeout ->
          scope.user.alert = scope.user.notice = null
        , 5000

]
