'use strict'

angular.module('mainApp').factory 'Product', [
  'railsResourceFactory'
  'railsSerializer'
  'localStorageService'
  (railsResourceFactory, railsSerializer, localStorageService) ->
    Product = railsResourceFactory(
      url: 'products/{{id}}'
      name: 'product'
      serializer: railsSerializer ->
        @only 'id', 'name', 'img_link')

    Product.selected = localStorageService.get('selected') || ''
    Product.all = localStorageService.get('products.selected') || []
    Product.found = []
    Product.current = {}

    Product.search = (name) ->
      Product.$get('products/search', value: name)

    Product.fullSearch = ->
      if Product.selected.length
        Product.query(value: Product.selected).then (data) ->
          angular.copy(data, Product.all)
      else
        angular.copy([], Product.all)

    Product.find = (id) ->
      Product.get(id: id).then (data) ->
        Product.current = data

    Product.findByCategory = (value, type, category) ->
      params =
        value: value
        type: type
      params.category = category if category != 'all'

      Product.query(params).then (data) ->
        angular.copy(data, Product.found)

    Product
]
