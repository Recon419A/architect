#lang racket

(require rackunit
         "../source/colorization.rkt")

(define test-colorization (colorization 1 2 3))

(test-case "colorization-hue should return the hue"
  (check-equal? (colorization-hue test-colorization)))

(test-case "colorization")
