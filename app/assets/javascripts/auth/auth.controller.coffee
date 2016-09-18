'use strict'

angular.module('mainApp').controller 'AuthCtrl', [
  '$state'
  'Auth'
  'User'
  ($state, Auth, User) ->
    vm = this
    vm.user = User.currentUser

    Auth.currentUser()
    # .then (user) ->
    #   angular.extend(User.currentUser, user)

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
      u = angular.copy(vm.user)

      u.company_name = u.companyName
      u.init_date = u.initDate

      delete u.companyName
      delete u.initDate

      Auth.register(u).then (user) ->
        # angular.extend(User.currentUser, user)
        $state.go('home')

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
