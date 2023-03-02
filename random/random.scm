#lang scheme
(define (insertFront Lst Item)
  (cons Item Lst))

(define (insertEnd Lst Item)
  (if (null? Lst)
      (cons Item '())
      (cons (car Lst)
            (insertEnd (cdr Lst) Item))))

(insertEnd '(11 1 2) 1)

(define (insertAtPos Lst Item Pos)
  (if (=))