#lang rosette

(require gigls/unsafe)

(provide colorize)

(define (colorize image colorization)
  (let* ([width (car (gimp-image-width image))]
         [height (car (gimp-image-height image))]
         [new-image (image-new height width)])
    (image-select-rectangle! image REPLACE 0 0 width height)
    (gimp-edit-copy-visible image)
    (image-select-nothing! image)
    (let ([pasted-image (car (gimp-edit-paste (image-get-layer new-image) 1))])
      (apply gimp-colorize pasted-image colorization)
      (gimp-image-flatten new-image)
      new-image)))
