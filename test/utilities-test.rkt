#lang rosette

(require gigls/unsafe
         "../source/utilities.rkt"
         "../data/tile-database.rkt")

(define (smoke-test-image-rotate)
  (image-show (tile-image rotate-smoke-test-tile))
  (image-show (rotate-image (tile-image rotate-smoke-test-tile))))
