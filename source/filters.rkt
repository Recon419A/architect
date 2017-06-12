#lang rosette

(require gigls/unsafe)

(provide colorize)

(define (colorize image map-height map-width hue saturation lightness)
  (let* ([width (* map-width 1200)]
         [height (* map-height 1200)]
         [new-image (image-new height width)])
    (image-select-rectangle! image REPLACE 0 0 width height)
    (gimp-edit-copy-visible image)
    (image-select-nothing! image)
    (let ([pasted-image (car (gimp-edit-paste (image-get-layer new-image) 1))])
      (gimp-colorize pasted-image hue saturation lightness)
      (gimp-image-flatten new-image)
      new-image)))
