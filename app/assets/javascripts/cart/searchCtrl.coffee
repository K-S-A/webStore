'use strict'

angular.module('mainApp').controller 'SearchCtrl', [
  'Product'
  (Product) ->
    vm = this
    vm.search = ''
    vm.searchBy = 'name'
    vm.category = 'all'
    vm.products = Product.found

#    vm.searchProduct = (name) ->
#      Product.search(name)

#    vm.startSearch = ->
#      Product.selected = vm.selected
#      if vm.selected.id
#        $state.go('product', id: vm.selected.id)
#      else
#        Product.fullSearch()

    vm
]
