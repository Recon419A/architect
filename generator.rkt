#lang rosette

(require gigls/unsafe)
(require "tile-database.rkt")
(require "choice.rkt" "assert.rkt")

(define (rotate tile-1 iterations)
  (if (equal? 0 iterations) tile
      (rotate (tile (gimp-item-transform-rotate-simple (tile-image tile-1)
                                                       0 #t 600 600)
                    (tile-east tile-1) (tile-south tile-1)
                    (tile-west tile-1) (tile-north tile-1))
              (- iterations 1))))

(define (add-rotations tiles-db)
  (let ([new-db '()])
    (for ([i 4]
          [each-tile tiles-db])
      (cons new-db (rotate each-tile i)))
    new-db))

(define (valid! a-tile north-neighbor east-neighbor)
  (equal! (tile-north a-tile) (tile-south north-neighbor))
  (equal! (tile-east a-tile) (tile-west east-neighbor)))

(define (map-valid! columns)
  (let ([width (length columns)]
        [height (length (list-ref columns 0))])
    (for ([center-column (range (- width 1))]
          [center-row (range (- height 1))])
      (let ([north-row (+ center-row 1)]
            [east-column (+ center-column 1)]
            [south-row (- center-row 1)]
            [west-column (- center-column 1)])
        (valid! (list-ref (list-ref columns center-column) center-row)
                (list-ref (list-ref columns center-column) north-row)
                (list-ref (list-ref columns east-column) center-row))))))
;;                (list-ref (list-ref columns center-column) south-row)
;;                (list-ref (list-ref columns west-column) center-row))))))

(define (make-map width height)
  (let ([the-map (initialize-map width height)])
    (map-valid! the-map)
    (evaluate the-map (solve asserts))))

(define (initialize-map width height)
  (if (equal? 0 width) null
      (cons (initialize-column height) (initialize-map (- width 1) height))))

(define (initialize-column height)
  (if (equal? 0 height) null
      (cons (choose-random tiles) (initialize-column (- height 1)))))

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

(image-show (show-map (make-map 4 4)))
