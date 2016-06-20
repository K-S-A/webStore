'use strict'

angular.module('mainApp').controller 'ProductsCtrl', [
  'Product',
  '$state'
  (Product, $state) ->
    vm = this
    vm.selected = Product.selected
    vm.current = Product.current
    vm.products = Product.all

    vm.searchProduct = (name) ->
      Product.search(name)

    vm.startSearch = ->
      if vm.selected.id
        Product.selected = vm.selected
        $state.go('product', id: vm.selected.id)
      else
        Product.selected = vm.selected
        $state.go('products')

    vm
]
