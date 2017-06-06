#lang rosette

(require "tile-database.rkt")

(define rotate (tile-1)
  (tile (gimp-item-transform-rotate-simple (tile-image tile-1) 0 #t 600 600)
        (tile-east tile-1) (tile-south tile-1)
        (tile-west tile-1) (tile-north tile-1)))

(define valid (tile-1 north-neighbor east-neighbor num-rotations)
  (or (and (or (null north-neighbor)
               (equal? (tile-south north-neighbor)
                       (tile-north tile-1)))
           (or (null east-neighbor)
               (equal? (tile-west east-neighbor)
                       (tile-east tile-1))))
      (and (< 3 rotations)
           (valid (rotate tile) north-neighbor east-neighbor
                  (+ 1 num-rotations)))))

(define valid-tiles (tiles)
  (for/and ([tile tiles]) (valid tile)))
