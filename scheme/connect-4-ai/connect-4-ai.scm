; Name: Parker Conley
; Date: 04.01.23
; Description: This program plays the game Connect 4.

#lang scheme

; ------------------  HELPER FUNCTIONS  ------------------

; ------------------  List Manipulation  ------------------

; This function makes a list with a given amount (n) of an atom. 
(define (PRCMakeList n atom)
  (if (= n 0)
      '()
      (cons atom (PRCMakeList (- n 1) atom))))

; This function intializes the PRCGame variable with a blank board.
(define (PRCInitBoard)
  (PRCMakeList 6 (PRCMakeList 7 0)))

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

; This function retursn the piece of the player whose turn it is.
(define (PRCShowPlayer)
  (if (= (car PRCGame) 1)
      (display "Next Move: X")
      (display "Next Move: O")))

; This function returns the number of the player whose turn it is.
(define (PRCNextPlayer)
  (if (= (car PRCGame) 1) 2 1))

; This function takes a board and a token and adds the token to the board.
(define (PRCPlaceToken board token Col Row)
  (if (null? board)
      '()
      (if (= Col 1)
          (PRCSetCell board Row Col token)
          (cons (car board) (PRCPlaceToken (cdr board) token (- Col 1) Row))))) ; THIS ONE

; This function takes a board and a column and returns the row number of the
; lowest empty cell in the column.
(define (PRCGetEmptyRow board Col)
  (if (null? board)
      1
      (if (= (PRCGetCell board 1 Col) 0)
          (PRCGetEmptyRow (cdr board) Col)
          (+ 1 (PRCGetEmptyRow (cdr board) Col)))))

; This function takes a board and a column and returns the row number of the
; top token in the column.
(define (PRCGetTopRow board Col)
  (if (null? board)
      0
      (if (= (PRCGetCell board 1 Col) 0)
          (PRCGetTopRow (cdr board) Col)
          (+ 1 (PRCGetTopRow (cdr board) Col)))))

; This function takes a list, token, and column.
; It ads the player's token to the specified column in the list.
(define (PRCMove board token Col)
  (PRCSetCell board (PRCGetEmptyRow board Col) Col token))

; ------------------  Game Play  ------------------

; This function takes a random number and returns the number if it is a legal
; move. Otherwise, it calls itself again with a new random number.
(define (PRCRandomMove number)
  (if (PRCLegalMoveP number)
      number
      (PRCRandomMove (+ 1 (random 7)))))

; This function chooses a random legal move.
(define (PRCChooseMove)
  (PRCRandomMove (+ 1 (random 7))))

; ------------------  Display Functions  ------------------

; This function takes a cell and displays it as a period, X, or O.
(define (PRCShowCell value)
  (cond ((= value 0) (display "."))
        ((= value 1) (display "X"))
        ((= value 2) (display "O"))
        (else (display "?"))))

; This function takes a row and displays it.
(define (PRCShowRow row)
  (if (null? row)
      '()
      (cons (PRCShowCell (car row))
            (cons (display " ") (PRCShowRow (cdr row))))))

