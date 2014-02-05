#lang typed/racket

(provide mergesort)

(: mergesort : (All (X) ([Listof X] [X X -> Boolean] -> [Listof X])))
(define (mergesort ls <=)
  (: mergesort/length : ([Listof X] Integer -> [Listof X]))
  (define (mergesort/length ls n)
    (let* ([n/2 (exact-floor (/ n 2))])
      (cond [(= n 0) ls]
            [(= n 1) ls]
            [else (merge (mergesort/length (take ls n/2) n/2)
                         (mergesort/length (drop ls n/2) (- n n/2))
                         <=)])))
  (mergesort/length ls (length ls)))

(: merge : (All (C) ([Listof C] [Listof C] [C C -> Boolean] -> [Listof C])))
(define (merge a b <=)
  (cond [(empty? a) b]
        [(empty? b) a]
        [(<= (first a) (first b))
         (cons (first a) (merge (rest a) b <=))]
        [else
         (cons (first b) (merge a (rest b) <=))]))
