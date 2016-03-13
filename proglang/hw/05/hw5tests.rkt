#lang racket

(require "hw5.rkt")
(require rackunit)

; a test case that uses problems 1, 2, and 4
; should produce (list (int 10) (int 11) (int 16))
;(define test1
;  (mupllist->racketlist
;   (eval-exp (call (call mupl-mapAddN (int 7))
;                   (racketlist->mupllist 
;                    (list (int 3) (int 4) (int 9)))))))

; 1
(define test1_1 (racketlist->mupllist (list (int 1) (int 2) (int 3) (int 4))))

(check-equal? test1_1
              (apair (int 1) (apair (int 2) (apair (int 3) (apair (int 4) (aunit)))))
              "Testing racketlist->mupllist")

(check-equal? (mupllist->racketlist test1_1)
              (list (int 1) (int 2) (int 3) (int 4))
              "Testing mupllist->racketlist")

; 2
(check-equal? (eval-exp (ifgreater (int 1) (int 2) (add (var "crashifevaluated") (int 3)) (int 42)))
              (int 42)
              "Testing ifgreater 1 2")

(check-equal? (eval-exp (ifgreater (int 2) (int 1) (int 42) (add (var "crashifevaluated") (int 3))))
              (int 42)
              "Testing ifgreater 2 1")

(define f2_1 (eval-exp (fun "myFct" "nb" (add (int 42) (var "nb")))))

(check-equal? (eval-exp (call f2_1 (int 3)))
              (int 45)
              "Testing call")

(define f2_2 (eval-exp (mlet "ref" (int 42) (fun "myFct" "nb" (add (var "ref") (var "nb"))))))

(check-equal? (eval-exp (call f2_2 (int 3)))
              (int 45)
              "Testing mlet+call")

(check-equal? (eval-exp (mlet "ref" (int 2) (call f2_2 (int 3))))
              (int 45)
              "Testing unused mlet with call")

(define p2 (eval-exp (apair (int 7) (int 8))))

(check-equal? (eval-exp (fst p2)) (int 7) "Testing fst")

(check-equal? (eval-exp (snd p2)) (int 8) "Testing snd")

(define f2_sumall (eval-exp (fun "sumall" "nb" (ifgreater (var "nb")
                                                          (int 0)
                                                          (add (var "nb") (call (var "sumall") (add (int -1) (var "nb"))))
                                                          (int 0)))))
(check-equal? (eval-exp (call f2_sumall (int 10)))
              (int 55)
              "Testing recursive function")


; 3
(check-equal? (eval-exp (ifaunit (int 6) (add (var "crashifeval") (int 1)) (int 42)))
              (int 42)
              "Testing ifaunit 6")

(check-equal? (eval-exp (ifaunit (aunit) (int 42) (add (var "crashifeval") (int 1))))
              (int 42)
              "Testing ifaunit aunit")

(check-equal? (eval-exp (mlet* (list (cons "a" (int 5)) (cons "b" (int 6))) (add (var "b") (var "a"))))
              (int 11)
              "Testing mlet*")

(check-equal? (eval-exp (ifeq (int 5) (int 5) (int 42) (add (int 0) (var "crashifeval"))))
              (int 42)
              "Testing ifeq 5 5")

(check-equal? (eval-exp (ifeq (int 6) (int 5) (add (int 0) (var "crashifeval")) (int 42)))
              (int 42)
              "Testing ifeq 6 5")

(check-equal? (eval-exp (ifeq (int 5) (int 6) (add (int 0) (var "crashifeval")) (int 42)))
              (int 42)
              "Testing ifeq 5 6")

; 4

(define nums (racketlist->mupllist (list (int 1) (int 2) (int 3) (int 4))))

(check-equal? (eval-exp (call (call mupl-mapAddN (int 10)) nums))
              (racketlist->mupllist(list (int 11) (int 12) (int 13) (int 14)))
              "Testing mupl-map and mupl-mapAddN")

