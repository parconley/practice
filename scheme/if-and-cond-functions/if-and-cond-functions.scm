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
    ((and (>= weight 15)(< weight 18) "PeeWee"))
    ((and (>= weight 18)(< weight 21) "Small"))
    ((and (>= weight 21)(< weight 24) "Medium"))
    ((and (>= weight 24)(< weight 27) "Large"))
    ((and (>= weight 27)(< weight 30) "Extra Large"))
    ((and (>= weight 30)(< weight 33) "Jumbo"))
    (#t "Invalid Size")))

; (3) --------------------------------------------------------------------------

(define (CalcWeeklyPaycheck is_hourly hours_or_sales_total hourly_rate donation)
  (- (if is_hourly
      (if (> hours_or_sales_total 40) ;paid hourly
          (+ (* 40 hourly_rate) (* (- hours_or_sales_total 40) hourly_rate 1.5)) ;yes overtime: 40 times hourly rate + over time hours times 1.5x hourly rate
          (* 40 hourly_rate)) ;no overtime
      (cond ;paid by commission
        ((< hours_or_sales_total 1000) (* hours_or_sales_total 0.1))
        ((and (>= hours_or_sales_total 1000) (< hours_or_sales_total 5000)) (* hours_or_sales_total 0.15))
        ((>= hours_or_sales_total 5000) (* hours_or_sales_total 0.20)))) 
     donation))