#lang rosette

(require rackunit
         gigls/unsafe
         "../source/generator.rkt"
         "../source/tile.rkt"
         "../source/utilities.rkt"
         "../data/tile-database.rkt")

(test-begin
  (let ([generated-map (make-map tiles 2 2)])
    (check-equal? (tile-east (map-ref generated-map 0 0))
                  (tile-west (map-ref generated-map 0 1)))
    (check-equal? (tile-east (map-ref generated-map 1 0))
                  (tile-west (map-ref generated-map 1 1)))
    (check-equal? (tile-south (map-ref generated-map 0 0))
                  (tile-north (map-ref generated-map 1 0)))
    (check-equal? (tile-south (map-ref generated-map 0 1))
                  (tile-north (map-ref generated-map 1 1)))))

(define (smoke-test-render-map map-height map-width)
  (image-show (render-map (make-map tiles map-height map-width))))
