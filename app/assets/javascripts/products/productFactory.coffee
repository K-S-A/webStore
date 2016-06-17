'use strict'

angular.module('mainApp').factory 'Product', [
  'railsResourceFactory'
  'railsSerializer'
  (railsResourceFactory, railsSerializer) ->
    Product = railsResourceFactory(
      url: 'products/{{id}}'
      name: 'product'
      serializer: railsSerializer ->
        @only 'id', 'name', 'img_link')

    Product.search = (name) ->
      Product.$get('products/search', name: name)

    Product
]
