'use strict'

angular.module('mainApp').directive 'myPrintPdf', [
  'Order'
  (Order) ->
    restrict: 'A'
    scope:
      order: '=myPrintPdf'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'click', ->
        pdfMake.createPdf(Order.toPdf(scope.order)).print()

]
