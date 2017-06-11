#lang rosette

(require gigls/unsafe
         "rosette-pcg-utilities/source/choice.rkt"
         "rosette-pcg-utilities/source/assert.rkt"
         "tile.rkt"
         "utilities.rkt"
         "../data/tile-database.rkt")

(provide make-map)

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

(define (make-map map-height map-width)
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

(define (show-map a-map)
  (let* ([width (length a-map)]
         [height (length (list-ref a-map 0))]
         [blank-image (image-new (* 1200 width) (* 1200 height))])
    (for* ([column (range width)]
           [row (range height)])
      (let ([current-tile (list-ref (list-ref a-map column) row)])
        (image-select-rectangle! (tile-image current-tile)
                                 REPLACE 0 0 1200 1200)
        (gimp-edit-copy-visible (tile-image current-tile))
        (image-select-nothing! (tile-image current-tile))
        (image-select-rectangle! blank-image REPLACE
                                 (* column 1200) (* row 1200)
                                 1200 1200)
        (gimp-edit-paste (image-get-layer blank-image) 1)
        (gimp-image-flatten blank-image)))
    (image-select-nothing! blank-image)
    blank-image))

;; (define a-map (make-map 3 3))

;; (image-show (show-map a-map))

;; (image-show (tile-image (list-ref tiles 1)))

;; (image-show (tile-image (rotate (list-ref tiles 1) 1)))
