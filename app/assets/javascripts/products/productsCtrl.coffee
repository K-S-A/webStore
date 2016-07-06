'use strict'

angular.module('mainApp').controller 'ProductsCtrl', [
  'Product',
  '$state',
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
      else
        Product.fullSearch(vm.selected)

    vm.to_lstorage = ->
      Product.to_lstorage('selected', vm.selected.name || vm.selected)

    vm
]
