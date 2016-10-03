'use strict'

angular.module('mainApp').directive 'myDisabledOnClick', [
  'Order'
  '$filter'
  (Order, $filter) ->
    restrict: 'A'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'click', ->
        element.attr('disabled', true)
        setTimeout ->
          element.attr('disabled', false)
        , 3000

]
