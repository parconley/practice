; Name: Parker Conley
; Date: 03/12/23
; Description: This program includes a function that replaces a given number
; in a list with a second given number using recursion.

#lang scheme

(define (ReplaceXWithY list x y)
  (if (null? list)
      '()
      (if (= (car list) x)
          (cons y (ReplaceXWithY (cdr list) x y))
          (cons (car list) (ReplaceXWithY (cdr list) x y)))))