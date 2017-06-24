#lang rosette

(require gigls/unsafe
         "filters.rkt"
         "tile.rkt"
         "rating.rkt"
         "colorization.rkt"
         "../data/tile-database.rkt")

(define ratings (make-hasheq))
(define test-image (tile-image rotate-test-tile))

(define (learn-colorization term num-queries image)
  (let* ([existing-colorization (stored-or-null-colorization ratings term)]
         [improved-colorization (improve-colorization term
                                                      num-queries
                                                      image
                                                      existing-colorization)])
    (hash-set! ratings term improved-colorization)))


(define (improve-colorization term num-queries image rating)
  (if (<= num-queries 0) rating
      (improve-colorization term (- num-queries 1) image
                            (add-datapoint term image rating))))

(define (add-datapoint term image rating)
  (combined-rating rating (get-datapoint term image)))

(define (get-datapoint term image)
  (let ([colorization (random-colorization)])
    (show-sample-and-get-rating term image colorization)))

(define (show-sample-and-get-rating term image colorization)
  (image-show (colorize image colorization))
  (get-sample-rating term colorization))

(define (get-sample-rating term colorization)
  (let ([score (read)])
    (rating term colorization score)))

(define (apply-colorization term image)
  (image-show (colorize image (rating-colorization
                               (stored-colorization ratings term)))))

(define (stored-or-null-colorization ratings term)
  (or (stored-colorization ratings term) (null-rating term)))

(define (stored-colorization ratings term)
  (hash-ref ratings term #f))

(define (null-rating term)
  (rating term (random-colorization) 0))
