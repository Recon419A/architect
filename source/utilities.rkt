#lang rosette

(require gigls/unsafe
         "tile.rkt")

(provide rotate-image
         rotate-tile
         add-rotations
         map-ref
         map-width
         map-height
         north-neighbor
         east-neighbor
         south-neighbor
         west-neighbor)

(define (rotate-image image)
  (let* ([width 1200]
         [height 1200]
         [new-image (image-new height width)])
    (image-select-rectangle! image REPLACE 0 0 width height)
    (gimp-edit-copy-visible image)
    (image-select-nothing! image)
    (let ([pasted-image (car (gimp-edit-paste (image-get-layer new-image) 1))])
      (gimp-item-transform-rotate-simple
       pasted-image 0 1 (/ width 2) (/ height 2))
      (gimp-image-flatten new-image)
      new-image)))

(define (rotate-tile t iterations)
  (if (equal? 0 iterations) t
      (rotate-tile (tile (rotate-image (tile-image t))
                         (tile-west t) (tile-north t)
                         (tile-east t) (tile-south t))
                   (- iterations 1))))

(define (add-rotations base-tiles)
  (for*/list ([i 4]
              [each-tile base-tiles])
    (rotate-tile each-tile i)))

(define (map-ref map-tiles x y)
  (list-ref (list-ref map-tiles x) y))

(define (map-width map-tiles)
  (length map-tiles))

(define (map-height map-tiles)
  (length (list-ref map-tiles 0)))

(define (has-north-neighbor y)
  (>= (- y 1) 0))

(define (north-neighbor map-tiles x y)
  (and (has-north-neighbor y)
       (map-ref map-tiles x (- y 1))))

(define (has-east-neighbor map-width x)
  (< (+ x 1) map-width))

(define (east-neighbor map-tiles x y)
  (and (has-east-neighbor (map-width map-tiles) x)
       (map-ref map-tiles (+ x 1) y)))

(define (has-south-neighbor map-height y)
  (< (+ y 1) map-height))

(define (south-neighbor map-tiles x y)
  (and (has-south-neighbor (map-height map-tiles))
       (map-ref map-tiles x (+ y 1))))

(define (has-west-neighbor x)
  (>= (- x 1) 0))

(define (west-neighbor map-tiles x y)
  (and (has-west-neighbor x)
       (map-ref (- x 1) y)))
