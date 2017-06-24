#lang rosette

(require gigls/unsafe)

(provide colorize)

(define (colorize image colorization)
  (let* ([new-image (blank-copy image)]
         [pasted-image (pasted-copy image new-image)])
    (apply gimp-colorize pasted-image colorization)
    (gimp-image-flatten new-image)
    new-image))

(define (pasted-copy image blank-image)
  (copy image)
  (car (gimp-edit-paste (image-get-layer blank-image) 1)))

(define (blank-copy image)
  (image-new (image-height image)
             (image-width image)))

(define (copy image)
  (select-all image)
  (gimp-edit-copy-visible image)
  (image-select-nothing! image))

(define (select-all image)
  (image-select-rectangle! image REPLACE 0 0
                           (image-width image)
                           (image-height image)))

(define (image-height image)
  (car (gimp-image-height image)))

(define (image-width image)
  (car (gimp-image-width image)))
