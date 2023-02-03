;Parker Conley
;2.3.23
;This program solves the assigned five word problems.

#lang scheme

;(1)
(* 100
   (expt (+ 1 0.09) 20))

;(2)
(- (* (/ 100 0.0075)
      (- (expt (+ 1 0.0075) (+ 36 1))
         1))
   100)

;(3)
(/ (* 5000 0.015)
   (- 1 (expt (+ 1
                 0.015)
              (- 60))))

;(4)
(/ (* 2000
      0.005)
   (- (expt (+ 1
               0.005)
            11)
      1))

;(5)
(* 100000
   (expt (+ 1
            0.01)
         (- 4)))