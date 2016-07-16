'use strict'

angular.module('mainApp').controller 'CheckoutCtrl', [
  'Product',
  'Order'
  (Product, Order) ->
    vm = this
    vm.order = Order.current
    vm.total = Order.total(vm.order)
    vm.receiptTitle = Order.buildTitle(vm.order)

    vm.getTotal = (item) ->
      Order.getItemTotal(item)

    vm
]
