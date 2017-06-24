#lang rosette

(require gigls/unsafe
         "../source/filters.rkt"
         "../source/tile.rkt"
         "../source/colorization.rkt"
         "../data/tile-database.rkt")

(define (smoke-test-colorize)
  (image-show (colorize (tile-image rotate-test-tile) (colorization 200 80 80))))
