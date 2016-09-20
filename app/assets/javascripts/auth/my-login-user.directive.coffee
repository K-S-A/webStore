'use strict'

angular.module('mainApp').directive 'myLoginUser', [
  'Auth'
  '$timeout'
  '$state'
  '$rootScope'
  (Auth, $timeout, $state, $rootScope) ->
    restrict: 'A'
    scope:
      user: '=myLoginUser'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'submit', ->
        Auth.login(scope.user)
        # .then ->
          # scope.user = user
          # scope.user.notice = 'Вход выполнен успешно!'
          # rmMessage()
        # , (error) ->
        #   console.log(error)

]
