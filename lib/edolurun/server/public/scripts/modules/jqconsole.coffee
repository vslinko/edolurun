jqconsole = angular.module "jqconsole", []


jqconsole.directive "jqconsole", ->
  scope:
    welcomeString: "@"
    onInput: "&"
  link: (scope, element, attrs) ->
    scope.$watch "welcomeString", ->
      scope.jqconsole = element.jqconsole scope.welcomeString + "\n"

      scope.startPrompt = ->
        scope.jqconsole.Prompt true, (input) ->
          scope.input = input
          scope.$apply """onInput({
            input: input,
            jqconsole: jqconsole,
            callback: startPrompt
          })"""

      scope.startPrompt()
