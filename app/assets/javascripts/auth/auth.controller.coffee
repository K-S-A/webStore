'use strict'

angular.module('mainApp').controller 'AuthCtrl', [
  '$state'
  'Auth'
  'User'
  ($state, Auth, User) ->
    vm = this
    vm.user = User.currentUser

    Auth.currentUser().then (user) ->
      User.setUser(user)

    vm.register = ->
      u = angular.copy(vm.user)

      u.company_name = u.companyName
      u.init_date = u.initDate

      delete u.companyName
      delete u.initDate

      Auth.register(u).then (user) ->
        # angular.extend(User.currentUser, user)
        $state.go('home')

    vm
]
