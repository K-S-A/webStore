'use strict'

angular.module('mainApp').factory 'User', [
  'railsResourceFactory'
  'railsSerializer'
  'localStorageService'
  '$timeout'
  'Order'
  (railsResourceFactory, railsSerializer, localStorageService, $timeout, Order) ->
    User = railsResourceFactory(
      url: 'users/{{id}}'
      name: 'user'
      serializer: railsSerializer ->
        @only 'id', 'inn', 'kpp', 'ogrn', 'companyName', 'head', 'initDate')

    User.currentUser = {}

    User.fetchByInn = (inn) ->
      User.$post('users/fetch_by_inn', inn: inn)

    User.setUser = (user) ->
      User.syncUser(user)
      user.notice = 'Вход выполнен успешно!'
      User.rmMessage()

    User.logoutUser = ->
      user =
        id: null
        password: null
        inn: null
        notice: 'Выход выполнен успешно!'

      User.syncUser(user)
      User.rmMessage()
    
    User.setMessage = (message) ->
      User.currentUser.notice = message
      User.rmMessage()

    User.syncUser = (user) ->
      angular.extend(User.currentUser, user)
      Order.current.user ||= {}
      angular.extend(user, Order.current.user)
      Order.to_lstorage('order', Order.current)

    User.rmMessage = ->
      $timeout ->
        User.currentUser.alert = User.currentUser.notice = null
      , 5000

    User
]
