'use strict'

angular.module('mainApp').controller 'CheckoutCtrl', [
  'Product',
  'Order'
  (Product, Order) ->
    vm = this
    vm.order = Order.current
    vm.total = Order.total()

    vm.getTotal = (item) ->
      item.count * item.product.price

    vm
]
