#lang rosette

(require gigls/unsafe
         "filters.rkt"
         "tile.rkt"
         "../data/tile-database.rkt")

(define colorization-pairings '())

(define (learn-colorization word num-queries image)
  (let ([hue-sum 0]
        [saturation-sum 0]
        [lightness-sum 0]
        [weight-sum 0])
    (for ([i num-queries])
      (let ([hue (random 360)]
            [saturation (random 100)]
            [lightness (random 100)])
        (image-show (colorize image hue saturation lightness))
        (let ([weight (read)])
          (set! hue-sum (+ hue-sum (* weight hue)))
          (set! saturation-sum (+ saturation-sum (* weight saturation)))
          (set! lightness-sum (+ lightness-sum (* weight lightness)))
          (set! weight-sum (+ weight-sum weight)))))
    (let* ([hue (/ hue-sum weight-sum)]
           [saturation (/ saturation-sum weight-sum)]
           [lightness (/ lightness-sum weight-sum)]
           [learned-colorization (list hue saturation lightness)]
           [colorization-pairing (list word learned-colorization)]
           [colorized-image (colorize image hue saturation lightness)])
      (set! colorization-pairings (cons colorization-pairing
                                        colorization-pairings))
      (image-show colorized-image)
      colorized-image)))
