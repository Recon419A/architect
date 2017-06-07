#lang racket

(require gigls/unsafe)

(provide tiles tile tile-image tile-north tile-east tile-south tile-west)

(struct tile (image north east south west))

(define prefix "/home/recon/Dropbox/architect/Hallways/")

;; Numeric values for edge types
;; 0: solid edge
;; 1: two open squares in center of edge

(define tile-001 (tile (image-load (string-append prefix "Dungeon Tile 01.jpg"))
                       1 0 1 0))
(define tile-002 (tile (image-load (string-append prefix "Dungeon Tile 02.jpg"))
                       0 1 1 0))
(define tile-003 (tile (image-load (string-append prefix "Dungeon Tile 03.jpg"))
                       0 0 1 0))
(define tile-004 (tile (image-load (string-append prefix "Dungeon Tile 04.jpg"))
                       0 1 1 1))
(define tile-010 (tile (image-load (string-append prefix "Dungeon Tile 10.jpg"))
                       0 0 0 0))
(define tile-020 (tile (image-load (string-append prefix "Dungeon Tile 20.jpg"))
                       1 1 1 1))

(define tiles (list tile-001 tile-002 tile-003 tile-004 tile-010 tile-020))
