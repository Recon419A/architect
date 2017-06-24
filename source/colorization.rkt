#lang racket

(provide colorization combined-colorization random-colorization)

(define (colorization hue saturation lightness)
  (list hue saturation lightness))

(define (combined-colorization colorization-1 weight-1
                               colorization-2 weight-2)
  (for/list ([value-1 colorization-1]
             [value-2 colorization-2])
    (weighted-average value-1 weight-1 value-2 weight-2)))

(define (random-colorization)
  (colorization (random 360) (random 100) (random 100)))

(define (weighted-average value-1 weight-1 value-2 weight-2)
  (if (equal? 0 (sum-of-weights weight-1 weight-2)) 0
      (non-zero-weighted-average value-1 weight-1 value-2 weight-2)))

(define (non-zero-weighted-average value-1 weight-1 value-2 weight-2)
  (/ (weighted-sum value-1 weight-1 value-2 weight-2)
     (sum-of-weights weight-1 weight-2)))

(define (weighted-sum value-1 weight-1 value-2 weight-2)
  (+ (weighted-value value-1 weight-1)
     (weighted-value value-2 weight-2)))

(define (weighted-value value weight)
  (* value weight))

(define (sum-of-weights weight-1 weight-2)
  (+ weight-1 weight-2))
