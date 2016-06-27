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
      Product.selected = vm.selected
      if vm.selected.id
        $state.go('product', id: vm.selected.id)
      else if vm.selected.length
        Product.full_search()
      else
        angular.copy([], Product.all)

    vm
]
