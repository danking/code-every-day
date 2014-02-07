#lang racket

(require rackunit
         rackunit/text-ui
         "red-black-trees-typed.rkt")

(define-test-suite red-black-trees-typed
 (check-equal? (add-node (empty <) 3)
               (node 'black 3 (empty <) (empty <) <)
               "add a node to empty")
 (check-equal? (add-node (add-node (empty <) 3) 4)
               (node 'black 3 (empty <) (node 'red 4 (empty <) (empty <) <) <)
               "add two nodes")
 (check-equal? (add-node (add-node (add-node (empty <) 3) 4) 5)
               (node 'black 4
                     (node 'black 3
                           (empty <)
                           (empty <)
                           <)
                     (node 'black 5
                           (empty <)
                           (empty <)
                           <)
                     <)
               "add three nodes")
 (check-equal? (add-node (add-node (add-node (add-node (empty <) 3) 4) 5) 1)
               (node 'black 4
                     (node 'black 3
                           (node 'red 1
                                 (empty <)
                                 (empty <)
                                 <)
                           (empty <)
                           <)
                     (node 'black 5
                           (empty <)
                           (empty <)
                           <)
                     <)
               "add four nodes"))

(run-tests red-black-trees-typed)

