'use strict'

angular.module('mainApp').controller 'CartCtrl', [
  'Order'
  (Order) ->
    vm = this
    vm.order = Order.current

    vm.removeItem = (item) ->
      Order.removeItem(item)

    vm.updateOrder = ->
      Order.to_lstorage('order', Order.current)
    #console.log(vm.order)
    vm
]
