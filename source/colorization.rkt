#lang racket

(provide colorization combined-colorization)

(define (colorization hue saturation lightness)
  (hasheq 'hue hue 'saturation saturation 'lightness lightness))

(define (combined-colorization colorization-1 weight-1
                               colorization-2 weight-2)
  (for/hasheq ([(key value-1) colorization-1])
    (let ([value-2 (hash-ref colorization-2 key)])
      (values key (weighted-average value-1 weight-1 value-2 weight-2)))))

(define (weighted-average value-1 weight-1 value-2 weight-2)
  (/ (weighted-sum value-1 weight-1 value-2 weight-2)
     (sum-of-weights weight-1 weight-2)))

(define (weighted-sum value-1 weight-1 value-2 weight-2)
  (+ (weighted-value value-1 weight-1)
     (weighted-value value-2 weight-2)))

(define (weighted-value value weight)
  (* value weight))

(define (sum-of-weights weight-1 weight-2)
  (+ weight-1 weight-2))
