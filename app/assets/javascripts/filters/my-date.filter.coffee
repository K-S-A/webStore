'use strict'

angular.module('mainApp')
.filter 'myDate', [
  '$filter'
  ($filter) ->
    (dateString, pattern) ->
      date = new Date(dateString)
      $filter('date')(date, pattern)
]
