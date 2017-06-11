#lang rosette

(require gigls/unsafe
         "rosette-pcg-utilities/choice.rkt"
         "rosette-pcg-utilities/assert.rkt"
         "utilities.rkt"
         "../data/tile-database.rkt")

(define (valid! a-tile north-neighbor east-neighbor
                south-neighbor west-neighbor)
  (and north-neighbor (equal! (tile-north a-tile) (tile-south north-neighbor)))
  (and east-neighbor (equal! (tile-east a-tile) (tile-west east-neighbor)))
  (and south-neighbor (equal! (tile-south a-tile) (tile-north south-neighbor)))
  (and west-neighbor (equal! (tile-west a-tile) (tile-east west-neighbor))))

(define (map-valid! columns)
  (let ([width (length columns)]
        [height (length (list-ref columns 0))])
    (for ([x (range width)]
          [y (range height)])
      (let ([center-tile (map-ref columns x y)]
            [north-neighbor (map-ref columns x (- y 1))]
            [east-neighbor (map-ref columns (+ x 1) y)]
            [south-neighbor (map-ref columns x (+ y 1))]
            [west-neighbor (map-ref columns (- x 1) y)])))))

(define (ref-null lst index)
  (cond [(equal? #f lst) #f]
        [(< index 0) #f]
        [(>= index (length lst)) #f]
        [#t (list-ref lst index)]))

(define (make-map width height)
  (let ([the-map (initialize-map width height tiles)])
    (map-valid! the-map)
    (evaluate the-map (solve asserts))))

(define (initialize-map width height tiles)
  (if (equal? 0 width) null
      (cons (initialize-column height tiles) (initialize-map (- width 1) height tiles))))

(define (initialize-column height tiles)
  (if (equal? 0 height) null
      (cons (choose-random tiles) (initialize-column (- height 1) tiles))))

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

(define a-map (make-map 3 3))

(image-show (show-map a-map))

;; (image-show (tile-image (list-ref tiles 1)))

;; (image-show (tile-image (rotate (list-ref tiles 1) 1)))
