#lang racket

(require gigls/unsafe)

(define hallway (image-show (image-load "/media/sf_Google_Drive/Map Generator/architect/Dungeon Tile 42.jpg")))
;; (define fortress (image-show (image-new 1400 1400)))
;; (image-select-rectangle! hallway REPLACE 0 0 1200 1200)
;; (gimp-edit-copy-visible hallway)
;; (image-select-nothing! hallway)
;; (image-select-rectangle! fortress REPLACE 200 200 1200 1200)
;; (gimp-edit-paste (image-get-layer fortress) 1)

;; (define (overlay image background left top)
;;   (let ([right (+ left (image-width image))]
;;         [bottom (+ top (image-height image))])
;;     (image-compute (lambda (x y) (if (is-within x y left top right bottom)
;;                                      (image-get-pixel image (- x left) (- y top))
;;                                      (image-get-pixel background x y)))
;;                    (image-width background)
;;                    (image-height background))))

;; (define (overlay image background left top)
;;   (region-calculate-pixels! background left top (image-width image) (image-height image)
;;                           (lambda (col row) (image-get-pixel image col row))))

;; (define (overlay image background left top)
;;   (for* ([x (in-range (image-width image))]
;;          [y (in-range (image-height image))])
;;     (image-set-pixel! background (+ x left) (+ y top) (image-get-pixel image x y))))

;; (define (is-within x y left top right bottom)
;;   (not (or (< x left)
;;            (< y top)
;;            (>= x right)
;;            (>= y bottom))))
