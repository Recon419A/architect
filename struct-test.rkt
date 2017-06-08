#lang rosette

(require "choice.rkt"
         "assert.rkt"
         "import-test.rkt")

(define a-point (choose-random points))

(equal! (point-z a-point) 3)

(point-y (evaluate a-point (solve asserts)))



;; (define d (choose-random (list (car tiles) (cadr tiles))))

;; (equal! (tile-north d) 2)

;; (tile-image (evaluate d (solve asserts)))
