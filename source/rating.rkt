#lang racket

(require "colorization.rkt")

(provide rating combined-rating)

(define (rating term colorization score user)
  (hasheq 'term term 'colorization colorization 'score score 'user user))

(define (combined-rating rating-1 rating-2)
  (rating (rating-term rating-1)
          (combined-rating-colorization rating-1 rating-2)
          (combined-rating-score rating-1 rating-2)
          (rating-user rating-1)))

(define (combined-rating-colorization rating-1 rating-2)
  (combined-colorization (rating-colorization rating-1)
                         (rating-score rating-1)
                         (rating-colorization rating-2)
                         (rating-score rating-2)))

(define (combined-rating-score rating-1 rating-2)
  (+ (rating-score rating-1) (rating-score rating-2)))

(define (rating-term rating)
  (hash-ref rating 'term))

(define (rating-colorization rating)
  (hash-ref rating 'colorization))

(define (rating-score rating)
  (hash-ref rating 'score))

(define (rating-user rating)
  (hash-ref rating 'user))
