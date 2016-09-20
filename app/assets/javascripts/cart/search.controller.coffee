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
    vm.pagination = Product.pagination

    vm.findByCategory = ->
      vm.pagination.page = 1
      vm.pagination.lastPage = false
      Product.findByCategory(vm.searchText, vm.searchBy, vm.category, true)

    vm.addToOrder = (product, quantity) ->
      Order.addItem(product, quantity)

    vm.searchMore = ->
      vm.pagination.page += 1
      Product.findByCategory(vm.searchText, vm.searchBy, vm.category, false)

    vm
]
