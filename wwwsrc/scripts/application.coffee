AppPrototype = ->
  state: []
  turn: 0

  ###
   # Initialise the game
  ###
  init: ->
    $(".start-again").attr('disabled', true)

    @state = [
      [0,0,0],
      [0,0,0],
      [0,0,0],
    ]
    @turn = @_rand(2)
    @_play() if @turn == 1

  ###
   # Render the game state
  ###
  render: ->
    $(".board .row .cell").removeClass("x o")

    @state.forEach (row, y) =>
      row.forEach (cell, x) =>
        switch cell
          when 1
            cssClass = "x"
          when 2
            cssClass = "o"
          else
            cssClass = ""

        @_cellFor(x, y).addClass(cssClass)

  ###
   # Set up UI click handlers
  ###
  registerClicks: ->
    @state.forEach (row, y) =>
      row.forEach (cell, x) =>
        @_cellFor(x, y).click (e) =>
          if @turn == 0 and @state[y][x] == 0
            @state[y][x] = 1
            @turn = 1
            @render()
            @_checkWin()
            @_play()

    $(".start-again").click =>
      @init()
      @render()

  _cellFor: (x, y) ->
    $(".board .row:nth-child(#{y+1}) .cell:nth-child(#{x+1})")

  ###
   # Do an AI turn
   # Just select anywhere; in the future, we can add AI
  ###
  _play: ->
    while not @_gameOver()
      x = @_rand(3)
      y = @_rand(3)
      if @state[y][x] == 0
        @state[y][x] = 2
        @turn = 0
        @render()
        @_checkWin()
        break

  ###
   # Get a random integer between [0..n)
  ###
  _rand: (n) ->
    Math.floor(Math.random() * n)

  ###
   # Check the win state, and display an alert if someone has won
  ###
  _checkWin: ->
    player = @_hasWin()
    if player > 0 or @_gameOver()
      $(".start-again").attr('disabled', false)
      if player == 1
        alert "You won!"
      else if player == 2
        alert "The computer won"

  ###
   # Has a player won?
   # @return 1 or 2 if player 1 or 2 won, or -1 if nobody has won
  ###
  _hasWin: ->
    # are there any rows/columns matched?
    for player in [1..2]
      for y in [0...3]
        row = true
        for x in [0...3]
          row = row and @state[y][x] == player
        return player if row

      for x in [0...3]
        col = true
        for y in [0...3]
          col = col and @state[y][x] == player
        return player if col

      # diagonal
      diag = true
      for x in [0...3]
        diag = diag and @state[x][x] == player
      return player if diag

      # reverse diag
      rev = true
      for x in [0...3]
        rev = rev and @state[@state.length-x-1][x] == player
      return player if rev

    return -1

  ###
   # Is the game over, i.e. no more moves can be made?
  ###
  _gameOver: ->
    # has the game won?
    return true if @_hasWin() >= 0

    # is the board filled up?
    for row in @state
      for cell in row
        return false if cell == 0

    return true

  ###
   # Ready initialiser
  ###
  ready: ->
    @init()
    @registerClicks()
    @render()

window.App = new AppPrototype()

$(document).ready ->
  App.ready()
