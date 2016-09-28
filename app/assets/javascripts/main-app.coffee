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
])
.value('THROTTLE_MILLISECONDS', 1000)
.config([
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
        url: '/products/:id'
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
      .state 'registration',
        url: '/registration'
        templateUrl: 'auth/registration.html'
        controller: 'AuthCtrl as vm'
      .state 'login',
        url: '/login'
        templateUrl: 'auth/login.html'
        controller: 'AuthCtrl as vm'
      .state 'orders',
        url: '/orders'
        templateUrl: 'orders/index.html'
        controller: 'OrderCtrl as vm'
        resolve: getOrders: ['Order', (Order) ->
          Order.getAll()]
      .state 'order',
        url: '/orders/{id:[0-9]+}'
        templateUrl: 'orders/show.html'
        controller: 'OrdersCtrl as vm'
        resolve: getProduct: ['Order', '$stateParams', (Order, $stateParams) ->
          Order.find($stateParams.id)]
      .state 'categories',
        url: '/categories'
        templateUrl: 'categories/index.html'
        controller: 'CategoriesCtrl as vm'
        resolve: getCategories: ['Category', (Category) ->
          Category.getAll()]


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
  'User'
  ($rootScope, $state, Order, User) ->
    $rootScope.$on('$stateChangeError', console.log.bind(console))

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options) ->
      if toState.redirectTo
        event.preventDefault()
        if toState.redirectTo is 'cart.details' && !Order.current.orderItems || !Order.current.orderItems.length
          $state.go('cart.search')
        else
          $state.go(toState.redirectTo, toParams)

    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams, options) ->
      $rootScope.previousState = fromState.name
      Order.current.total = Order.total(Order.current)
      # console.log('$stateChangeSuccess: ' + $rootScope.previousState)

    $rootScope.$on 'devise:login', (event, currentUser) ->
      # console.log('devise:login', $state.current.name)
      User.setUser(currentUser)
      currentState = $state.current.name
      redirectTo = null

      if ['login', 'registration'].indexOf(currentState) >= 0
        redirectTo = ($rootScope.previousState || 'home')

      $state.go(redirectTo) if redirectTo

    $rootScope.$on 'devise:logout', (event, currentUser) ->
      console.log('devise:logout')
      $state.go('home')

])