; This function uses recursion to display the board. It reverses the order of
; the rows so that the board is displayed correctly.
(define (PRCShowBoardHelper board counter)
  (if (null? board)
      '()
      (if (= counter 1)
          (cons (PRCShowRow (car board))
                (cons (newline) '()))
          (cons (PRCShowBoardHelper (cdr board) (- counter 1))
                (cons (PRCShowRow (car board))
                      (cons (newline) '()))))))

; This function takes a board and displays it.
(define (PRCShowBoard board)
  (PRCShowBoardHelper board 6))

; ------------------  Winning Functions  ------------------

; Compare two cells to see if they are equal and not zero.
(define (PRCNotZero? x)
  (not (= x 0)))

; This function takes the most recent move and tests to see
; if it is a winning move horizontally east.
(define (PRCWinPRowE board Row Col)
  (cond
    ((null? board) #f) 
    ((> Col 4) #f) ; If the column is less than 4, there are not enough cells to the right to win.
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board Row (+ Col 1))) (PRCNotZero? (PRCGetCell board Row (+ Col 1))))
          (and (= (PRCGetCell board Row (+ Col 1)) (PRCGetCell board Row (+ Col 2))) (PRCNotZero? (PRCGetCell board Row (+ Col 2))))
          (and (= (PRCGetCell board Row (+ Col 2)) (PRCGetCell board Row (+ Col 3))) (PRCNotZero? (PRCGetCell board Row (+ Col 3)))))
     #t)
    (#t (PRCWinPRowE board Row (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move horizontally west.
(define (PRCWinPRowW board Row Col)
  (cond
    ((null? board) #f)
    ((< Col 4) #f) ; If the column is greater than 4, there are not enough cells to the left to win.
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board Row (- Col 1))) (PRCNotZero? (PRCGetCell board Row (- Col 1))))
          (and (= (PRCGetCell board Row (- Col 1)) (PRCGetCell board Row (- Col 2))) (PRCNotZero? (PRCGetCell board Row (- Col 2))))
          (and (= (PRCGetCell board Row (- Col 2)) (PRCGetCell board Row (- Col 3))) (PRCNotZero? (PRCGetCell board Row (- Col 3)))))
     #t)
    (#t (PRCWinPRowW board Row (- Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move with two tokens on its right and one token on its left.
(define (PRCWinPRowRight2Left1 board Row Col)
  (cond
    ((null? board) #f)
    ((< Col 2) #f) ; If the column is less than 2, there are not enough cells to the left to win.
    ((> Col 5) #f) ; If the column is greater than 5, there are not enough cells to the right to win.
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board Row (- Col 1))) (PRCNotZero? (PRCGetCell board Row (- Col 1))))
          (and (= (PRCGetCell board Row Col) (PRCGetCell board Row (+ Col 1))) (PRCNotZero? (PRCGetCell board Row (+ Col 1))))
          (and (= (PRCGetCell board Row Col) (PRCGetCell board Row (+ Col 2))) (PRCNotZero? (PRCGetCell board Row (+ Col 2)))))
     #t)
    (#t (PRCWinPRowRight2Left1 board Row (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move with one token on its right and two tokens on its left.
(define (PRCWinPRowLeft2Right1 board Row Col)
  (cond
    ((null? board) #f)
    ((< Col 3) #f) ; If the column is less than 3, there are not enough cells to the left to win.
    ((> Col 6) #f) ; If the column is greater than 6, there are not enough cells to the right to win.
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board Row (+ Col 1))) (PRCNotZero? (PRCGetCell board Row (+ Col 1))))
          (and (= (PRCGetCell board Row Col) (PRCGetCell board Row (- Col 1))) (PRCNotZero? (PRCGetCell board Row (- Col 1))))
          (and (= (PRCGetCell board Row Col) (PRCGetCell board Row (- Col 2))) (PRCNotZero? (PRCGetCell board Row (- Col 2)))))
     #t)
    (#t (PRCWinPRowLeft2Right1 board Row (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move horizontally from left to right.
(define (PRCWinPRow board Row Col)
  (or (PRCWinPRowE board Row Col)
      (PRCWinPRowW board Row Col)
      (PRCWinPRowRight2Left1 board Row Col)
      (PRCWinPRowLeft2Right1 board Row Col)))

; This function takes the most recent move and tests to see
; if it is a winning move vertically from to top row down.
(define (PRCWinPCol board Row Col)
  (cond
    ((null? board) #f)
    ((> Row 3) #f) ; If the row is less than 3, there are not enough cells below to win.
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) Col)) (PRCNotZero? (PRCGetCell board (+ Row 1) Col)))
          (and (= (PRCGetCell board (+ Row 1) Col) (PRCGetCell board (+ Row 2) Col)) (PRCNotZero? (PRCGetCell board (+ Row 2) Col)))
          (and (= (PRCGetCell board (+ Row 2) Col) (PRCGetCell board (+ Row 3) Col)) (PRCNotZero? (PRCGetCell board (+ Row 3) Col))))
     #t)
    (#t (PRCWinPCol board (+ Row 1) Col))))

; This function takes the most recent move and tests to see
; if it is a winning move north east diagonally.
(define (PRCWinPDiagonalNEHelper board Row Col)
  (cond
    ((null? board) #f)
    ((> Row 4) #f)
    ((> Col 4) #f) ; If the row is greater than 4 or the column is greater than 4, there are not enough cells below or to the right to win.
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) (+ Col 1))) (PRCNotZero? (PRCGetCell board (+ Row 1) (+ Col 1))))
          (and (= (PRCGetCell board (+ Row 1) (+ Col 1)) (PRCGetCell board (+ Row 2) (+ Col 2))) (PRCNotZero? (PRCGetCell board (+ Row 2) (+ Col 2))))
          (and (= (PRCGetCell board (+ Row 2) (+ Col 2)) (PRCGetCell board (+ Row 3) (+ Col 3))) (PRCNotZero? (PRCGetCell board (+ Row 3) (+ Col 3)))))
     #t)
    (#t (PRCWinPDiagonalNEHelper board (+ Row 1) (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move north west diagonally.
(define (PRCWinPDiagonalNWHelper board Row Col)
  (cond
    ((null? board) #f)
    ((> Row 4) #f)
    ((< Col 4) #f) ; If the row is greater than 4 or the column is less than 4, there are not enough cells below or to the left to win.
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) (- Col 1))) (PRCNotZero? (PRCGetCell board (+ Row 1) (- Col 1))))
          (and (= (PRCGetCell board (+ Row 1) (- Col 1)) (PRCGetCell board (+ Row 2) (- Col 2))) (PRCNotZero? (PRCGetCell board (+ Row 2) (- Col 2))))
          (and (= (PRCGetCell board (+ Row 2) (- Col 2)) (PRCGetCell board (+ Row 3) (- Col 3))) (PRCNotZero? (PRCGetCell board (+ Row 3) (- Col 3)))))
     #t)
    (#t (PRCWinPDiagonalNWHelper board (+ Row 1) (- Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move south east diagonally.
(define (PRCWinPDiagonalSEHelper board Row Col)
  (cond
    ((null? board) #f)
    ((< Row 4) #f)
    ((> Col 4) #f) ; If the row is less than 4 or the column is greater than 4, there are not enough cells above or to the right to win.
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 1) (+ Col 1))) (PRCNotZero? (PRCGetCell board (- Row 1) (+ Col 1))))
          (and (= (PRCGetCell board (- Row 1) (+ Col 1)) (PRCGetCell board (- Row 2) (+ Col 2))) (PRCNotZero? (PRCGetCell board (- Row 2) (+ Col 2))))
          (and (= (PRCGetCell board (- Row 2) (+ Col 2)) (PRCGetCell board (- Row 3) (+ Col 3))) (PRCNotZero? (PRCGetCell board (- Row 3) (+ Col 3)))))
     #t)
    (#t (PRCWinPDiagonalSEHelper board (- Row 1) (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move south west diagonally.
(define (PRCWinPDiagonalSWHelper board Row Col)
  (cond
    ((null? board) #f)
    ((< Row 4) #f)
    ((< Col 4) #f) ; If the row is less than 4 or the column is less than 4, there are not enough cells above or to the left to win.
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 1) (- Col 1))) (PRCNotZero? (PRCGetCell board (- Row 1) (- Col 1))))
          (and (= (PRCGetCell board (- Row 1) (- Col 1)) (PRCGetCell board (- Row 2) (- Col 2))) (PRCNotZero? (PRCGetCell board (- Row 2) (- Col 2))))
          (and (= (PRCGetCell board (- Row 2) (- Col 2)) (PRCGetCell board (- Row 3) (- Col 3))) (PRCNotZero? (PRCGetCell board (- Row 3) (- Col 3)))))
     #t)
    (#t (PRCWinPDiagonalSWHelper board (- Row 1) (- Col 1)))))

; This function takes a board and tests to see if the next player's
; token will win the game if placed in the specified column.
(define (PRCWillWinPHelper board Col)
  (cond ((PRCWinPRow board (PRCGetTopRow board Col) Col) #t)
        ((PRCWinPCol board (PRCGetTopRow board Col) Col) #t)
        ((PRCWinPDiagonal board (PRCGetTopRow board Col) Col) #t)
        (#t #f)))

; This function checks for the edge case of a winning move being between
; two tokens on its right and one token on its left in the north east direction.
(define (PRCWinPDiagonalNEEdgeCase board Row Col)
  (and (>= Row 2) (<= Row 4) (>= Col 2) (<= Col 5)
       (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 1) (- Col 1)))
       (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) (+ Col 1)))
       (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 2) (+ Col 2)))
       (PRCNotZero? (PRCGetCell board Row Col))))

; This function checks for the edge case of a winning move being between
; two tokens on its right and one token on its left in the north west direction.
(define (PRCWinPDiagonalNWEdgeCase board Row Col)
  (and (>= Row 2) (<= Row 4) (>= Col 3) (<= Col 6)
       (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 1) (+ Col 1)))
       (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) (- Col 1)))
       (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 2) (- Col 2)))
       (PRCNotZero? (PRCGetCell board Row Col))))

; This function checks for the edge case of a winning move being between
; two tokens on its right and one token on its left in the south east direction.
(define (PRCWinPDiagonalSEEdgeCase board Row Col)
  (and (>= Row 3) (<= Row 5) (>= Col 2) (<= Col 5)
       (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) (- Col 1)))
       (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 1) (+ Col 1)))
       (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 2) (+ Col 2)))
       (PRCNotZero? (PRCGetCell board Row Col))))

; This function checks for the edge case of a winning move being between two
; tokens on its right and one token on its left in the south west direction.
(define (PRCWinPDiagonalSWEdgeCase board Row Col)
  (and (>= Row 3) (<= Row 5) (>= Col 3) (<= Col 6)
       (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) (+ Col 1)))
       (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 1) (- Col 1)))
       (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 2) (- Col 2)))
       (PRCNotZero? (PRCGetCell board Row Col))))

