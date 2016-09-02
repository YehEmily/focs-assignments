#lang racket

;;; Student Name: Emily Yeh
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [X] I completed this assignment with assistance from Jamie Cho (not in FOCS) & Leon Lam (in FOCS)
;;;     and/or using these external resources: Racket Documentation & Stack Overflow
;;;    ADDITIONAL NOTE: I may have changed some of the return values to check if my functions really worked... I hope this isn't an inconvenience!

;;     NOTE:  You need not worry about error checking in the programs below.

;; 1.  WRITE SQUARE:  given n, returns n^2.  Hint:  use *
(define (square x)
  (* x x))
  
(display (square 2)) (newline)  ;; -> 4

;; 2.  WRITE is-right-triangle:  given three numbers, returns true iff the third
;;     could be the hypotenuse of a right triangle with the specified three side lengths
;;     Hint:  use = to compare numeric values

(define (is-right-triangle x y z)
  (if (equal? (+ (* x x) (* y y)) (* z z)) #t #f)
  )
  
(display (is-right-triangle 3 4 5)) (newline)  ;; -> #t
(display (is-right-triangle 4 5 6)) (newline)  ;; -> #f

;; 3.  WRITE FACTORIAL:  given n, returns n!
;;     Hint:  recursion is your friend
(define (fact n)
  (if(= 1 n) 1 (* n (fact (- n 1)))))

(display (fact 4)) (newline) ;; -> 1
(display (fact 5)) (newline) ;; -> 1

;; 4.  WRITE FIBONACCI:  given n, returns the nth fibonacci number as shown below
;;     Hint:  don't run this on really big numbers!
(define (fib n)
   (if (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2)))))

(display (fib 1)) (newline) ;; -> 1
(display (fib 2)) (newline) ;; -> 1
(display (fib 3)) (newline) ;; -> 2
(display (fib 4)) (newline) ;; -> 3
(display (fib 5)) (newline) ;; -> 5
(display (fib 6)) (newline) ;; -> 8

;; 5.  WRITE a procedure that takes a list of numbers and returns the sum of those numbers
;;     Hint:  first, rest, cons
(define (sum lst)
  (cond
    [(empty? lst) 0]
    [else (+ (first lst) (sum (rest lst)))]))

(display (sum '(1 2 3 4))) (newline) ;; -> 10
(display (sum '(1 20 300))) (newline) ;; -> 321

;; 6.  WRITE a procedure that takes a list of numbers and returns the largest one.
;;     While there are solutions using scheme's built-in max, we were actually hoping you'd do something else...
(define (my-max lst)
  (first(reverse(sort lst <))))

(display (my-max '(1 10 2 20 3))) (newline) ;; -> 20
