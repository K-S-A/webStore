'use strict'

angular.module('mainApp').factory 'User', [
  'railsResourceFactory'
  'railsSerializer'
  'localStorageService'
  (railsResourceFactory, railsSerializer, localStorageService) ->
    User = railsResourceFactory(
      url: 'users/{{id}}'
      name: 'user'
      serializer: railsSerializer ->
        @only 'id', 'inn', 'kpp', 'ogrn', 'companyName', 'head', 'initDate')

    User.fetchByInn = (inn) ->
      User.$post('users/fetch_by_inn', inn: inn)

    User
]
