#lang racket

;;; Student Name: Emily Yeh
;;;
;;; Check one:
;;; [X] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

;;; Additional note: This is the first time I've been able to complete one of these
;;; assignments without help! I'm very proud! :D
;;; (However, I know I didn't do a perfect job... And there is definitely room for
;;; improvement, even if everything (?) works...)

;;; ------------------------------------------------------------------
;;; EVALUATE: SET-UP
;;; ------------------------------------------------------------------

(define (apply-operator op args) ; this is all ripped from hw3
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

(define (calculate-IPH sexpr)
  (if (evaluate (IPH-TEST sexpr))
      (evaluate (IPH-THEN sexpr))
      (evaluate (IPH-ELSE sexpr))))

;;; ------------------------------------------------------------------
;;; DEFINE
;;; ------------------------------------------------------------------

(define (is-define? expr) ; check if expr starts with 'DEFINE
  (and (pair? expr) (eq? (first expr) 'DEFINE)))

(define vars empty) ; set up accumulator

(define (my-define expr) ; do the define thingy
  (if (not (eq? #f (assq expr vars)))
      (last (assq expr vars)) 
      (set! vars (list (list (first (rest expr)) (evaluate (last expr)))))
            ))

;;; ------------------------------------------------------------------
;;; EVALUATE: PRINTING (IMPLEMENTING) LAMBDA
;;; ------------------------------------------------------------------

(define (is-lambda? expr) ; check if expr starts with 'LAMBDA
  (and (list? expr) (eq? (first expr) 'LAMBDA)))

(define (print-lambda expr) ; return a lambda expression
  (if (not (empty? vars))
      (reverse (append vars (reverse (rest expr)) '(lambda)))
      (reverse (append (reverse (rest expr)) '(lambda)))))

;;; ------------------------------------------------------------------
;;; LAMBDA
;;; ------------------------------------------------------------------

(define (is-apply-lambda? expr) ; check if expr is an is-lambda expr
  (and (list? expr) (is-lambda? (first expr))))

(define zip (lambda (l1 l2) (map list l1 l2))) ; zippity doo dah zippity day

(define (apply-proc expr) ; create the lookup-list
  (zip (second (print-lambda (first expr)))
       (list (evaluate (second expr)) (evaluate (last expr)))))

(define (lambda-helper expr) ; create the argument to pass into apply-lambda
  (cons (print-lambda (first expr)) (apply-proc expr)))
  
(define (apply-lambda expr) ; do the lambda thingy
  (evaluate2 (rest (lambda-helper expr))
             (first (rest (rest (first (lambda-helper expr)))))))

(define (evaluate2 lookup-list expr) ; a special evaluate function for lambda expressions
  (cond [(number? expr) expr]        ; i probably could have just used the original evaluate
        [(boolean? expr) expr]       ; but i needed to pass in two arguments, not one...
        [(null? expr) expr]          ; so i just decided to built a new evaluate function
        [(IPH-expr? expr) (calculate-IPH expr)]
        [(symbol? expr) (last (assq expr lookup-list))]
        [(list? expr) (apply-operator (first expr) (map (curry evaluate2 lookup-list) (rest expr)))]
        [else (error `(evaluate2: not sure how to , expr))]))

;;; ------------------------------------------------------------------
;;; EVALUATE
;;; ------------------------------------------------------------------

(define (evaluate expr)
  (cond [(number? expr) expr]  
        [(boolean? expr) expr]  
        [(null? expr) expr]     
        [(IPH-expr? expr) (calculate-IPH expr)]
        [(is-define? expr) (my-define expr)]
        [(is-lambda? expr) (print-lambda expr)]
        [(is-apply-lambda? expr) (apply-lambda expr)]
        [(symbol? expr) (my-define expr)]
        [(list? expr) (apply-operator (first expr) (map evaluate (rest expr)))]
        [else (error `(evaluate:  not sure what to do with expr ,expr))]))

;;; ------------------------------------------------------------------
;;; REPL
;;; ------------------------------------------------------------------

(define (run-repl)
  (display "Welcome to my REPL!
\nTry typing some scheme-ish.
\nDon't forget to hit <return> after each expression. \n")
  (repl))

(define (repl)
  (display "> ")
  (display (evaluate (read)))
  (newline)
  (repl))

; ((LAMBDA (x y) (ADD (MUL x x) (MUL y y))) 2 (SUB 4 1)) -> 13