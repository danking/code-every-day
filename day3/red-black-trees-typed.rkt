#lang typed/racket

(provide (struct-out empty)
         (struct-out node)
         add-node)

(define-type Color (U 'red 'black))

(struct: (A) empty
         ([< : (A A -> Boolean)])
         #:transparent)
(struct: (B) node
         ([color : Color]
          [value : B]
          [left  : (Tree B)]
          [right : (Tree B)]
          [<     : (B B -> Boolean)])
         #:transparent)

(define-type (Empty A) (empty A))
(define-type (Node A) (node A))
(define-type (Tree A) (U (Node A) (Empty A)))

(: add-node : (All (A) (Tree A) A -> (Tree A)))
(define (add-node t new-value)
  (match (ins-node t new-value)
    ((node _ v l r <)
     (node 'black v l r <))))

(: ins-node : (All (A) (Tree A) A -> (Tree A)))
(define (ins-node t new-value)
  (match t
    ((empty <)
     (node 'red new-value (empty <) (empty <) <))
    ((node c v l r <)
     (balance (if (< new-value v)
                  (node c v (ins-node l new-value) r <)
                  (node c v l (ins-node r new-value) <))))))

(: balance : (All (A) (Tree A) -> (Tree A)))
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
