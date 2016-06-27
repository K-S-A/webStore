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

    $urlRouterProvider.otherwise '/'

    $translateProvider
      .preferredLanguage('en')
      .useSanitizeValueStrategy('sanitize')
      .useLocalStorage()
      .useStaticFilesLoader({
        prefix: '/languages/',
        suffix: '.json'
      })

    return

])
