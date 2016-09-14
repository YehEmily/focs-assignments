#lang racket

;;;;;;;;;;
;;; Day 3 in class work - Emily Yeh

;;;;;;;;;;
;; 0.  Implement factorial both recursively and tail recursively.
;;     Hint:  The tail recursive version will use a helper function.

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 5)

;;;;;;;;;;;
;; 1.  Filter is built in to scheme.

;; (filter even? '(1 2 3 4 5 6))  --> '(2 4 6)  ;; using the built-in even?
;; (filter teen? '(21 17 2 13 4 42 2 16 3)) --> '(17 13 16)
;; assuming (define (teen x) (and (<= 13 x) (<= x 19)))))
;; (filter list? '(3 (3 2 1) symbol (4 2) (1 (2) 3)) --> '((3 2 1) (4 2) (1 (2) 3))

;; Implement it anyway.  You might want to call it my-filter?  What arguments does it take?

(define (my-filter pred lst)
  (if (null? lst)
      lst
      (if (pred (first lst))
          (cons (first lst) (my-filter pred(rest lst))) (my-filter pred (rest lst)))))

(my-filter even? '(1 2 3 4 5 6))

;;;;;;;;;;;
;; 2.  Map is also built in to scheme.

;; (map double '(1 2 3))  --> '(4 5 6)  ;; assuming (define (double x) (* 2 x))
;; (map incr '(1 2 3)) --> '(2 3 4)     ;; assuming (define (incr x) (+ x 1))
;; (map last '((3 2 1) (4 2) (1 2 3)) --> '(1 2 3)
;; assuming (define (last lst)
;;            (if (null? (rest lst))
;;                (first lst)
;;                (last (rest lst))))
(define (double x) (* 2 x))

(define (incr x) (+ x 1))

(define (my-map v lst)
  (if (null? lst)
      lst
      (cons (v (first lst)) (my-map v (rest lst))))
  )


(my-map double '(1 2 3))
(my-map incr '(1 2 3))

;; Implement it as well.  You might want to call it my-map.  What arguments does it take?

;;;;;;;;;;;
;; 3.  While we're reimplementing built-ins, implement my-append (just like built in append)
;;     It takes two lists and returns a list containing all of the elements of the originals, in order.
;;     Note that it is purely functional, i.e., it doesn't MODIFY either of the lists that it is passed.

;; (append '(1 2 3) '(4 5 6)) --> '(1 2 3 4 5 6)

;; You might want to draw out the box and pointer structures for the original two lists
;; as well as for the new list.  Confirm with a member of the instructional staff....

(define (my-append a1 a2)
  (if (and (null? a1) (null? a2))
      a1
      (cons (list (first a1) (first a2)) (my-append (rest a1) (rest a2)))
      )
  )

;    [(cons? lst) (cons (first lst) (my-append (rest lst) a))]))

(my-append '(1 2 3) '(4 5 6)) ; this returns a list of pairs.. i don't know how to fix this ):

;;;;;;;;;;;
;; 4.  zip takes two lists, and returns a list of elements of size two, until one of the lists runs out.

;; (zip '(1 2 3) '(4 5 6)) ;; --> '((1 4) (2 5) (3 6))
;; (zip '(1 2 3) '(a b c d e f g)) ;; --> '((1 a) (2 b) (3 c))

;; Implement `zip`.

(define (my-zip a1 a2)
  (my-zip-helper a1 a2 empty))

(define (my-zip-helper a1 a2 accumulator)
  (cond [(null? a1) accumulator]
        [(null? a2) accumulator]
        [else (my-zip-helper (rest a1) (rest a2) (cons (list (first a1) (first a2)) accumulator))]))


(my-zip '(1 2 3) '(4 5 6 7 8))
(my-zip '(1 2 3) '(a b c d e f g))

;;;;;;;;;;;;
;; 5.  Last built-in (for now):  (my-)reverse.
;;     Takes a list, returns a new list with the elements reversed.

;; (reverse '(1 2 3)) --> '(3 2 1)

(define (my-reverse lst)
  (if (null? lst)
      lst
      (cons (last lst) (my-reverse (rest lst)))))

(reverse '(1 2 3))

;;;;;;;;;;;;
;; More puzzles:
;;
;;  - (count elt lst) returns the number of times that elt appears in lst
;;  - (remove-dups lst) returns a new list that contains the elements of lst but without repeats
;;       (remove-dups '(1 2 3 1 4 5 2 4 6)) --> '(1 2 3 4 5 6)
;;  - reverse reverses a list, but doesn't reverse sublists in a tree.  (Try it and see.)
;;    Write deep-reverse, which reverses all sublists as well.
;;  - Which of these can you implement using tail recursion?
