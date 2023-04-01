; Name: Parker Conley
; Date: 04.01.23
; Description: This program plays the game Connect 4.

#lang scheme

(define PRCGame 0)

(define (initBoard)
  (makeList 6 (makeList 7 0)))

; This function starts the game by initializing the PRCGame variable
; with a blank board (a list of six seven atom lists).
(define (PRCStartGame)
  (begin
    (set! PRCGame '(cons 1 (initBoard)))
    (display "Following the guidance of Astral Codex Ten.") (newline)
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
    (display (car (cdr PRCGame))) (newline)
    #t))

; This function should call the PRCChooseMove function to determine the next move.
; It should return the column number of the move.
(define (PRCMakeMove)
  (PRCMarkMove
   ;(XXXChooseMove ...) ; refer to XXXGame
   (+ 1 (random 7))))

; This function takes a column number as input and returns true or false
; to indicate whether the move is legal or not.
(define (PRCValidMoveP Col)
  (if (and (<= Col 7) (>= Col 1))
        ; dunno what to do next on this


; This function tests the current game grid to see if the last move resulted in a win.
; It accepts one argument that represents the column of the latest move, and returns true or false.
(define (PRCWinP Col)
  ())

; This function tests the current game grid to see if the given move (column)
; will result in a win, and return true or false.
(define (PRCWillWinP Col)
  ())

;; This function displays the game grid with X's and O's.
;(define (PRCShowPlayer)
;  (if (= (car PRCGame) 1)
;      (display "X")
;      (display "O")))

(define (PRCNextPlayer)
  (if (= (car PRCGame) 1) 2 1))

; This function takes a list, token, and column.
; It ads the player's token to the specified column in the list.
(define (PRCMove lst token Col)
  (if (= Col 1)
      (cons token (cdr lst))
      (cons (car lst) (PRCMove (cdr lst)
                               token
                               (- Col 1)))))

; This function makes a list with a given amount (n) of an atom. 
(define (makeList n atom)
  (if (= n 0)
      '()
      (cons atom (makeList (- n 1) atom))))