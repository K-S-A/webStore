'use strict'

angular.module('mainApp').directive 'myAddProduct', ->
  restrict: 'A'
  link: (scope, element, attrs, ctrl, transcludeFn) ->
    element.on 'click', ->
      if scope.product.inStock
        scope.vm.addToOrder(scope.product, scope.product.count)
        element.toggleClass('glyphicon-shopping-cart glyphicon-ok')
        setTimeout ->
          element.toggleClass('glyphicon-shopping-cart glyphicon-ok')
        , 3000
