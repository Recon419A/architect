#lang rosette

(provide tile tile-image tile-north tile-east tile-south tile-west)

(struct tile (image north east south west))
