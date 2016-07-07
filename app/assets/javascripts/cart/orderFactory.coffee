'use strict'

angular.module('mainApp').factory 'Order', [
  'railsResourceFactory'
  'railsSerializer'
  'localStorageService'
  (railsResourceFactory, railsSerializer, localStorageService) ->
    Order = railsResourceFactory(
      url: 'orders/{{id}}'
      name: 'order'
      serializer: railsSerializer ->
        @only 'id')

    Order.current = localStorageService.get('order') || {items: []}

    Order.addItem = (product, count) ->
      Order.current.items ||= []
      ids = Order.current.items.map (item) ->
        item.product.id
      index = ids.indexOf(product.id)

      if index == -1
        Order.current.items.push(product: product, count: count)
      else
        Order.current.items[index].count += 1

      Order.to_lstorage('order', Order.current)

    Order.removeItem = (item) ->
      Order.current.items.forEach (el, i) ->
        if el.product.id is item.product.id
          Order.current.items.splice(i, 1)
          Order.to_lstorage('order', Order.current)

    Order.to_lstorage = (key, value) ->
      localStorageService.set(key, value)

    Order.total = ->
      Order.current.items.reduce (a, e) ->
        a += e.count * e.product.price
      , 0

    Order
]
