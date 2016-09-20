'use strict'

angular.module('mainApp').directive 'myLogoutUser', [
  'Auth'
  'User'
  (Auth, User) ->
    restrict: 'A'
    scope:
      user: '=myLogoutUser'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'click', ->
        Auth.logout().then ->
          User.logoutUser()

]
