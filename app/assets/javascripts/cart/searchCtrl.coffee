'use strict'

angular.module('mainApp').controller 'SearchCtrl', [
  'Product',
  'Order'
  (Product, Order) ->
    vm = this
    vm.search = Product.search_text
    vm.searchBy = Product.searchBy
    vm.category = Product.category
    vm.products = Product.found

    vm.findByCategory = ->
      Product.findByCategory(vm.search, vm.searchBy, vm.category)
      Order.to_lstorage('search', vm.search)
      Order.to_lstorage('searchBy', vm.searchBy)
      Order.to_lstorage('category', vm.category)

    vm.addToOrder = (product, count) ->
      Order.addItem(product, count)

    vm
]
