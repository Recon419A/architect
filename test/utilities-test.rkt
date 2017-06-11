#lang rosette

(require gigls/unsafe
         rackunit
         "../source/utilities.rkt"
         "../source/tile.rkt"
         "../data/tile-database.rkt")

(define (smoke-test-rotate-image)
  (image-show (tile-image rotate-test-tile))
  (image-show (rotate-image (tile-image rotate-test-tile))))

(test-begin
 (let ([rotated-tile (rotate-tile rotate-test-tile 1)])
   (check-equal? (tile-north rotate-test-tile) (tile-east rotated-tile))
   (check-equal? (tile-east rotate-test-tile) (tile-south rotated-tile))
   (check-equal? (tile-south rotate-test-tile) (tile-west rotated-tile))
   (check-equal? (tile-west rotate-test-tile) (tile-north rotated-tile))))

(check-equal? (length (add-rotations (list rotate-test-tile))) 4)

(define (smoke-test-add-rotations)
  (for ([each-tile (add-rotations (list rotate-test-tile))])
    (image-show (tile-image each-tile))))

(define test-map-1 '((1 2) (3 4)))

(check-equal? (map-ref test-map-1 0 0) 1)
(check-equal? (map-ref test-map-1 0 1) 2)
(check-equal? (map-ref test-map-1 1 0) 3)
(check-equal? (map-ref test-map-1 1 1) 4)

(define test-map-2 '((1 2) (3 4) (5 6)))

(check-equal? (map-width test-map-2) 3)
(check-equal? (map-height test-map-2) 2)
