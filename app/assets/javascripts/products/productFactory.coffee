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

    Product.selected = ''
    Product.all = []
    Product.found = []
    Product.current = {}

    Product.search = (name) ->
      Product.$get('products/search', name: name)

    Product.fullSearch = ->
      if Product.selected.length
        Product.query(name: Product.selected).then (data) ->
          angular.copy(data, Product.all)
      else
        angular.copy([], Product.all)

    Product.find = (id) ->
      Product.get(id: id).then (data) ->
        Product.current = data

    Product
]
