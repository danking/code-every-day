#lang racket

(require rackunit
         "mergesort.rkt")

(define (test-mergesort ls)
  (mergesort ls <=))

(check-equal? (test-mergesort '()) '())
(check-equal? (test-mergesort '(1)) '(1))
(check-equal? (test-mergesort '(1 2 3)) '(1 2 3))
(check-equal? (test-mergesort '(2 3 1)) '(1 2 3))
(check-equal? (test-mergesort '(2 1 3)) '(1 2 3))
(check-equal? (test-mergesort '(3 2 1)) '(1 2 3))
(check-equal? (test-mergesort '(-3 2 1)) '(-3 1 2))
(check-equal? (test-mergesort '(10 100 42 -5 5)) '(-5 5 10 42 100))
(check-equal? (test-mergesort '(2 5 10 1 5)) '(1 2 5 5 10))
