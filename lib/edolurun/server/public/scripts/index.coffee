edolurun = angular.module "edolurun", [
  "jqconsole"
]


edolurun.controller "EdolurunCtrl", ($scope) ->
  $scope.consoleInput = (input, jqconsole, callback) ->
    $.post "/commander", {input: input}, (data) ->
      if data
        jqconsole.Write data + "\n"

      callback()
