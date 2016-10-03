'use strict'

angular.module('mainApp').directive 'mySendOrderByEmail', [
  'Order'
  '$filter'
  (Order, $filter) ->
    restrict: 'A'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      linked = angular.element(document).find('#target-email')

      scope.$watch 'vm.email', ->
        element.attr('disabled', linked.is(":invalid") || linked.val().length == 0)

      element.on 'click', ->
        element.attr('disabled', true)
        element.text('Отправка')

        setTimeout ->
          element.text('Отправка.')
        , 400
        setTimeout ->
          element.text('Отправка..')
        , 800
        setTimeout ->
          element.text('Отправка...')
        , 1200

        setTimeout ->
          element.text('Отправлено!')
        , 1600

        setTimeout ->
          element.attr('disabled', false)
          element.text('Отправить на почту')
        , 5000

]
