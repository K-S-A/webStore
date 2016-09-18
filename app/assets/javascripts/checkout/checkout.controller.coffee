'use strict'

angular.module('mainApp').controller 'CheckoutCtrl', [
  'Product'
  'Order'
  'User'
  'Auth'
  (Product, Order, User, Auth) ->
    vm = this
    vm.order = Order.current
    vm.user = User.currentUser
    vm.total = Order.total(vm.order)
    vm.receiptTitle = Order.buildTitle(vm.order)

    vm.getTotal = (item) ->
      Order.getItemTotal(item)

    vm.createOrder = ->
      Order.create(vm.order)

    vm.companyRequisites = ->
      vm.user.company_name

    vm
]
