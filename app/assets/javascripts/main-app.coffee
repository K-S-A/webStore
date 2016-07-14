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
  'ngCookies'
  'ngSanitize'
  'pascalprecht.translate'
  'LocalStorageModule'
]).config([
  '$stateProvider'
  '$urlRouterProvider'
  '$translateProvider'
  'localStorageServiceProvider'
  ($stateProvider, $urlRouterProvider, $translateProvider, localStorageServiceProvider) ->
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
          Product.find($stateParams.id)]
      .state 'about',
        url: '/about'
        templateUrl: 'static/about.html'
      .state 'contacts',
        url: '/contacts'
        templateUrl: 'static/contacts.html'
      .state 'cart',
        url: '/cart'
        template: '<ui-view></ui-view>'
        redirectTo: 'cart.details'
      .state 'cart.details',
        url: '/details'
        templateUrl: 'cart/index.html'
        controller: 'CartCtrl as vm'
      .state 'cart.search',
        url: '/search'
        templateUrl: 'cart/search.html'
        controller: 'SearchCtrl as vm'
      .state 'checkout',
        url: '/checkout'
        templateUrl: 'checkout/index.html'
        controller: 'CheckoutCtrl as vm'


    $urlRouterProvider.otherwise '/'

    $translateProvider
      .preferredLanguage('ru')
      .useSanitizeValueStrategy('sanitizeParameters')
      .useLocalStorage()
      .useStaticFilesLoader({
        prefix: '/languages/',
        suffix: '.json'
      })

    localStorageServiceProvider
      .setPrefix('elektromarket')

    return

]).run([
  '$rootScope'
  '$state'
  'Order'
  ($rootScope, $state, Order) ->
    $rootScope.$on("$stateChangeError", console.log.bind(console))

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options) ->
      if toState.redirectTo
        event.preventDefault()
        if toState.redirectTo is 'cart.details' && !Order.current.items.length
          $state.go('cart.search')
        else
          $state.go(toState.redirectTo, toParams)
])
