; Name: Parker Conley
; Date: 03.23.23
; Description: This program impliments two recursive functions to manipulate
; matrices: "getCell" and "setCell". The program assumes that matrices are lists
; of nonempty lists and does not check for input errors. Rows are numbered
; from bottom to top and columns from left to right.

#lang scheme

(define (getCell Matrix Row Column)
  (if (null? Matrix)
      #f
      (if (= Row 1)
          (getCellInRow (car Matrix) Column)
           (getCell (cdr Matrix) (- Row 1) Column))))


(define (getCellInRow Matrix Column)
  (if (null? Matrix)
      #f
      (if (= Column 1)
          (car Matrix)
          (getCellInRow (cdr Matrix) (- Column 1)))))

;(define (setCell Matrix Row Column)
;  ())