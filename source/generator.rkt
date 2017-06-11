#lang rosette

(require gigls/unsafe
         "rosette-pcg-utilities/source/choice.rkt"
         "rosette-pcg-utilities/source/assert.rkt"
         "tile.rkt"
         "utilities.rkt")

(provide make-map
         render-map)

(define (valid! map-tiles row column)
  (let ([map-tile (map-ref map-tiles row column)]
        [north-neighbor (north-neighbor map-tiles row column)]
        [east-neighbor (east-neighbor map-tiles row column)]
        [south-neighbor (south-neighbor map-tiles row column)]
        [west-neighbor (west-neighbor map-tiles row column)])
    (and north-neighbor
         (equal! (tile-north map-tile) (tile-south north-neighbor)))
    (and east-neighbor
         (equal! (tile-east map-tile) (tile-west east-neighbor)))
    (and south-neighbor
         (equal! (tile-south map-tile) (tile-north south-neighbor)))
    (and west-neighbor
         (equal! (tile-west map-tile) (tile-east west-neighbor)))))

(define (map-valid! map-tiles)
  (for ([row (range (map-height map-tiles))]
        [column (range (map-width map-tiles))])
    (valid! map-tiles row column)))

(define (make-map tiles map-height map-width)
  (let ([the-map (initialize-map tiles map-height map-width)])
    (map-valid! the-map)
    (evaluate the-map (solve asserts))))

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
