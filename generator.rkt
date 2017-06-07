#lang rosette

(require gigls/unsafe)
(require "tile-database.rkt")
(require "choice.rkt" "assert.rkt")

(define (rotate tile-1)
  (tile (gimp-item-transform-rotate-simple (tile-image tile-1) 0 #t 600 600)
        (tile-east tile-1) (tile-south tile-1)
        (tile-west tile-1) (tile-north tile-1)))

(define (valid! tile-1))

;; (define (valid tile-1 north-neighbor east-neighbor num-rotations)    ;;
;;   (assert (or (and (or (null? north-neighbor)                        ;;
;;                        (equal? (tile-south north-neighbor)           ;;
;;                                (tile-north tile-1)))                 ;;
;;                    (or (null? east-neighbor)                         ;;
;;                        (equal? (tile-west east-neighbor)             ;;
;;                                (tile-east tile-1))))                 ;;
;;               (and (< 3 num-rotations)                               ;;
;;                    (valid (rotate tile) north-neighbor east-neighbor ;;
;;                           (+ 1 num-rotations))))))                   ;;


;; (define (valid-map map-tiles)
;;   (let ([width (length map-tiles)]
;;         [height (length (list-ref map-tiles 0))])
;;     (for/and ([column (range width)]
;;               [row (range height)])
;;       (valid (list-ref (list-ref map-tiles column) row)
;;              (if (equal? row (- height 1)) null
;;                  (list-ref (list-ref map-tiles (+ column 1)) (+ row 1)))
;;              (if (equal? column (- width 1)) null
;;                  (list-ref (list-ref map-tiles (+ column 1)) (+ row 1)))
;;              0))))

(define (make-map width height)
  (let ([the-map (initialize-map width height)])
    (valid-map the-map)
    (solve asserts)
    the-map))

(define (initialize-map width height)
  (if (equal? 0 width) null
      (cons (initialize-column height) (initialize-map (- width 1) height))))

(define (initialize-column height)
  (if (equal? 0 height) null
      (cons (choose-random tiles) (initialize-column (- height 1)))))

(make-map 2 2)
