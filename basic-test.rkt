#lang racket

(require gigls/unsafe)

(define hallway-six (image-show (image-load "/home/recon/Dropbox/architect/Hallways/Dungeon Tile 42.jpg")))

(define (hallway repetitions)
  (let ([hallway-tile (image-load "/home/recon/Dropbox/architect/Hallways/Dungeon Tile 42.jpg")]
        [blank-image (image-new 1200 (* repetitions 1200))])

    (image-select-rectangle! hallway-tile REPLACE 0 0 1200 1200)
    (gimp-edit-copy-visible hallway-tile)
    (image-select-nothing! hallway-tile)

    (for ([i repetitions])
      (image-select-rectangle! blank-image REPLACE 0 (* i 1200)
                              1200 1200)
      (gimp-edit-paste (image-get-layer blank-image) 1)
      (gimp-image-flatten blank-image))
    (image-select-nothing! blank-image)
    blank-image))

(image-show (hallway 2))
