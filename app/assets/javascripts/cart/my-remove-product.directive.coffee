'use strict'

angular.module('mainApp').directive 'myRemoveProduct', [
  'Order'
  (Order) ->
    restrict: 'A'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'click', ->
        Order.removeItem(scope.item)
        scope.$apply ->
          scope.vm.total = Order.total()

]
