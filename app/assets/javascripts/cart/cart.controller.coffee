'use strict'

angular.module('mainApp').controller 'CartCtrl', [
  'Order'
  (Order) ->
    vm = this
    vm.order = Order.current
    vm.total = Order.total()
    vm.property = null
    vm.reversed = false

    vm.removeItem = (item) ->
      Order.removeItem(item)

    vm.updateOrder = ->
      Order.to_lstorage('order', Order.current)
      vm.total = Order.total()

    vm.sortBy = (property) ->
      if vm.property is property
        if vm.reversed
          vm.property = null
          vm.reversed = false
        else
          vm.reversed = true
      else
        vm.property = property
        vm.reversed = false

    vm.getTotal = (item) ->
      item.count * item.product.price

    vm.isOrdered = (property, reversed) ->
      vm.property is property && vm.reversed is reversed

    vm
]
