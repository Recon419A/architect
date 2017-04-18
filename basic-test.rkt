#lang racket

(require gigls/unsafe)

(define hallway-tile (image-load "/media/sf_Google_Drive/Map Generator/architect/Dungeon Tile 42.jpg"))

(define (overlay image background left top)
  (let ([right (+ left (image-width image))]
        [bottom (+ top (image-height image))])
    (image-compute (lambda (x y) (if (is-within x y left top right bottom)
                                     (image-get-pixel image (- x left) (- y top))
                                     (image-get-pixel background x y)))
                   (image-width background)
                   (image-height background))))

(define (is-within x y left top right bottom)
  (not (or (< x left)
           (< y top)
           (>= x right)
           (>= y bottom))))
