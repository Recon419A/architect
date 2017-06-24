#lang racket

(require rackunit
         "../source/rating.rkt"
         "../source/colorization.rkt")

(define test-colorization-1 (colorization 0 0 0))
(define test-colorization-2 (colorization 1 1 1))
(define test-weight-1 0)
(define test-weight-2 1)
(define combined-test-colorization
  (combined-colorization test-colorization-1 test-weight-1
                         test-colorization-2 test-weight-2))


(define test-rating-1 (rating "term" test-colorization-1 test-weight-1))
(define test-rating-2 (rating "term" test-colorization-2 test-weight-2))

(test-case "combined-rating should combine the colorizations"
  (check-equal? (combined-rating test-rating-1 test-rating-2)
                (rating "term" combined-test-colorization 1)))
