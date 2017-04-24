#lang racket

(require gigls/unsafe)

(define hallway-six (image-show (image-load "/media/sf_Google_Drive/Map Generator/architect/Dungeon Tile 42.jpg")))
;; (define fortress (image-show (image-new 1400 1400)))
;; (image-select-rectangle! hallway REPLACE 0 0 1200 1200)
;; (gimp-edit-copy-visible hallway)
;; (image-select-nothing! hallway)
;; (image-select-rectangle! fortress REPLACE 200 200 1200 1200)
;; (gimp-edit-paste (image-get-layer fortress) 1)

(define (hallway length)
  (let ([hallway-tile (image-load "/media/sf_Google_Drive/Map Generator/architect/Dungeon Tile 42.jpg")]
        [blank-image (image-new 1200 (* length 200))])
    (image-select-rectangle! hallway-tile REPLACE 0 0 1200 1200)
    (gimp-edit-copy-visible hallway-tile)
    (image-select-nothing! hallway-tile)
    (for ([i (/ length 6)])
      (image-select-rectangle! blank-image REPLACE 0 (* i 1200)
                              1200 1200)
      (gimp-edit-paste (image-get-layer blank-image) 1))
    blank-image))

(image-show (hallway 24))
