'use strict'

angular.module('mainApp').directive 'myAddProduct', ->
  restrict: 'A'
  link: (scope, element, attrs, ctrl, transcludeFn) ->
    element.on 'click', ->
      if element.hasClass('glyphicon-plus')
        scope.vm.addToOrder(scope.product, 1)
        element.removeClass('glyphicon-plus')
        element.addClass('glyphicon-ok')
