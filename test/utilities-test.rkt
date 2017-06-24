#lang rosette

(require gigls/unsafe
         rackunit
         "../source/utilities.rkt"
         "../source/tile.rkt"
         "../data/tile-database.rkt")

(define (smoke-test-rotate-image)
  (image-show (tile-image test-tile))
  (image-show (rotate-image (tile-image test-tile))))

(define (smoke-test-add-rotations)
  (for ([each-tile (add-rotations (list test-tile))])
    (image-show (tile-image each-tile))))

(test-case "rotate-tile should rotate borders properly"
 (let ([rotated-tile (rotate-tile test-tile 1)])
   (check-equal? (tile-north test-tile) (tile-east rotated-tile))
   (check-equal? (tile-east test-tile) (tile-south rotated-tile))
   (check-equal? (tile-south test-tile) (tile-west rotated-tile))
   (check-equal? (tile-west test-tile) (tile-north rotated-tile))))

(test-case "add-rotations should return four rotations"
  (check-equal? (length (add-rotations (list test-tile))) 4))

(define test-map-1 '((1 2)
                     (3 4)))

(test-case "map-ref should use row-column indexing"
  (check-equal? (map-ref test-map-1 0 0) 1)
  (check-equal? (map-ref test-map-1 0 1) 2)
  (check-equal? (map-ref test-map-1 1 0) 3)
  (check-equal? (map-ref test-map-1 1 1) 4))

(test-case "north-neighbor should return #f for northmost row"
  (check-equal? (north-neighbor test-map-1 0 0) #f)
  (check-equal? (north-neighbor test-map-1 0 1) #f))

(test-case "north-neighbor should return north neighbor"
           (check-equal? (north-neighbor test-map-1 1 0) 1)
           (check-equal? (north-neighbor test-map-1 1 1) 2))

(test-case "east-neighbor should return #f for eastmost column"
  (check-equal? (east-neighbor test-map-1 0 1) #f)
  (check-equal? (east-neighbor test-map-1 1 1) #f))

(test-case "east-neighbor should return east neighbor"
  (check-equal? (east-neighbor test-map-1 0 0) 2)
  (check-equal? (east-neighbor test-map-1 1 0) 4))

(test-case "south-neighbor should return #f for southmost column"
  (check-equal? (south-neighbor test-map-1 1 0) #f)
  (check-equal? (south-neighbor test-map-1 1 1) #f))

(test-case "south-neighbor should return south neighbor"
  (check-equal? (south-neighbor test-map-1 0 0 3)
  (check-equal? (south-neighbor test-map-1 0 1) 4)))

(test-case "west-neighbor should return #f for westmost column"
  (check-equal? (west-neighbor test-map-1 0 0) #f)
  (check-equal? (west-neighbor test-map-1 1 0) #f))

(test-case "west-neighbor should return west neighbor"
  (check-equal? (west-neighbor test-map-1 0 1) 1)
  (check-equal? (west-neighbor test-map-1 1 1) 3))

(define test-map-2 '((1 2)
                     (3 4)
                     (5 6)))

(test-case "map-width should return the number of columns"
  (check-equal? (map-width test-map-2) 2))

(test-case "map-height should return the number of rows"
  (check-equal? (map-height test-map-2) 3))
