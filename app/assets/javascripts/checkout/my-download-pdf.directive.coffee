'use strict'

angular.module('mainApp').directive 'myDownloadPdf', [
  'Order'
  '$filter'
  (Order, $filter) ->
    restrict: 'A'
    scope:
      order: '=myDownloadPdf'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'click', ->
        pdfMake.createPdf(Order.toPdf(scope.order)).download('Счет_' + scope.order.stock_number + '_от_' + $filter('date')(scope.order.created_at, 'dMMyyyy') + '.pdf')

]
