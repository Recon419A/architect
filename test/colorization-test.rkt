#lang racket

(require rackunit
         "../source/colorization.rkt")

(define test-colorization-1 (colorization 0 0 0))
(define test-colorization-2 (colorization 1 1 1))

(test-case "combined-colorization should return the weighted average"
  (check-equal? (combined-colorization test-colorization-1 0.5
                                       test-colorization-2 0.5)
                (colorization 0.5 0.5 0.5))
  (check-equal? (combined-colorization test-colorization-1 0
                                       test-colorization-2 1)
                (colorization 1 1 1)))
