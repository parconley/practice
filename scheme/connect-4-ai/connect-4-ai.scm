; Name: Parker Conley
; Date: 04.01.23
; Description: This program plays the game Connect 4.

#lang scheme

; ------------------  HELPER FUNCTIONS  ------------------

; ------------------  List Manipulation  ------------------

; This function makes a list with a given amount (n) of an atom. 
(define (PRCMakeList N Atom)
  (if (= N 0)
      '()
      (cons Atom (PRCMakeList (- N 1) Atom))))

; This function returns the cell at the specified row and column of the matrix.
(define (PRCGetCell Matrix Row Col)
  (if (null? Matrix)
      #f
      (if (= Row 1)
          (PRCGetCellInRow (car Matrix) Col)
          (PRCGetCell (cdr Matrix) (- Row 1) Col))))

; This function is called by "getCell" to get a cell in a row of a matrix.
(define (PRCGetCellInRow Matrix Col)
  (if (null? Matrix)
      #f
      (if (= Col 1)
          (car Matrix)
          (PRCGetCellInRow (cdr Matrix) (- Col 1)))))

; This function sets the cell at the specified row and column of the matrix to
; the specified item.
(define (PRCSetCell Matrix Row Col Item)
  (if (null? Matrix)
      '()
      (if (= Row 1)
          (cons (PRCSetCellInRow (car Matrix) Col Item) (PRCSetCell (cdr Matrix) (- Row 1) Col Item))
          (cons (car Matrix) (PRCSetCell (cdr Matrix) (- Row 1) Col Item)))))

; This function is called by "setCell" to set a cell in a row of a matrix.
(define (PRCSetCellInRow Matrix Col Item)
  (if (null? Matrix)
      '()
      (if (= Col 1)
          (cons Item (PRCSetCellInRow (cdr Matrix) (- Col 1) Item))
          (cons (car Matrix) (PRCSetCellInRow (cdr Matrix) (- Col 1) Item)))))

; ------------------  Game Functions  ------------------

; This function intializes the PRCGame variable with a blank board.
(define (PRCInitBoard)
  (PRCMakeList 6 (PRCMakeList 7 0)))

; This function retursn the piece of the player whose turn it is.
(define (PRCShowPlayer)
  (if (= (car PRCGame) 1)
      (display "Next Move: X")
      (display "Next Move: O")))

; This function returns the number of the player whose turn it is.
(define (PRCNextPlayer)
  (if (= (car PRCGame) 1) 2 1))

; This function takes a board and a token and adds the token to the board.
(define (PRCPlaceToken Board Token Col Row)
  (if (null? Board)
      '()
      (if (= Col 1)
          (PRCSetCell Board Row Col Token)
          (cons (car Board) (PRCPlaceToken (cdr Board) Token (- Col 1) Row)))))

; This function takes a board and a column and returns the row number of the
; lowest empty cell in the column.
(define (PRCGetEmptyRow Board Col)
  (if (null? Board)
      1
      (if (= (PRCGetCell Board 1 Col) 0)
          (PRCGetEmptyRow (cdr Board) Col)
          (+ 1 (PRCGetEmptyRow (cdr Board) Col)))))

; This function takes a board and a column and returns the row number of the
; top token in the column.
(define (PRCGetTopRow Board Col)
  (if (null? Board)
      0
      (if (= (PRCGetCell Board 1 Col) 0)
          (PRCGetTopRow (cdr Board) Col)
          (+ 1 (PRCGetTopRow (cdr Board) Col)))))

; This function takes a list, token, and column.
; It ads the player's token to the specified column in the list.
(define (PRCMove Board Token Col)
  (PRCSetCell Board (PRCGetEmptyRow Board Col) Col Token))

; ------------------  Game Play  ------------------

; This function takes a random number and returns the number if it is a legal
; move. Otherwise, it calls itself again with a new random number.
(define (PRCRandomMove Number)
  (if (PRCLegalMoveP Number)
      Number
      (PRCRandomMove (+ 1 (random 7)))))

