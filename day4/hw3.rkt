#lang racket

;;; Student Name: Emily Yeh
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [X] I completed this assignment with assistance from Leon
;;;     and/or using these external resources: Stack Overflow, Racket Documentation
;;;
;;; ADDITIONAL NOTE: I spent several hours on this assignment, mainly because I just
;;; had a ridiculously hard time debugging my code. (Although I probably should have known that
;;; extra parentheses can cause problems in a language like Racket,,.)
;;; I'm still not sure if my evaluator solution can handle all the cases that it should,
;;; but it /can/ do the IPH thing (albeit on really basic equations).
;;; Also, I borrowed the code for evaluator from the hw2 solutions :D

;;;;;;;;;;;
;; 1. assq

;; `assq` is a function that takes a key and an association list.
;;
;; It returns the corresponding key/value pair from the list
;; (*i.e.*, the pair whose key is *eq?* to the one it is given).
;;
;; If the key is not found in the list, `assq` returns `#f`.

(define operator-list
  (list (list 'ADD +)
        (list 'SUB -)
        (list 'MUL *)
        (list 'DIV /)
        (list 'GT >)
        (list 'LT <)
        (list 'GE >=)
        (list 'LE <=)
        (list 'EQ =)
        (list 'NEQ (lambda (x y) (not (= x y))))
        (list 'ANND (lambda (x y) (and x y)))
        (list 'ORR (lambda (x y) (or x y)))
        (list 'NOTT not)))

(define (my-assq OP lst)
  (if (null? lst)
      #f
      (assoc OP lst))) ; assoc is like member, except it also finds out where the element lives

(my-assq 'ADD operator-list) ;--> '(ADD #<procedure:+>)
(my-assq 'ANND operator-list) ;'(ANND #<procedure>)
(my-assq 'FOO operator-list) ;--> #f
(my-assq 'EQ operator-list) ;--> '(EQ #<procedure:=>)

;;;;;;;;;;;
;; 2. lookup-list

;; Add the ability to look up symbols to your evaluator.
;;
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

(define (apply-operator op args)
  (cond [(eq? op 'ADD) (+ (first args) (second args))]
        [(eq? op 'SUB) (- (first args) (second args))]
        [(eq? op 'MUL) (* (first args) (second args))]
        [(eq? op 'DIV) (/ (first args) (second args))]
        [(eq? op 'GT) (> (first args) (second args))]
        [(eq? op 'LT) (< (first args) (second args))]
        [(eq? op 'GE) (>= (first args) (second args))]
        [(eq? op 'LE) (<= (first args) (second args))]
        [(eq? op 'EQ) (= (first args) (second args))]
        [(eq? op 'NEQ) (not (= (first args) (second args)))]
        [(eq? op 'ANND) (and (first args) (second args))]
        [(eq? op 'ORR) (or (first args) (second args))]
        [(eq? op 'NOTT) (not (first args))]
        [else (error "Don't know how to " op)]))

(apply-operator 'ADD '(1 1000))

(define (IPH-expr? sexpr)
  (and (pair? sexpr) (eq? (first sexpr) 'IPH)))

(define (IPH-TEST iph-expr)
  (second iph-expr))

(define (IPH-THEN iph-expr)
  (third iph-expr))

(define (IPH-ELSE iph-expr)
  (if (= (length iph-expr) 4)
      (fourth iph-expr)
      false))

(define (calculate-IPH sexpr lookup-list)
  (if (evaluate (IPH-TEST sexpr) lookup-list)
      (evaluate (IPH-THEN sexpr) lookup-list)
      (evaluate (IPH-ELSE sexpr) lookup-list)))

(define (evaluate expr lookup-list)
  (cond [(number? expr) expr]
        [(boolean? expr) expr]
        [(null? expr) expr]
        [(IPH-expr? expr) (calculate-IPH expr lookup-list)]
        [(list? expr)
         (apply-operator (first expr) ;; apply operator
                         (list (evaluate (first(rest expr)) lookup-list) (evaluate (last(rest expr)) lookup-list)))]
        [(symbol? expr) (last (assq expr lookup-list))]
        [else (error `(evaluate:  not sure what to do with expr ,expr))])
  )

(evaluate '(ADD x 3) '((x 3) (y 2) (z -5))) ;; -> 6
(evaluate 'y  '((x 3) (y 2) (z -5))) ;; -> 2
(evaluate '(IPH (GT z 0) z (SUB 0 z)) '((x 3) (y 2) (z 10))) ;; -> 10