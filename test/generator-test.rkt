#lang rosette

(require rackunit
         gigls/unsafe
         "../source/generator.rkt"
         "../source/utilities.rkt"
         "../data/tile-database.rkt")

(test-case "2x2 map"
  (let ([map-tiles (make-map tiles 2 2)])
    (check-pred valid? map-tiles)))

(test-case "3x3 map"
  (let ([map-tiles (make-map tiles 3 3)])
    (check-pred valid? map-tiles)))

(define (smoke-test-render-map map-height map-width)
  (let ([map-tiles (make-map tiles map-height map-width)])
    (image-show (render-map map-tiles))))
