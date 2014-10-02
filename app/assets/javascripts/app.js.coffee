@forestapp = angular.module 'forestapp', []

forestapp.filter 'calendar', ->
  (date) ->
    moment(date).calendar() if date

forestapp.directive 'boolClass', ->
  (scope, element, attrs) ->
    scope.$watch attrs.boolClass, (value) -> 
      element.addClass 'glyphicon'
      if value
        element.addClass 'glyphicon-ok'
      else
        element.addClass 'glyphicon-remove'