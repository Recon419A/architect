#lang rosette

(require gigls/unsafe
         "tile.rkt")

(provide rotate-image
         rotate-tile
         add-rotations)

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
