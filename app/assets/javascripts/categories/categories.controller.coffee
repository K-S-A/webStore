'use strict'

angular.module('mainApp').controller 'CategoriesCtrl', [
  'Category'
  'Order'
  (Category, Order) ->
    vm = this
    vm.categories = Category.all
    vm.category = Category.current
    vm.products = Category.products
    vm.pagination = Category.pagination
    vm.breadcrumbs = ['Категории']

    vm.resetProducts = (category) ->
      vm.pagination.page = 1
      vm.pagination.lastPage = false
      Category.setCurrent(category)
      Category.getProducts(true)

    vm.addMore = ->
      vm.pagination.page += 1
      Category.getProducts(false)

    vm.toggleSubcategories = (category, collection, breadcrumb) ->
      category.showSub = !category.showSub

      collection.forEach (c) ->
        c.showSub = false if c.id != category.id

      if !category.showSub
        category.subcategories.forEach (cat) ->
          cat.showSub = false
          cat.subcategories.forEach (c) ->
            c.showSub = false
      else
        vm.resetProducts(category)
        vm.setBreadcrumbs(breadcrumb)

    vm.setBreadcrumbs = (breadcrumb) ->
      vm.breadcrumbs.length = 0
      angular.extend(vm.breadcrumbs, breadcrumb)      

    vm.addToOrder = (product, quantity) ->
      Order.addItem(product, quantity)

    vm
]
