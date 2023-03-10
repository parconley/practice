; Name: Parker
; Date: 02.22.23
; Description: This program has two funtions that use recursion.
; The first function returns the nth term in a Geometric Sequence.
; The second function returns the value of a base raised to an exponent.

#lang scheme

(define (GeometricSequence scale_factor ratio n)
  (if (= n 1)
      scale_factor
      (* ratio (GeometricSequence scale_factor ratio (- n 1)))))

(define (PowerFunction base exponent)
  (if (= exponent 0)
    1
    (if (even? exponent)
        (Square (PowerFunction base (/ exponent 2)))
        (* base (Square (PowerFunction base (/ (- exponent 1) 2)))))))

(define (Square number)
  (* number number))