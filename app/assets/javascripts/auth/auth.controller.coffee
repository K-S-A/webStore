'use strict'

angular.module('mainApp').controller 'AuthCtrl', [
  '$state'
  'Auth'
  ($state, Auth) ->
    vm = this

    Auth.currentUser().then (user) ->
      vm.user = user      
    , (error) ->
      vm.user = {}

    # vm.login = ->
      # Auth.login(vm.user)#.then (user) ->
        # vm.user = user
        # vm.signedIn = true
        # console.log(user)
      #   $state.go 'tournaments'
      # , (error) ->
      #   console.log(error)
        # auths.showAlert('Wrong user credentials. Check e-mail/password and try again.')
      # return

    # vm.register = ->
    #   Auth.register(vm.user).then (user) ->
    #     auths.setUser(user, 'You are registered successfully.')
    #     $state.go 'tournaments'
    #   return

    # vm.logout = ->
    #   Auth.logout().then ->
    #     vm.user = {}
      #   auths.setUser({}, 'You are signed out now.')
      #   $state.reload()
      # return

    # vm.update = (user) ->
    #   auths.updateUser(user)

    vm
]
