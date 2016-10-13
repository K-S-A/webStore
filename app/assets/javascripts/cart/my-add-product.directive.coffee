'use strict'

angular.module('mainApp').directive 'myAddProduct', ->
  restrict: 'A'
  link: (scope, element, attrs, ctrl, transcludeFn) ->
    element.on 'click', ->
      if scope.product && scope.product.inStock
        scope.vm.addToOrder(scope.product, scope.product.count)
        element.toggleClass('glyphicon-shopping-cart glyphicon-ok')
        setTimeout ->
          element.toggleClass('glyphicon-shopping-cart glyphicon-ok')
        , 3000
      # fix for product show view
      if scope.vm.current.inStock && scope.vm.current.count
        scope.vm.addToOrder(scope.vm.current, scope.vm.current.count)
        element.toggleClass('glyphicon-shopping-cart glyphicon-ok')
        setTimeout ->
          element.toggleClass('glyphicon-shopping-cart glyphicon-ok')
        , 3000