; These functions combine the edge case functions with the helper functions.
(define (PRCWinPDiagonalNE board Row Col)
  (or (PRCWinPDiagonalNEHelper board Row Col)
      (PRCWinPDiagonalNEEdgeCase board Row Col)))

(define (PRCWinPDiagonalNW board Row Col)
  (or (PRCWinPDiagonalNWHelper board Row Col)
      (PRCWinPDiagonalNWEdgeCase board Row Col)))

(define (PRCWinPDiagonalSE board Row Col)
  (or (PRCWinPDiagonalSEHelper board Row Col)
      (PRCWinPDiagonalSEEdgeCase board Row Col)))

(define (PRCWinPDiagonalSW board Row Col)
  (or (PRCWinPDiagonalSWHelper board Row Col)
      (PRCWinPDiagonalSWEdgeCase board Row Col)))

; This function combines the diagonal functions.
(define (PRCWinPDiagonal board Row Col)
  (or (PRCWinPDiagonalNE board Row Col)
      (PRCWinPDiagonalNW board Row Col)
      (PRCWinPDiagonalSE board Row Col)
      (PRCWinPDiagonalSW board Row Col)))

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
  (if (PRCLegalMoveP Col)
      (begin
         (set! PRCGame
               (cons (PRCNextPlayer)
                     (PRCMove (cdr PRCGame)
                              (car PRCGame)
                               Col)))
         Col)
      (begin
        (display "Illegal move. Try again.") (newline)
        #f)))

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
