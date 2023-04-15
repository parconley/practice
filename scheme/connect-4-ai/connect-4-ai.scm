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
(define (PRCGetCell Matrix Row Column)
  (if (null? Matrix)
      #f
      (if (= Row 1)
          (PRCGetCellInRow (car Matrix) Column)
          (PRCGetCell (cdr Matrix) (- Row 1) Column))))

; This function is called by "getCell" to get a cell in a row of a matrix.
(define (PRCGetCellInRow Matrix Column)
  (if (null? Matrix)
      #f
      (if (= Column 1)
          (car Matrix)
          (PRCGetCellInRow (cdr Matrix) (- Column 1)))))

; This function sets the cell at the specified row and column of the matrix to
; the specified item.
(define (PRCSetCell Matrix Row Column Item)
  (if (null? Matrix)
      '()
      (if (= Row 1)
          (cons (PRCSetCellInRow (car Matrix) Column Item) (PRCSetCell (cdr Matrix) (- Row 1) Column Item))
          (cons (car Matrix) (PRCSetCell (cdr Matrix) (- Row 1) Column Item)))))

; This function is called by "setCell" to set a cell in a row of a matrix.
(define (PRCSetCellInRow Matrix Column Item)
  (if (null? Matrix)
      '()
      (if (= Column 1)
          (cons Item (PRCSetCellInRow (cdr Matrix) (- Column 1) Item))
          (cons (car Matrix) (PRCSetCellInRow (cdr Matrix) (- Column 1) Item)))))

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
(define (PRCGetRow board Col)
  (if (null? board)
      1
      (if (= (PRCGetCell board 1 Col) 0)
          (PRCGetRow (cdr board) Col)
          (+ 1 (PRCGetRow (cdr board) Col)))))

; This function takes a list, token, and column.
; It ads the player's token to the specified column in the list.
(define (PRCMove board token Col)
  (PRCSetCell board (PRCGetRow board Col) Col token))


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
      (begin
        (PRCShowCell (car row))
        (display " ")
        (PRCShowRow (cdr row)))))

; This function takes a board and displays it.
(define (PRCShowBoard board)
  (if (null? board)
      '()
      (begin
        (PRCShowBoard (cdr board))
        (newline)
        (PRCShowRow (car board)))))


; NOTE: BELOW WINNING FUNCTIONS ARE STILL NOT WORKING AND IN PROGRESS
; TODO: FIX WINNING FUNCTIONS

; Compare two cells to see if they are equal and not zero.
(define (PRCNotZero? x)
  (not (= x 0)))

