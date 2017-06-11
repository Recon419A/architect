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
         west-neighbor
         valid?)

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

(define (map-ref map-tiles row column)
  (list-ref (list-ref map-tiles row) column))

(define (map-width map-tiles)
  (length (list-ref map-tiles 0)))

(define (map-height map-tiles)
  (length map-tiles))

(define (has-north-neighbor row)
  (>= (- row 1) 0))

(define (north-neighbor map-tiles row column)
  (and (has-north-neighbor row)
       (map-ref map-tiles (- row 1) column)))

(define (has-east-neighbor map-width column)
  (< (+ column 1) map-width))

(define (east-neighbor map-tiles row column)
  (and (has-east-neighbor (map-width map-tiles) column)
       (map-ref map-tiles row (+ column 1))))

(define (has-south-neighbor map-height row)
  (< (+ row 1) map-height))

(define (south-neighbor map-tiles row column)
  (and (has-south-neighbor (map-height map-tiles) row)
       (map-ref map-tiles (+ row 1) column)))

(define (has-west-neighbor column)
  (>= (- column 1) 0))

(define (west-neighbor map-tiles row column)
  (and (has-west-neighbor column)
       (map-ref map-tiles row (- column 1))))

(define (valid? map-tiles)
  (let ([map-height (map-height map-tiles)]
        [map-width (map-width map-tiles)])
    (and (for*/and ([row (range map-height)]
                    [column (range (- map-width 1))])
           (equal? (tile-east (map-ref map-tiles row column))
                   (tile-west (map-ref map-tiles row (+ column 1)))))
         (for*/and ([row (range (- map-height 1))]
                    [column (range map-width)])
           (equal? (tile-south (map-ref map-tiles row column))
                   (tile-north (map-ref map-tiles (+ row 1) column)))))))
