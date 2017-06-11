#lang rosette

(require gigls/unsafe
         "rosette-pcg-utilities/source/choice.rkt"
         "rosette-pcg-utilities/source/assert.rkt"
         "tile.rkt"
         "utilities.rkt")

(provide make-map
         render-map)

(define (make-map tiles map-height map-width)
  (clear-asserts!)
  (let ([map-tiles (initialize-map tiles map-height map-width)])
    (for* ([row (range map-height)]
           [column (range (- map-width 1))])
      (equal! (tile-east (map-ref map-tiles row column))
              (tile-west (map-ref map-tiles row (+ column 1)))))
    (for* ([row (range (- map-height 1))]
           [column (range map-width)])
      (equal! (tile-south (map-ref map-tiles row column))
              (tile-north (map-ref map-tiles (+ row 1) column))))
    (evaluate map-tiles (solve asserts))))



(define (initialize-map tiles map-height map-width)
  (if (equal? 0 map-height) null
      (cons (initialize-row tiles map-width)
            (initialize-map tiles (- map-height 1) map-width))))

(define (initialize-row tiles map-width)
  (if (equal? 0 map-width) null
      (cons (choose-random tiles) (initialize-row tiles (- map-width 1)))))

(define (render-map map-tiles)
  (let* ([map-height (map-height map-tiles)]
         [map-width (map-width map-tiles)]
         [map-image (image-new (* 1200 map-width) (* 1200 map-height))])
    (for* ([row (range map-height)]
           [column (range map-width)])
      (let ([current-tile (map-ref map-tiles row column)])
        (image-select-rectangle! (tile-image current-tile)
                                 REPLACE 0 0 1200 1200)
        (gimp-edit-copy-visible (tile-image current-tile))
        (image-select-nothing! (tile-image current-tile))
        (image-select-rectangle! map-image REPLACE
                                 (* column 1200) (* row 1200)
                                 1200 1200)
        (gimp-edit-paste (image-get-layer map-image) 1)
        (gimp-image-flatten map-image)))
    (image-select-nothing! map-image)
    map-image))
