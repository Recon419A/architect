#lang racket

(define (colorization hue saturation lightness)
  (hasheq 'hue hue 'saturation saturation 'lightness lightness))

(define (colorization-hue colorization)
  (hash-ref colorization 'hue))

(define (colorization-saturation colorization)
  (hash-ref colorization 'saturation))

(define (colorization-lightness colorization)
  (hash-ref colorization 'lightness))
