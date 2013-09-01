@AppController = ($scope, angularFire, FIREBASE_URL) ->
  $scope.game = {}
  freshMatrix = [ [{color: 'white'},{color: 'white'},{color: 'white'},{color: 'white'}],
                  [{color: 'white'},{color: 'white'},{color: 'white'},{color: 'white'}],
                  [{color: 'white'},{color: 'white'},{color: 'white'},{color: 'white'}],
                  [{color: 'white'},{color: 'white'},{color: 'white'},{color: 'white'}] ]
  $scope.game.matrix = angular.copy(freshMatrix)
  ref = new Firebase(FIREBASE_URL)
  angularFire ref, $scope, "game"

  $scope.game.turn = "red"
  $scope.myColor   = "white"

  $scope.makeMove = (color,row,column) ->
    if myTurn(color) && ($scope.game.matrix[row][column]['color'] == 'white')
      $scope.game.matrix[row][column]['color'] = color
      $scope.game.turn = otherColor(color)
    else
      alert("Can't do that")

  $scope.clearMatrix = () ->
    $scope.game.matrix = angular.copy(freshMatrix)


  otherColor = (color) ->
    if color == "red"
      newColor = "blue"
    else
      newColor = "red"

    newColor

  myTurn = (color) ->
    if color == $scope.game.turn
      ret = true
    else
      ret = false

    ret



