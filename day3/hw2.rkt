#lang racket

;;; Student Name: Emily Yeh
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [X] I completed this assignment with assistance from Sophie Lee (NINJA)
;;;     and/or using these external resources: Stack Overload, Racket Documentation
;;;
;;; Other Notes: I didn't have time to attempt any of the obscure challenges... but it would be nice to see what implementations of them look like!

;;; 1.  Create a calculator that takes one argument: a list that represents an expression.

(define (calculate x)
  (match x
    [(list OP a b)
     (cond
       [(equal? OP 'ADD) (+ a b)]
       [(equal? OP 'SUB) (- a b)]
       [(equal? OP 'DIV) (/ a b)]
       [(equal? OP 'MUL) (* a b)]
       )
     ]
    [(list a) (cond [(number? a) a])])
  )

(calculate '(ADD 3 4)) ;; --> 7
(calculate '(DIV 6 2)) ;; --> 3

;;; 2. Expand the calculator's operation to allow for arguments that are themselves well-formed arithmetic expressions.

(define (calculate2 x)
  (if (number? x) x
      (match x
        [(list OP a b)
         (cond
           [(equal? OP 'ADD) (+ (calculate2 a) (calculate2 b))]
           [(equal? OP 'SUB) (- (calculate2 a) (calculate2 b))]
           [(equal? OP 'DIV) (/ (calculate2 a) (calculate2 b))]
           [(equal? OP 'MUL) (* (calculate2 a) (calculate2 b))]
           )
         ]
        )
      )
  )

(calculate2 '(ADD 3 (MUL 4 5))) ;; --> 23 which is... (+ 3 ( * 4 5))   ;; what is the equivalent construction using list?
(calculate2 '(SUB (ADD 3 4) (MUL 5 6))) ;; --> -23 which is... (- (+ 3 4) (* 5 6))
;
;;;; 3. Add comparators returning booleans (*e.g.*, greater than, less than, …).
;;; Note that each of these takes numeric arguments (or expressions that evaluate to produce numeric values),
;;; but returns a boolean.  We suggest operators `GT`, `LT`, `GE`, `LE`, `EQ`, `NEQ`.

(define (calculate3 x)
  (if (number? x) x
      (match x
        [(list OP a b)
         (cond
           [(equal? OP 'ADD) (+ (calculate3 a) (calculate3 b))]
           [(equal? OP 'SUB) (- (calculate3 a) (calculate3 b))]
           [(equal? OP 'DIV) (/ (calculate3 a) (calculate3 b))]
           [(equal? OP 'MUL) (* (calculate3 a) (calculate3 b))]
           [(equal? OP 'GT) (> (calculate3 a) (calculate3 b))]
           [(equal? OP 'LT) (< (calculate3 a) (calculate3 b))]
           [(equal? OP 'GE) (>= (calculate3 a) (calculate3 b))]
           [(equal? OP 'LE) (<= (calculate3 a) (calculate3 b))]
           [(equal? OP 'EQ) (equal? (calculate3 a) (calculate3 b))]
           [(equal? OP 'NEQ) (false? (equal? (calculate3 a) (calculate3 b)))]
           )
         ]
        )
      )
  )
(calculate3 '(GT (ADD 3 4) (MUL 5 6))) ;; --> #f
(calculate3 '(LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))) ;; --> #t

;;;; 4. Add boolean operations ANND (AND?), ORR, NOTT

(define (calculate4 x)
  (if (number? x) x
      (match x
        [(list OP a b)
         (cond
           [(equal? OP 'ADD) (+ (calculate4 a) (calculate4 b))]
           [(equal? OP 'SUB) (- (calculate4 a) (calculate4 b))]
           [(equal? OP 'DIV) (/ (calculate4 a) (calculate4 b))]
           [(equal? OP 'MUL) (* (calculate4 a) (calculate4 b))]
           [(equal? OP 'GT) (> (calculate4 a) (calculate4 b))]
           [(equal? OP 'LT) (< (calculate4 a) (calculate4 b))]
           [(equal? OP 'GE) (>= (calculate4 a) (calculate4 b))]
           [(equal? OP 'LE) (<= (calculate4 a) (calculate4 b))]
           [(equal? OP 'EQ) (equal? (calculate4 a) (calculate4 b))]
           [(equal? OP 'NEQ) (false? (equal? (calculate4 a) (calculate4 b)))]
           [(equal? OP 'AND) (and (calculate4 a) (calculate4 b))]
           [(equal? OP 'ORR) (or (calculate4 a) (calculate4 b))]
           [(equal? OP 'NOTT) (not (calculate4 a) (calculate4 b))] ; I wasn't sure what NOTT was supposed to do...
           )
         ]
        )
      )
  )

(calculate4 '(AND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f
(calculate4 '(ORR (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #t

; 5. Add IPH

(define (calculate5 x)
  (if (number? x) x
      (match x
        [(list IPH y a b)
         (if (calculate4 y) (calculate4 a) (calculate4 b))]
        )
      )
  )

(calculate5 '(IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3))) ;; -> 4
