'use strict'

angular.module('mainApp').controller 'CheckoutCtrl', [
  'Product'
  'Order'
  'User'
  'Auth'
  '$state'
  (Product, Order, User, Auth, $state) ->
    vm = this
    vm.order = Order.current
    vm.user = User.currentUser
    vm.total = Order.total(vm.order)
    vm.receiptTitle = Order.buildTitle(vm.order)
    vm.receiver = Order.buildReceiver(vm.order)

    vm.getTotal = (item) ->
      Order.getItemTotal(item)

    vm.createOrder = ->
      Order.create(vm.order).then (data) ->
        User.setMessage('Заказ отправлен в обработку!')
        # Order.reset(data)
        $state.go('order', id: data.id)

    vm.companyRequisites = ->
      vm.user.companyName

    vm
]
