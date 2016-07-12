'use strict'

angular.module('mainApp').controller 'SearchCtrl', [
  'Product',
  'Order'
  (Product, Order) ->
    vm = this
    vm.searchText = Product.searchText
    vm.searchBy = Product.searchBy
    vm.category = Product.category
    vm.products = Product.found

    vm.findByCategory = ->
      Product.findByCategory(vm.searchText, vm.searchBy, vm.category)

    vm.addToOrder = (product, count) ->
      Order.addItem(product, count)

    vm
]
