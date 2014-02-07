#lang racket

(provide (struct-out empty)
         (struct-out node)
         add-node)

(module+ test (require rackunit))

;; (Tree A) = (U (Node A) (Empty A))

;; A (Empty A) is a
;;   (root (A A -> Boolean))
(struct empty (<) #:transparent)
;; A (Node A) is a
;;   (node (U 'red 'black) A Tree Tree (A A -> Boolean))
(struct node (color value left right <) #:transparent)

;; add-node : (Tree A) A -> (Tree A)
(define (add-node t new-value)
  (match (ins-node t new-value)
    ((node _ v l r <)
     (node 'black v l r <))))

;; ins-node : (Tree A) A -> (Tree A)
(define (ins-node t new-value)
  (match t
    ((empty <)
     (node 'red new-value (empty <) (empty <) <))
    ((node c v l r <)
     (balance (if (< new-value v)
                  (node c v (ins-node l new-value) r <)
                  (node c v l (ins-node r new-value) <))))))

(module+ test
  (check-equal? (add-node (empty <) 3)
                (node 'black 3 (empty <) (empty <) <)
                "add a node to empty")
  (check-equal? (ins-node (add-node (empty <) 3) 4)
                (node 'black 3 (empty <) (node 'red 4 (empty <) (empty <) <) <)
                "add a node, and the ins a node (i.e. no balance)")
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

;; balance : (Tree A) -> (Tree A)
(define (balance t)
  (match t
    ((node 'black v
           (node 'red v-l
                 (node 'red v-ll node-lll node-llr <)
                 node-lr
                 <)
           node-r
           <)
     (node 'red v-l
           (node 'black v-ll
                 node-lll node-llr <)
           (node 'black v
                 node-lr node-r <)
           <))
    ((node 'black v
           (node 'red v-l
                 node-ll
                 (node 'red v-lr node-lrl node-lrr <)
                 <)
           node-r
           <)
     (node 'red v-lr
           (node 'black v-l
                 node-ll node-lrl <)
           (node 'black v
                 node-lrr node-r <)
           <))
    ((node 'black v
           node-l
           (node 'red v-r
                 (node 'red v-rl node-rll node-rlr <)
                 node-rr
                 <)
           <)
     (node 'red v-rl
           (node 'black v
                 node-l node-rll <)
           (node 'black v-r
                 node-rlr node-rr <)
           <))
    ((node 'black v
           node-l
           (node 'red v-r
                 node-rl
                 (node 'red v-rr node-rrl node-rrr <)
                 <)
           <)
     (node 'red v-r
           (node 'black v
                 node-l node-rl <)
           (node 'black v-rr
                 node-rrl node-rrr <)
           <))
    (_ t)))
