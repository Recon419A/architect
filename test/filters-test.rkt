#lang rosette

(require gigls/unsafe
         "../source/filters.rkt"
         "../source/tile.rkt"
         "../data/tile-database.rkt")

(define (smoke-test-colorize)
  (image-show (colorize (tile-image rotate-test-tile) 1 1 200 80 80)))
