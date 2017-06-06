#lang rosette

(require rosette/lib/angelic
         "assert.rkt")

(provide choose-random random-instance)

(define (random-instance struct-name fields-options)
  (let ([field-values (for/list ([field-options fields-options])
                        (let ([chosen-value (choose-random field-options)])
                          (assert (member chosen-value field-options))
                          chosen-value))])
    (apply struct-name field-values)))

(define (choose-random choices)
  (let ([choice (apply choose* (shuffle (cons (gensym) (cons (gensym) choices))))])
    (in! choice choices)
    choice))
