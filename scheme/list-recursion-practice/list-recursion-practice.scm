; Name: Parker Conley
; Date: 03.13.2023
; Description: This program defines three functions that manipulate lists.

#lang scheme

; This function takes two vectors in the form of lists
; and returns the dot product.
(define (dotProduct vector1 vector2)
  (if (null? vector1)
      0
      (+ (* (car vector1) (car vector2))
         (dotProduct (cdr vector1) (cdr vector2)))))

; This function takes a list.
; It returns #t if the list has duplicate atoms.
; It returns #f if the list does not have duplicate atoms.
(define (duplicates? list)
  (if (null? list)
      #f
      (if (myMember (cdr list) (car list))
          #t
          (duplicates? (cdr list)))))

; This function takes a list and an atom.
; It returns #t if the atom is in the list.
; It returns #f if the atom is not in the list.
(define (myMember list atom)
    (if (null? list)
         #f
         (if (= (car list) atom)
              #t
              (myMember (cdr list) atom))))

; This function takes a list of pairs, each representing an x, y coordinate.
; Eg, '((1 . 1) (4 . 5) (6 . 5) (3 . 1)).
; The function returns the distance between each of these points in order.
(define (distance pairs)
  (if (null? (cdr pairs))
      0
      (+ (sqrt (+ (expt (- (car (car (cdr pairs))) (car (car pairs))) 2)
                  (expt (- (cdr (car (cdr pairs))) (cdr (car pairs))) 2)))
         (distance (cdr pairs)))))