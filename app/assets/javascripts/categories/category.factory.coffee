'use strict'

angular.module('mainApp').factory 'Category', [
  'railsResourceFactory'
  'railsSerializer'
  'Order'
  (railsResourceFactory, railsSerializer, Order) ->
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

        Category.products.length = 0 if replace
        Category.fetchProducts(data, Category.products)

    Category.fetchProducts = (products, target) ->
      products.forEach (product) ->
        product.count = 1
        Order.current.orderItems.forEach (i) ->
          if i.product.id == product.id
            product.count = i.quantity
        target.push(product)

    Category
]
