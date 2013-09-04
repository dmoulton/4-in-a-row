@AppController = ($scope, angularFire, FIREBASE_URL) ->
  $scope.game = {}
  $scope.game.winner = ""
  freshMatrix = [ [{color: 'white'},{color: 'white'},{color: 'white'},{color: 'white'}],
                  [{color: 'white'},{color: 'white'},{color: 'white'},{color: 'white'}],
                  [{color: 'white'},{color: 'white'},{color: 'white'},{color: 'white'}],
                  [{color: 'white'},{color: 'white'},{color: 'white'},{color: 'white'}] ]
  $scope.game.matrix = angular.copy(freshMatrix)
  $scope.newGameCode = ""
  $scope.gameCode = ""

  $scope.newGame = ->
    if $scope.newGameCode == ""
      $scope.gameCode = Math.random().toString(36).substring(7);
    else
      $scope.gameCode = $scope.newGameCode
      $scope.newGameCode = ""
    ref = new Firebase(FIREBASE_URL + $scope.gameCode)
    angularFire ref, $scope, "game"
    $scope.game.turn = "red"
    $scope.myColor   = "white"

  $scope.makeMove = (color,row,column) ->
    if !$scope.hasWinner() && myTurn(color) && ($scope.game.matrix[row][column]['color'] == 'white')
      $scope.game.matrix[row][column]['color'] = color
      $scope.game.turn = otherColor(color)
      declareWinner(color,row,column)
    else
      alert("Can't do that")

  $scope.clearMatrix = () ->
    $scope.game.matrix = angular.copy(freshMatrix)
    $scope.game.winner = ""

  $scope.hasWinner = () ->
    $scope.game.winner != ""

  $scope.inProgress = () ->
    $scope.gameCode != ""

  otherColor = (color) ->
    if color == "red"
      newColor = "blue"
    else
      newColor = "red"

    newColor

  myTurn = (color) ->
    color == $scope.game.turn

  declareWinner = (color,row,column) ->
    if winner(color,row,column)
      $scope.game.winner = color

  winner = (color,row,col) ->
    return true if checkRows(color,row)
    return true if checkCols(color,col)
    return true if checkDiag(color)

  checkRows = (color,row) ->
    c = 0
    while c < 4
      return false if (color != $scope.game.matrix[row][c]['color'])
      c++
    true

  checkCols = (color,col) ->
    r = 0
    while r < 4
      return false if (color != $scope.game.matrix[r][col]['color'])
      r++
    true

  checkDiag = (color) ->
    w = true
    d = 0

    while d < 4
      w = false if color != $scope.game.matrix[d][d]['color']
      d++

    return true if w

    w = true
    c = 3
    r = 0

    while r < 4
      w = false if color != $scope.game.matrix[r][c]['color']
      r++
      c--
    w
