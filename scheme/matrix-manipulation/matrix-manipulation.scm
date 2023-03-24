; Name: Parker Conley
; Date: 03.23.23
; Description: This program impliments two recursive functions to manipulate
; matrices: "getCell" and "setCell". The program assumes that matrices are lists
; of nonempty lists and does not check for input errors. Rows are numbered
; from bottom to top and columns from left to right.

#lang scheme

; This function returns the cell at the specified row and column of the matrix.
(define (getCell Matrix Row Column)
  (if (null? Matrix)
      #f
      (if (= Row 1)
          (getCellInRow (car Matrix) Column)
          (getCell (cdr Matrix) (- Row 1) Column))))

; This function is called by "getCell" to get a cell in a row of a matrix.
(define (getCellInRow Matrix Column)
  (if (null? Matrix)
      #f
      (if (= Column 1)
          (car Matrix)
          (getCellInRow (cdr Matrix) (- Column 1)))))

; This function sets the cell at the specified row and column of the matrix to
; the specified item.
(define (setCell Matrix Row Column Item)
  (if (null? Matrix)
      '()
      (if (= Row 1)
          (cons (setCellInRow (car Matrix) Column Item) (setCell (cdr Matrix) (- Row 1) Column Item))
          (cons (car Matrix) (setCell (cdr Matrix) (- Row 1) Column Item)))))

; This function is called by "setCell" to set a cell in a row of a matrix.
(define (setCellInRow Matrix Column Item)
  (if (null? Matrix)
      '()
      (if (= Column 1)
          (cons Item (setCellInRow (cdr Matrix) (- Column 1) Item))
          (cons (car Matrix) (setCellInRow (cdr Matrix) (- Column 1) Item)))))