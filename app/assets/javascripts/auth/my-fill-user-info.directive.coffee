'use strict'

angular.module('mainApp').directive 'myFillUserInfo', [
  'User'
  '$timeout'
  (User, $timeout) ->
    restrict: 'A'
    scope:
      user: '=myFillUserInfo'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'submit', ->
        User.fetchByInn(scope.user.inn).then (data) ->
          scope.user = data
          element.hide()
          angular.element('#register').show()
        , (error) ->
          console.log(error)

]
