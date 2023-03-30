; Name: Parker Conley
; Date: 02.13.23
; Description: This program defines three functions
; which use the scheme "if" and "cond" expressions.

#lang scheme

; (1) --------------------------------------------------------------------------

(define (CalcWaterPumpCost rate pump_head fuel_cost pump_efficiency has_gasoline)
  (/ (* rate
        pump_head
        (if has_gasoline
            0.110
            0.065)
        fuel_cost)
     (* 3960
        pump_efficiency)))

; (2) --------------------------------------------------------------------------


(define (IdentifyEggSize weight)
  (cond
    ((< weight 15) "Invalid Size")
    ((< weight 18) "PeeWee")
    ((< weight 21) "Small")
    ((< weight 24) "Medium")
    ((< weight 27) "Large")
    ((< weight 30) "Extra Large")
    ((< weight 33) "Jumbo")
    (#t "Invalid Size")))

; (3) --------------------------------------------------------------------------

(define (CalcWeeklyPaycheck is_hourly hours_or_sales_total hourly_rate donation)
  (- (if is_hourly
      (if (> hours_or_sales_total 40) ;paid hourly
          (+ (* 40 hourly_rate) ;yes overtime: 40 times hourly rate + over time hours times 1.5x hourly rate
             (* (- hours_or_sales_total 40)
                hourly_rate
                1.5)) 
          (* hours_or_sales_total hourly_rate)) ;no overtime
      (cond ;paid by commission
        ((< hours_or_sales_total 1000) (* hours_or_sales_total 0.1))
        ((< hours_or_sales_total 5000) (* hours_or_sales_total 0.15))
        (#t (* hours_or_sales_total 0.20))))
     donation))