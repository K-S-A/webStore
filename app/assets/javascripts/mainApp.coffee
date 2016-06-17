'use strict'

angular.module('mainApp', [
  'ui.router'
  'ui.bootstrap'
  'ui.sortable'
  'templates'
  'Devise'
  'xeditable'
  'infinite-scroll'
  'rails'
]).config([
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: 'products/home.html'
        controller: 'ProductsCtrl as vm'
      .state 'product',
        url: '/products/{id:[0-9]+}'
        templateUrl: 'products/show.html'
        controller: 'ProductsCtrl as vm'
        resolve: getProduct: ['Product', '$stateParams', (Product, $stateParams) ->
          Product.get(id: $stateParams.id).then (data) ->
            Product.current = data]
      .state 'products',
        url: '/products'
        templateUrl: 'products/index.html'
        controller: 'ProductsCtrl as vm'
        resolve: getProduct: ['Product', (Product) ->
          Product.query(name: Product.selected).then (data) ->
            Product.all = data]
      .state 'about',
        url: '/about'
        templateUrl: 'static/about.html'
      .state 'contacts',
        url: '/contacts'
        templateUrl: 'static/contacts.html'

    $urlRouterProvider.otherwise '/'
    return

])
