'use strict'

angular.module('mainApp').controller 'OrderCtrl', [
  'Order'
  (Order) ->
    vm = this
    vm.property = null
    vm.reversed = false
    vm.orders = Order.all
    vm.order =
      stockNumber: 'adfsds1'
      orderItems: [
        {productId: 1, quantity: 2, price: 123}
      ]
    vm.create = ->
      Order.create(vm.order)

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

    vm.isOrdered = (property, reversed) ->
      vm.property is property && vm.reversed is reversed

    vm.getTotal = (item) ->
      Order.getItemTotal(item)

    vm.getOrderTotal = (order) ->
      Order.total(order)
    # vm.order = Order.current
    # vm.total = Order.total(vm.order)
    # vm.property = null
    # vm.reversed = false

    # vm.removeItem = (item) ->
    #   Order.removeItem(item)

    # vm.updateOrder = ->
    #   Order.to_lstorage('order', Order.current)
    #   vm.total = Order.total(vm.order)

    # vm.sortBy = (property) ->
    #   if vm.property is property
    #     if vm.reversed
    #       vm.property = null
    #       vm.reversed = false
    #     else
    #       vm.reversed = true
    #   else
    #     vm.property = property
    #     vm.reversed = false

    # vm.getTotal = (item) ->
    #   Order.getItemTotal(item)

    # vm.isOrdered = (property, reversed) ->
    #   vm.property is property && vm.reversed is reversed

    vm
]
