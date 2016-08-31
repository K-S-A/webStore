'use strict'

angular.module('mainApp').factory 'OrderItem', [
  'railsResourceFactory'
  'railsSerializer'
  'localStorageService'
  (railsResourceFactory, railsSerializer, localStorageService) ->
    OrderItem = railsResourceFactory(
      url: 'order_items/{{id}}'
      name: 'orderItem'
      serializer: railsSerializer ->
        @only 'id', 'price', 'productId', 'quantity'
        @resource 'product', 'Product'
    )

    OrderItem
]
