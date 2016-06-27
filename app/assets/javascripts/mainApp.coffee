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
]).config([
  '$stateProvider'
  '$urlRouterProvider'
  '$translateProvider'
  ($stateProvider, $urlRouterProvider, $translateProvider) ->
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
        controller: 'ProductsCtrl as vm'
      .state 'cart.search',
        url: '/search'
        templateUrl: 'products/search.html'
        controller: 'ProductsCtrl as vm'


    $urlRouterProvider.otherwise '/'

    $translateProvider
      .preferredLanguage('en')
      .useSanitizeValueStrategy('sanitizeParameters')
      .useLocalStorage()
      .useStaticFilesLoader({
        prefix: '/languages/',
        suffix: '.json'
      })

    return

]).run([
  '$rootScope'
  '$state'
  ($rootScope, $state) ->
    $rootScope.$on("$stateChangeError", console.log.bind(console))

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options) ->
      if toState.redirectTo
        event.preventDefault()
        $state.go(toState.redirectTo, toParams)
])
