'use strict'

angular.module('mainApp').factory 'User', [
  'railsResourceFactory'
  'railsSerializer'
  'localStorageService'
  (railsResourceFactory, railsSerializer, localStorageService) ->
    User = railsResourceFactory(
      url: 'users/{{id}}'
      name: 'user')
      # serializer: railsSerializer ->
      #   @only 'id', 'name', 'inn')

    User.fetchByInn = (inn) ->
      User.$post('users/fetch_by_inn', inn: inn)

    User
]
