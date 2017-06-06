#lang rosette

(require (for-syntax racket/match))

(provide equal! not-equal! in! not-in!)

(define-syntax (equal! stx)
  (match (syntax->list stx)
    [(list name symbol value)
     (datum->syntax stx `(assert (equal? ,symbol ,value )))]))

(define-syntax (not-equal! stx)
  (match (syntax->list stx)
    [(list name symbol value)
     (datum->syntax stx `(assert (not (equal? ,symbol ,value ))))]))

(define-syntax (in! stx)
  (match (syntax->list stx)
    [(list name symbol possible-values)
     (datum->syntax stx `(assert (member ,symbol (shuffle ,possible-values ))))]))

(define-syntax (not-in! stx)
  (match (syntax->list stx)
    [(list name symbol impossible-values)
     (datum->syntax stx `(assert (not (member ,symbol (shuffle ,impossible-values )))))]))
