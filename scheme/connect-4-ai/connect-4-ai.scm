; Name: Parker Conley
; Date: 04.01.23
; Description: This program plays the game Connect 4.

#lang scheme

; ------------------  MAIN FUNCTIONS  ------------------

; This function starts the game by initializing the PRCGame variable.
(define PRCGame (cons 1 (PRCInitBoard)))

; This function starts the game by initializing the PRCGame variable
; with a blank board (a list of six seven atom lists).
(define (PRCStartGame)
  (begin
    (set! PRCGame (cons 1 (PRCInitBoard)))
    (display "Astral Codex Ten is based") (newline)
    #t))

; This function takes a column number (numbered left to right from 1 to 7) as input
; and uses this input to update the global PRCGame variable.
(define (PRCMarkMove Col)
  (begin
    (set! PRCGame
          (cons (PRCNextPlayer)
                (cons (PRCMove (car (cdr PRCGame))
                               (car PRCGame)
                               Col) '())))
    Col))

; This function displays the current game grid and returns #t.
(define (PRCShowGame)
  (begin
    (PRCShowPlayer) (newline)
    (display "_______")
    (PRCShowBoard PRCGame)
    (display "_______")
    ; (display (car (cdr PRCGame))) (newline)
    #t))

; This function should call the PRCChooseMove function to determine the next move.
; It should return the column number of the move.
(define (PRCMakeMove)
  (PRCMarkMove
   ;(PRCChooseMove)
   (+ 1 (random 7))))

; This function takes a column number as input and returns true or false
; to indicate whether the move is legal or not.
;(define (PRCLegalMoveP Col)
;  (if (and (<= Col 7) (>= Col 1))
;        ; dunno what to do next on this

; This function tests the current game grid to see if the last move resulted in a win.
; It accepts one argument that represents the column of the latest move, and returns true or false.
;(define (PRCWinP Col)
;  ())

; This function tests the current game grid to see if the given move (column)
; will result in a win, and return true or false.
;(define (PRCWillWinP Col)
;  ())

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
      (display "X")
      (display "O")))

; This function returns the number of the player whose turn it is.
(define (PRCNextPlayer)
  (if (= (car PRCGame) 1) 2 1))

; This function takes a list, token, and column.
; It ads the player's token to the specified column in the list.
(define (PRCMove lst token Col)
  (if (= Col 1)
      (cons token (cdr lst))
      (cons (car list) (PRCMove (cdr lst)
                               token
                               (- Col 1)))))

; ------------------  Display Functions  ------------------

(define (PRCShowCell value)
  (cond ((= value 0) (display "."))
        ((= value 1) (display "X"))
        ((= value 2) (display "O"))
        (else (display "?"))))

(define (PRCShowRow row)
  (if (null? row)
      (newline)
      (begin
        (PRCShowCell (car row))
        (display " ")
        (PRCShowRow (cdr row)))))

(define (PRCShowBoard board)
  (if (null? board)
      (display "-----------------") ; Print the bottom line when done
      (begin
        (PRCShowRow (car board))
        (PRCShowBoard (cdr board)))))







