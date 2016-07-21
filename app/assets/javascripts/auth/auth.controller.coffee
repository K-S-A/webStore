'use strict'

angular.module('mainApp').controller 'AuthCtrl', [
  '$state'
  'Auth'
  'User'
  ($state, Auth, User) ->
    vm = this

    Auth.currentUser().then (user) ->
      vm.user = user      
    , (error) ->
      vm.user = {}

    # vm.login = ->
    #   Auth.login(vm.user)#.then (user) ->
    #     vm.user = user
    #     vm.signedIn = true
    #     console.log(user)
    #     $state.go 'tournaments'
    #   , (error) ->
    #     console.log(error)
    #     auths.showAlert('Wrong user credentials. Check e-mail/password and try again.')
    #   return

    vm.register = ->
      User.fetchByInn(vm.user.inn).then (user) ->
        vm.user = user
        # console.log(user)
      , (error) ->
        console.log(error)
    #   Auth.register(vm.user).then (user) ->
    #     auths.setUser(user, 'You are registered successfully.')
    #     $state.go 'tournaments'
    #   return

    # vm.logout = ->
    #   Auth.logout().then ->
    #     vm.user = {}
    #     auths.setUser({}, 'You are signed out now.')
    #     $state.reload()
    #   return

    # vm.update = (user) ->
    #   auths.updateUser(user)

    vm
]
