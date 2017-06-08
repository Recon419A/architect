#lang rosette

(provide point points point-x point-y point-z)

(struct point (x y z))

(define a (point 1 2 3))
(define b (point 3 4 3))
(define c (point 5 6 3))
(define d (point 7 8 3))
(define e (point 9 10 0))

(define points (list a b c d e))
