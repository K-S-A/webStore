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
        @only 'id', 'name', 'imgLink', 'code', 'scu', 'price')
    Product.selected = localStorageService.get('selected') || ''
    Product.all = localStorageService.get('products.selected') || []
    Product.searchText = localStorageService.get('searchText') || ''
    Product.searchBy = localStorageService.get('searchBy') || 'name'
    Product.category = localStorageService.get('category') || 'all'
    Product.found = []
    Product.current = {}
    Product.pagination =
      page: 1
      lastPage: false

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

    Product.findByCategory = (value, type, category, replace) ->
      params =
        value: value
        type: type
        page: Product.pagination.page
      params.category = category if category != 'all'

      Product.query(params).then (data) ->
        Product.pagination.lastPage = true if data.length < 20

        if replace
          angular.copy(data, Product.found)
        else
          data.forEach (product) ->
            Product.found.push(product)

        Product.to_lstorage('searchText', value)
        Product.to_lstorage('searchBy', type)
        Product.to_lstorage('category', category)

    Product.to_lstorage = (key, value) ->
      Product[key] = value
      localStorageService.set(key, value)

    Product
]
