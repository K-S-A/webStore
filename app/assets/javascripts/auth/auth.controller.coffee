'use strict'

angular.module('mainApp').controller 'AuthCtrl', [
  '$state'
  'Auth'
  'User'
  'Order'
  ($state, Auth, User, Order) ->
    vm = this
    vm.user = User.currentUser
    vm.order = Order.current

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