; This function takes the most recent move and tests to see
; if it is a winning move horizontally east.
(define (PRCWinPRowE board Col)
  (cond
    ((null? board) #f)
    ((> Col 4) #f)
    ((and (and (= (PRCGetCell board 1 Col) (PRCGetCell board 1 (+ Col 1))) (PRCNotZero? (PRCGetCell board 1 (+ Col 1))))
          (and (= (PRCGetCell board 1 (+ Col 1)) (PRCGetCell board 1 (+ Col 2))) (PRCNotZero? (PRCGetCell board 1 (+ Col 2))))
          (and (= (PRCGetCell board 1 (+ Col 2)) (PRCGetCell board 1 (+ Col 3))) (PRCNotZero? (PRCGetCell board 1 (+ Col 3)))))
     #t)
    (#t (PRCWinPRowE board (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move horizontally west.
(define (PRCWinPRowW board Col)
  (cond
    ((null? board) #f)
    ((< Col 4) #f)
    ((and (and (= (PRCGetCell board 1 Col) (PRCGetCell board 1 (- Col 1))) (PRCNotZero? (PRCGetCell board 1 (- Col 1))))
          (and (= (PRCGetCell board 1 (- Col 1)) (PRCGetCell board 1 (- Col 2))) (PRCNotZero? (PRCGetCell board 1 (- Col 2))))
          (and (= (PRCGetCell board 1 (- Col 2)) (PRCGetCell board 1 (- Col 3))) (PRCNotZero? (PRCGetCell board 1 (- Col 3)))))
     #t)
    (#t (PRCWinPRowW board (- Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move vertically.
(define (PRCWinPColumn board Row Col)
  (cond
    ((null? board) #f)
    ((> Row 4) #f)
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) Col)) (PRCNotZero? (PRCGetCell board (+ Row 1) Col)))
          (and (= (PRCGetCell board (+ Row 1) Col) (PRCGetCell board (+ Row 2) Col)) (PRCNotZero? (PRCGetCell board (+ Row 2) Col)))
          (and (= (PRCGetCell board (+ Row 2) Col) (PRCGetCell board (+ Row 3) Col)) (PRCNotZero? (PRCGetCell board (+ Row 3) Col))))
     #t)
    (#t (PRCWinPColumn board (+ Row 1) Col))))

; This function takes the most recent move and tests to see
; if it is a winning move north east diagonally.
(define (PRCWinPDiagonalNE board Row Col)
  (cond
    ((null? board) #f)
    ((> Row 4) #f)
    ((> Col 4) #f)
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) (+ Col 1))) (PRCNotZero? (PRCGetCell board (+ Row 1) (+ Col 1))))
          (and (= (PRCGetCell board (+ Row 1) (+ Col 1)) (PRCGetCell board (+ Row 2) (+ Col 2))) (PRCNotZero? (PRCGetCell board (+ Row 2) (+ Col 2))))
          (and (= (PRCGetCell board (+ Row 2) (+ Col 2)) (PRCGetCell board (+ Row 3) (+ Col 3))) (PRCNotZero? (PRCGetCell board (+ Row 3) (+ Col 3)))))
     #t)
    (#t (PRCWinPDiagonalNE board (+ Row 1) (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move north west diagonally.
(define (PRCWinPDiagonalNW board Row Col)
  (cond
    ((null? board) #f)
    ((> Row 4) #f)
    ((< Col 4) #f)
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (+ Row 1) (- Col 1))) (PRCNotZero? (PRCGetCell board (+ Row 1) (- Col 1))))
          (and (= (PRCGetCell board (+ Row 1) (- Col 1)) (PRCGetCell board (+ Row 2) (- Col 2))) (PRCNotZero? (PRCGetCell board (+ Row 2) (- Col 2))))
          (and (= (PRCGetCell board (+ Row 2) (- Col 2)) (PRCGetCell board (+ Row 3) (- Col 3))) (PRCNotZero? (PRCGetCell board (+ Row 3) (- Col 3)))))
     #t)
    (#t (PRCWinPDiagonalNW board (+ Row 1) (- Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move south east diagonally.
(define (PRCWinPDiagonalSE board Row Col)
  (cond
    ((null? board) #f)
    ((< Row 4) #f)
    ((> Col 4) #f)
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 1) (+ Col 1))) (PRCNotZero? (PRCGetCell board (- Row 1) (+ Col 1))))
          (and (= (PRCGetCell board (- Row 1) (+ Col 1)) (PRCGetCell board (- Row 2) (+ Col 2))) (PRCNotZero? (PRCGetCell board (- Row 2) (+ Col 2))))
          (and (= (PRCGetCell board (- Row 2) (+ Col 2)) (PRCGetCell board (- Row 3) (+ Col 3))) (PRCNotZero? (PRCGetCell board (- Row 3) (+ Col 3)))))
     #t)
    (#t (PRCWinPDiagonalSE board (- Row 1) (+ Col 1)))))

; This function takes the most recent move and tests to see
; if it is a winning move south west diagonally.
(define (PRCWinPDiagonalSW board Row Col)
  (cond
    ((null? board) #f)
    ((< Row 4) #f)
    ((< Col 4) #f)
    ((and (and (= (PRCGetCell board Row Col) (PRCGetCell board (- Row 1) (- Col 1))) (PRCNotZero? (PRCGetCell board (- Row 1) (- Col 1))))
          (and (= (PRCGetCell board (- Row 1) (- Col 1)) (PRCGetCell board (- Row 2) (- Col 2))) (PRCNotZero? (PRCGetCell board (- Row 2) (- Col 2))))
          (and (= (PRCGetCell board (- Row 2) (- Col 2)) (PRCGetCell board (- Row 3) (- Col 3))) (PRCNotZero? (PRCGetCell board (- Row 3) (- Col 3)))))
     #t)
    (#t (PRCWinPDiagonalSW board (- Row 1) (- Col 1)))))

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
        ((> (PRCGetRow (cdr PRCGame) Col) 6) #f) ; Checks if the column is full
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
    (display "-------------")
    (PRCShowBoard (cdr PRCGame)) (newline)
    (display "-------------") (newline)
    #t))

; This function should call the PRCChooseMove function to determine the next move.
; It should return the column number of the move.
(define (PRCMakeMove)
  (PRCMarkMove
   ;(PRCChooseMove)
   (+ 1 (random 7))))

; This function tests the current game grid to see if the given move (column)
; will result in a win, and return true or false.
;(define (PRCWillWinP Col)
;  ())

; This function tests the current game grid to see if the last move resulted in a win.
; It accepts one argument that represents the column of the latest move, and returns true or false.
; NOTE: IN PROGRRESS
(define (PRCWinP Col)
  (cond ((PRCWinPRowE (cdr PRCGame) Col) #t)
        ((PRCWinPRowW (cdr PRCGame) Col) #t)
        ((PRCWinPColumn (cdr PRCGame) 1 Col) #t)
        ((PRCWinPDiagonalNE (cdr PRCGame) 1 Col) #t)
        ((PRCWinPDiagonalNW (cdr PRCGame) 1 Col) #t)
        ((PRCWinPDiagonalSE (cdr PRCGame) 1 Col) #t)
        ((PRCWinPDiagonalSW (cdr PRCGame) 1 Col) #t)
        (#t #f)))

; Test commands
(define (test-PRCWinP)
  (begin
    (define test-board (list (list 1 1 1 1 0 0 0)
                              (list 2 1 2 1 0 0 0)
                              (list 2 2 1 1 1 0 0)
                              (list 0 0 0 1 0 1 0)
                              (list 0 0 0 0 0 0 0)
                              (list 0 0 0 0 0 0 0)))
    (display "Test 1: ") (display (if (PRCWinPRowE test-board 1) "Passed" "Failed")) (newline)
    (display "Test 2: ") (display (if (PRCWinPRowW test-board 4) "Passed" "Failed")) (newline)
    (display "Test 3: ") (display (if (PRCWinPColumn test-board 1 4) "Passed" "Failed")) (newline)
    (display "Test 4: ") (display (if (PRCWinPDiagonalNE test-board 1 4) "Passed" "Failed")) (newline)
    (display "Test 5: ") (display (if (PRCWinPDiagonalNW test-board 1 4) "Passed" "Failed")) (newline)
    (display "Test 6: ") (display (if (PRCWinPDiagonalSE test-board 1 4) "Passed" "Failed")) (newline)
    (display "Test 7: ") (display (if (PRCWinPDiagonalSW test-board 1 4) "Passed" "Failed")) (newline)
  ))

; Run the test-PRCWinP function to test the PRCWinP function and its associated helper functions
(test-PRCWinP)

