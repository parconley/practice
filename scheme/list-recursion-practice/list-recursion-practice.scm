; Name: Parker Conley
; Date: 03.13.2023
; Description: This program defines three functions that manipulate lists.

#lang scheme

; This function takes two vectors in the form of lists
; and returns the dot product.
(define (dotProduct vector1 vector2)
  (if (null? vector1)
      0
      (+ (* (car vector1) (car vector2)) (DotProduct (cdr vector1) (cdr vector2)))))

(define (duplicates? list1 list2)
  (if (null? list1)
      0
      (if (null? list2)
          0
          (if (eq? (car list2) (car list2))
              (+ 1 (duplicates? (cdr list1) (cdr list2)))))))
; this code is incorrect where it's at. It needs to cycle through one at a time, not both at a time.