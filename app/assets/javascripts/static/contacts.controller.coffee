'use strict'

angular.module('mainApp').controller 'ContactsCtrl', [
  '$uibModal'
  ($uibModal) ->
    vm = this

    vm.openModal = ->
      vm.modalInstance = $uibModal.open(
        templateUrl: 'static/store-img-modal.html'
        size: 'lg'
      )

    vm
]
