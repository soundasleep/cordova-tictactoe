(function() {
  var AppPrototype;

  AppPrototype = function() {
    return {
      state: [],
      turn: 0,

      /*
        * Initialise the game
       */
      init: function() {
        $(".start-again").attr('disabled', true);
        this.state = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
        this.turn = this._rand(2);
        if (this.turn === 1) {
          return this._play();
        }
      },

      /*
        * Render the game state
       */
      render: function() {
        $(".board .row .cell").removeClass("x o");
        return this.state.forEach((function(_this) {
          return function(row, y) {
            return row.forEach(function(cell, x) {
              var cssClass;
              switch (cell) {
                case 1:
                  cssClass = "x";
                  break;
                case 2:
                  cssClass = "o";
                  break;
                default:
                  cssClass = "";
              }
              return _this._cellFor(x, y).addClass(cssClass);
            });
          };
        })(this));
      },

      /*
        * Set up UI click handlers
       */
      registerClicks: function() {
        this.state.forEach((function(_this) {
          return function(row, y) {
            return row.forEach(function(cell, x) {
              return _this._cellFor(x, y).click(function(e) {
                if (_this.turn === 0 && _this.state[y][x] === 0) {
                  _this.state[y][x] = 1;
                  _this.turn = 1;
                  _this.render();
                  _this._checkWin();
                  return _this._play();
                }
              });
            });
          };
        })(this));
        return $(".start-again").click((function(_this) {
          return function() {
            _this.init();
            return _this.render();
          };
        })(this));
      },
      _cellFor: function(x, y) {
        return $(".board .row:nth-child(" + (y + 1) + ") .cell:nth-child(" + (x + 1) + ")");
      },

      /*
        * Do an AI turn
        * Just select anywhere; in the future, we can add AI
       */
      _play: function() {
        var x, y, _results;
        _results = [];
        while (!this._gameOver()) {
          x = this._rand(3);
          y = this._rand(3);
          if (this.state[y][x] === 0) {
            this.state[y][x] = 2;
            this.turn = 0;
            this.render();
            this._checkWin();
            break;
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      },

      /*
        * Get a random integer between [0..n)
       */
      _rand: function(n) {
        return Math.floor(Math.random() * n);
      },

      /*
        * Check the win state, and display an alert if someone has won
       */
      _checkWin: function() {
        var player;
        player = this._hasWin();
        if (player > 0 || this._gameOver()) {
          $(".start-again").attr('disabled', false);
          if (player === 1) {
            return alert("You won!");
          } else if (player === 2) {
            return alert("The computer won");
          }
        }
      },

      /*
        * Has a player won?
        * @return 1 or 2 if player 1 or 2 won, or -1 if nobody has won
       */
      _hasWin: function() {
        var col, diag, player, rev, row, x, y, _i, _j, _k, _l, _m, _n, _o;
        for (player = _i = 1; _i <= 2; player = ++_i) {
          for (y = _j = 0; _j < 3; y = ++_j) {
            row = true;
            for (x = _k = 0; _k < 3; x = ++_k) {
              row = row && this.state[y][x] === player;
            }
            if (row) {
              return player;
            }
          }
          for (x = _l = 0; _l < 3; x = ++_l) {
            col = true;
            for (y = _m = 0; _m < 3; y = ++_m) {
              col = col && this.state[y][x] === player;
            }
            if (col) {
              return player;
            }
          }
          diag = true;
          for (x = _n = 0; _n < 3; x = ++_n) {
            diag = diag && this.state[x][x] === player;
          }
          if (diag) {
            return player;
          }
          rev = true;
          for (x = _o = 0; _o < 3; x = ++_o) {
            rev = rev && this.state[this.state.length - x - 1][x] === player;
          }
          if (rev) {
            return player;
          }
        }
        return -1;
      },

      /*
        * Is the game over, i.e. no more moves can be made?
       */
      _gameOver: function() {
        var cell, row, _i, _j, _len, _len1, _ref;
        if (this._hasWin() >= 0) {
          return true;
        }
        _ref = this.state;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          row = _ref[_i];
          for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
            cell = row[_j];
            if (cell === 0) {
              return false;
            }
          }
        }
        return true;
      },

      /*
        * Ready initialiser
       */
      ready: function() {
        this.init();
        this.registerClicks();
        return this.render();
      }
    };
  };

  window.App = new AppPrototype();

  $(document).ready(function() {
    return App.ready();
  });

}).call(this);
