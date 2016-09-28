'use strict'

angular.module('mainApp').factory 'Category', [
  'railsResourceFactory'
  'railsSerializer'
  (railsResourceFactory, railsSerializer) ->
    Category = railsResourceFactory(
      url: 'categories'
      name: 'category'
      serializer: railsSerializer ->
        @only 'id', 'stockNumber', 'orderItems', 'comment'
        @resource 'products'
    )

    Category.products = []
    Category.current = {}
    Category.pagination =
      page: 1
      lastPage: false

    Category.getAll = ->
      Category.get().then (data) ->
        Category.all = data

    Category.setCurrent = (category) ->
      angular.extend(Category.current, category)

    Category.getProducts = (replace) ->
      params =
        page: Category.pagination.page

      Category.get(Category.current.id, params).then (data) ->
        Category.pagination.lastPage = true if data.length < 20

        if replace
          angular.copy(data, Category.products)
        else
          data.forEach (product) ->
            Category.products.push(product)

    Category
]