; This function chooses a random legal move.
(define (PRCChooseMove)
  (PRCRandomMove (+ 1 (random 7))))

; ------------------  Display Functions  ------------------

; This function takes a cell and displays it as a period, X, or O.
(define (PRCShowCell Value)
  (cond ((= Value 0) (display "."))
        ((= Value 1) (display "X"))
        ((= Value 2) (display "O"))
        (else (display "?"))))

; This function takes a row and displays it.
(define (PRCShowRow Row)
  (if (null? Row)
      '()
      (cons (PRCShowCell (car Row))
            (cons (display " ") (PRCShowRow (cdr Row))))))

; This function uses recursion to display the board. It reverses the order of
; the rows so that the board is displayed correctly.
(define (PRCShowBoardHelper Board Counter)
  (if (null? Board)
      '()
      (if (= Counter 1)
          (cons (PRCShowRow (car Board))
                (cons (newline) '()))
          (cons (PRCShowBoardHelper (cdr Board) (- Counter 1))
                (cons (PRCShowRow (car Board))
                      (cons (newline) '()))))))

; This function takes a board and displays it.
(define (PRCShowBoard Board)
  (PRCShowBoardHelper Board 6))

; ------------------  Winning Functions  ------------------

; Compare two cells to see if they are equal and not zero.
(define (PRCNotZero? x)
  (not (= x 0)))

; This function takes the most recent move and tests to see
; if it is a winning move horizontally east.
(define (PRCWinPRowE Board Row Col)
  (cond
    ((null? Board) #f) 
    ((> Col 4) #f) ; If the column is less than 4, there are not enough cells to the right to win.
    ((and (and (= (PRCGetCell Board Row Col) (PRCGetCell Board Row (+ Col 1))) (PRCNotZero? (PRCGetCell Board Row (+ Col 1))))
          (and (= (PRCGetCell Board Row (+ Col 1)) (PRCGetCell Board Row (+ Col 2))) (PRCNotZero? (PRCGetCell Board Row (+ Col 2))))
          (and (= (PRCGetCell Board Row (+ Col 2)) (PRCGetCell Board Row (+ Col 3))) (PRCNotZero? (PRCGetCell Board Row (+ Col 3)))))
     #t)
    (#t (PRCWinPRowE Board Row (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move horizontally west.
(define (PRCWinPRowW Board Row Col)
  (cond
    ((null? Board) #f)
    ((< Col 4) #f) ; If the column is greater than 4, there are not enough cells to the left to win.
    ((and (and (= (PRCGetCell Board Row Col) (PRCGetCell Board Row (- Col 1))) (PRCNotZero? (PRCGetCell Board Row (- Col 1))))
          (and (= (PRCGetCell Board Row (- Col 1)) (PRCGetCell Board Row (- Col 2))) (PRCNotZero? (PRCGetCell Board Row (- Col 2))))
          (and (= (PRCGetCell Board Row (- Col 2)) (PRCGetCell Board Row (- Col 3))) (PRCNotZero? (PRCGetCell Board Row (- Col 3)))))
     #t)
    (#t (PRCWinPRowW Board Row (- Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move with two tokens on its right and one token on its left.
(define (PRCWinPRowRight2Left1 Board Row Col)
  (cond
    ((null? Board) #f)
    ((< Col 2) #f) ; If the column is less than 2, there are not enough cells to the left to win.
    ((> Col 5) #f) ; If the column is greater than 5, there are not enough cells to the right to win.
    ((and (and (= (PRCGetCell Board Row Col) (PRCGetCell Board Row (- Col 1))) (PRCNotZero? (PRCGetCell Board Row (- Col 1))))
          (and (= (PRCGetCell Board Row Col) (PRCGetCell Board Row (+ Col 1))) (PRCNotZero? (PRCGetCell Board Row (+ Col 1))))
          (and (= (PRCGetCell Board Row Col) (PRCGetCell Board Row (+ Col 2))) (PRCNotZero? (PRCGetCell Board Row (+ Col 2)))))
     #t)
    (#t (PRCWinPRowRight2Left1 Board Row (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move with one token on its right and two tokens on its left.
(define (PRCWinPRowLeft2Right1 Board Row Col)
  (cond
    ((null? Board) #f)
    ((< Col 3) #f) ; If the column is less than 3, there are not enough cells to the left to win.
    ((> Col 6) #f) ; If the column is greater than 6, there are not enough cells to the right to win.
    ((and (and (= (PRCGetCell Board Row Col) (PRCGetCell Board Row (+ Col 1))) (PRCNotZero? (PRCGetCell Board Row (+ Col 1))))
          (and (= (PRCGetCell Board Row Col) (PRCGetCell Board Row (- Col 1))) (PRCNotZero? (PRCGetCell Board Row (- Col 1))))
          (and (= (PRCGetCell Board Row Col) (PRCGetCell Board Row (- Col 2))) (PRCNotZero? (PRCGetCell Board Row (- Col 2)))))
     #t)
    (#t (PRCWinPRowLeft2Right1 Board Row (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move horizontally from left to right.
(define (PRCWinPRow Board Row Col)
  (or (PRCWinPRowE Board Row Col)
      (PRCWinPRowW Board Row Col)
      (PRCWinPRowRight2Left1 Board Row Col)
      (PRCWinPRowLeft2Right1 Board Row Col)))

; This function takes the most recent move and tests to see
; if it is a winning move vertically from to top row down.
(define (PRCWinPCol Board Row Col)
  (cond
    ((null? Board) #f)
    ((< Row 4) #f) ; If the row is less than 3, there are not enough cells below to win. 
    ((and (and (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 1) Col)) (PRCNotZero? (PRCGetCell Board (- Row 1) Col)))
          (and (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 2) Col)) (PRCNotZero? (PRCGetCell Board (- Row 2) Col)))
          (and (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 3) Col)) (PRCNotZero? (PRCGetCell Board (- Row 3) Col))))
     #t)
    (#t (PRCWinPCol Board (- Row 1) Col))))

; This function takes the most recent move and tests to see
; if it is a winning move north east diagonally.
(define (PRCWinPDiagonalNEHelper Board Row Col)
  (cond
    ((null? Board) #f)
    ((> Row 4) #f)
    ((> Col 4) #f) ; If the row is greater than 4 or the column is greater than 4, there are not enough cells below or to the right to win.
    ((and (and (= (PRCGetCell Board Row Col) (PRCGetCell Board (+ Row 1) (+ Col 1))) (PRCNotZero? (PRCGetCell Board (+ Row 1) (+ Col 1))))
          (and (= (PRCGetCell Board (+ Row 1) (+ Col 1)) (PRCGetCell Board (+ Row 2) (+ Col 2))) (PRCNotZero? (PRCGetCell Board (+ Row 2) (+ Col 2))))
          (and (= (PRCGetCell Board (+ Row 2) (+ Col 2)) (PRCGetCell Board (+ Row 3) (+ Col 3))) (PRCNotZero? (PRCGetCell Board (+ Row 3) (+ Col 3)))))
     #t)
    (#t (PRCWinPDiagonalNEHelper Board (+ Row 1) (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move north west diagonally.
(define (PRCWinPDiagonalNWHelper Board Row Col)
  (cond
    ((null? Board) #f)
    ((> Row 4) #f)
    ((< Col 4) #f) ; If the row is greater than 4 or the column is less than 4, there are not enough cells below or to the left to win.
    ((and (and (= (PRCGetCell Board Row Col) (PRCGetCell Board (+ Row 1) (- Col 1))) (PRCNotZero? (PRCGetCell Board (+ Row 1) (- Col 1))))
          (and (= (PRCGetCell Board (+ Row 1) (- Col 1)) (PRCGetCell Board (+ Row 2) (- Col 2))) (PRCNotZero? (PRCGetCell Board (+ Row 2) (- Col 2))))
          (and (= (PRCGetCell Board (+ Row 2) (- Col 2)) (PRCGetCell Board (+ Row 3) (- Col 3))) (PRCNotZero? (PRCGetCell Board (+ Row 3) (- Col 3)))))
     #t)
    (#t (PRCWinPDiagonalNWHelper Board (+ Row 1) (- Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move south east diagonally.
(define (PRCWinPDiagonalSEHelper Board Row Col)
  (cond
    ((null? Board) #f)
    ((< Row 4) #f)
    ((> Col 4) #f) ; If the row is less than 4 or the column is greater than 4, there are not enough cells above or to the right to win.
    ((and (and (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 1) (+ Col 1))) (PRCNotZero? (PRCGetCell Board (- Row 1) (+ Col 1))))
          (and (= (PRCGetCell Board (- Row 1) (+ Col 1)) (PRCGetCell Board (- Row 2) (+ Col 2))) (PRCNotZero? (PRCGetCell Board (- Row 2) (+ Col 2))))
          (and (= (PRCGetCell Board (- Row 2) (+ Col 2)) (PRCGetCell Board (- Row 3) (+ Col 3))) (PRCNotZero? (PRCGetCell Board (- Row 3) (+ Col 3)))))
     #t)
    (#t (PRCWinPDiagonalSEHelper Board (- Row 1) (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move south west diagonally.
(define (PRCWinPDiagonalSWHelper Board Row Col)
  (cond
    ((null? Board) #f)
    ((< Row 4) #f)
    ((< Col 4) #f) ; If the row is less than 4 or the column is less than 4, there are not enough cells above or to the left to win.
    ((and (and (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 1) (- Col 1))) (PRCNotZero? (PRCGetCell Board (- Row 1) (- Col 1))))
          (and (= (PRCGetCell Board (- Row 1) (- Col 1)) (PRCGetCell Board (- Row 2) (- Col 2))) (PRCNotZero? (PRCGetCell Board (- Row 2) (- Col 2))))
          (and (= (PRCGetCell Board (- Row 2) (- Col 2)) (PRCGetCell Board (- Row 3) (- Col 3))) (PRCNotZero? (PRCGetCell Board (- Row 3) (- Col 3)))))
     #t)
    (#t (PRCWinPDiagonalSWHelper Board (- Row 1) (- Col 1)))))

; This function takes a board and tests to see if the next player's
; token will win the game if placed in the specified column.
(define (PRCWillWinPHelper Board Col)
  (cond ((PRCWinPRow Board (PRCGetTopRow Board Col) Col) #t)
        ((PRCWinPCol Board (PRCGetTopRow Board Col) Col) #t)
        ((PRCWinPDiagonal Board (PRCGetTopRow Board Col) Col) #t)
        (#t #f)))

; This function checks for the edge case of a winning move being between
; two tokens on its right and one token on its left in the north east direction.
(define (PRCWinPDiagonalNEEdgeCase Board Row Col)
  (and (>= Row 2) (<= Row 4) (>= Col 2) (<= Col 5)
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 1) (- Col 1)))
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (+ Row 1) (+ Col 1)))
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (+ Row 2) (+ Col 2)))
       (PRCNotZero? (PRCGetCell Board Row Col))))

; This function checks for the edge case of a winning move being between
; two tokens on its right and one token on its left in the north west direction.
(define (PRCWinPDiagonalNWEdgeCase Board Row Col)
  (and (>= Row 2) (<= Row 4) (>= Col 3) (<= Col 6)
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 1) (+ Col 1)))
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (+ Row 1) (- Col 1)))
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (+ Row 2) (- Col 2)))
       (PRCNotZero? (PRCGetCell Board Row Col))))

; This function checks for the edge case of a winning move being between
; two tokens on its right and one token on its left in the south east direction.
(define (PRCWinPDiagonalSEEdgeCase Board Row Col)
  (and (>= Row 3) (<= Row 5) (>= Col 2) (<= Col 5)
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (+ Row 1) (- Col 1)))
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 1) (+ Col 1)))
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 2) (+ Col 2)))
       (PRCNotZero? (PRCGetCell Board Row Col))))

; This function checks for the edge case of a winning move being between two
; tokens on its right and one token on its left in the south west direction.
(define (PRCWinPDiagonalSWEdgeCase Board Row Col)
  (and (>= Row 3) (<= Row 5) (>= Col 3) (<= Col 6)
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (+ Row 1) (+ Col 1)))
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 1) (- Col 1)))
       (= (PRCGetCell Board Row Col) (PRCGetCell Board (- Row 2) (- Col 2)))
       (PRCNotZero? (PRCGetCell Board Row Col))))

; The four functions below combine the diagonal edge case functions with the helper functions.
(define (PRCWinPDiagonalNE Board Row Col)
  (or (PRCWinPDiagonalNEHelper Board Row Col)
      (PRCWinPDiagonalNEEdgeCase Board Row Col)))

(define (PRCWinPDiagonalNW Board Row Col)
  (or (PRCWinPDiagonalNWHelper Board Row Col)
      (PRCWinPDiagonalNWEdgeCase Board Row Col)))

(define (PRCWinPDiagonalSE Board Row Col)
  (or (PRCWinPDiagonalSEHelper Board Row Col)
      (PRCWinPDiagonalSEEdgeCase Board Row Col)))

(define (PRCWinPDiagonalSW Board Row Col)
  (or (PRCWinPDiagonalSWHelper Board Row Col)
      (PRCWinPDiagonalSWEdgeCase Board Row Col)))

; This function combines the diagonal functions.
(define (PRCWinPDiagonal Board Row Col)
  (or (PRCWinPDiagonalNE Board Row Col)
      (PRCWinPDiagonalNW Board Row Col)
      (PRCWinPDiagonalSE Board Row Col)
      (PRCWinPDiagonalSW Board Row Col)))

; ------------------  MAIN FUNCTIONS  ------------------

; This function starts the game by initializing the PRCGame variable.
(define PRCGame (cons 1 (PRCInitBoard)))

; This function starts the game by initializing the PRCGame variable
; with a blank board (a list of six seven atom lists).
(define (PRCStartGame)
  (begin
    (set! PRCGame (cons 1 (PRCInitBoard)))
    (display "Astral Codex Ten is a good blog. You should read it.") (newline)
    #t))

; This function takes a column number as input and returns true or false
; to indicate whether the move is legal or not.
(define (PRCLegalMoveP Col)
  (cond ((< Col 1) #f)
        ((> Col 7) #f)
        ((> (PRCGetEmptyRow (cdr PRCGame) Col) 6) #f) ; Checks if the column is full
        (#t #t))) ; else, the move is legal

; This function takes a column number (numbered left to right from 1 to 7) as input
; and uses this input to update the global PRCGame variable.
(define (PRCMarkMove Col)
  (begin
    (set! PRCGame
          (cons (PRCNextPlayer)
                (PRCMove (cdr PRCGame)
                        (car PRCGame)
                          Col)))
    Col))

; This function displays the current game grid and returns #t.
(define (PRCShowGame)
  (begin
    (PRCShowPlayer) (newline)
    (display "-------------") (newline)
    (PRCShowBoard (cdr PRCGame)) 
    (display "-------------") (newline)
    #t))

; This function should call the PRCChooseMove function to determine the next move.
; It should return the column number of the move.
(define (PRCMakeMove)
  (PRCChooseMove))

; This function tests the current game grid to see if the given move (column)
; will result in a win, and return true or false.
(define (PRCWillWinP Col)
  (cond ((PRCWillWinPHelper (PRCMove (cdr PRCGame) (car PRCGame) Col) Col) #t)
        (#t #f)))

; This function tests the current game grid to see if the last move resulted in a win.
; It accepts one argument that represents the column of the latest move, and returns true or false.
(define (PRCWinP Col)
  (cond ((PRCWinPRow (cdr PRCGame) (PRCGetTopRow (cdr PRCGame) Col) Col) #t)
        ((PRCWinPCol (cdr PRCGame) (PRCGetTopRow (cdr PRCGame) Col) Col) #t)
        ((PRCWinPDiagonal (cdr PRCGame) (PRCGetTopRow (cdr PRCGame) Col) Col) #t)
        (#t #f)))