; Name: Parker Conley
; Date: 03.13.2023
; Description: This program defines three functions that manipulate lists.

#lang scheme

; Problem (a)

; This function takes two vectors in the form of lists
; and returns the dot product.
(define (dotProduct vector1 vector2)
  (if (null? vector1)
      0
      (+ (* (car vector1) (car vector2)) (dotProduct (cdr vector1) (cdr vector2)))))

; Problem (b)

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

; Problem (c)

(define (distance pairs)
  (if (null? (cdr pairs))
      0
      (+ (sqrt (+ (expt (- (car (cdr pairs)) (car pairs)) 2)
                  (expt (- (car (cdr pairs)) (car pairs)) 2)))
         (distance (cdr pairs)))))

; I did not impliment a way to nagivate with two lists. Fix this next time around
    

         