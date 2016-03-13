#lang racket

(require "hw4.rkt") 
(require rackunit "hw4.rkt")

;; A simple library for displaying a 2x3 grid of pictures: used
;; for fun in the tests below (look for "Tests Start Here").

(require (lib "graphics.rkt" "graphics"))

(open-graphics)

(define window-name "Programming Languages, Homework 4")
(define window-width 700)
(define window-height 500)
(define border-size 100)

(define approx-pic-width 200)
(define approx-pic-height 200)
(define pic-grid-width 3)
(define pic-grid-height 2)

(define (open-window)
  (open-viewport window-name window-width window-height))

(define (grid-posn-to-posn grid-posn)
  (when (>= grid-posn (* pic-grid-height pic-grid-width))
    (error "picture grid does not have that many positions"))
  (let ([row (quotient grid-posn pic-grid-width)]
        [col (remainder grid-posn pic-grid-width)])
    (make-posn (+ border-size (* approx-pic-width col))
               (+ border-size (* approx-pic-height row)))))

(define (place-picture window filename grid-posn)
  (let ([posn (grid-posn-to-posn grid-posn)])
    ((clear-solid-rectangle window) posn approx-pic-width approx-pic-height)
    ((draw-pixmap window) filename posn)))

(define (place-repeatedly window pause stream n)
  (when (> n 0)
    (let* ([next (stream)]
           [filename (cdar next)]
           [grid-posn (caar next)]
           [stream (cdr next)])
      (place-picture window filename grid-posn)
      (sleep pause)
      (place-repeatedly window pause stream (- n 1)))))

;; Tests Start Here

; These definitions will work only after you do some of the problems
; so you need to comment them out until you are ready.
; Add more tests as appropriate, of course.

(define nums (sequence 0 5 1))

(define files (string-append-map 
               (list "dan" "dog" "curry" "dog2") 
               ".jpg"))

(define funny-test (stream-for-n-steps funny-number-stream 16))

; a zero-argument function: call (one-visual-test) to open the graphics window, etc.
(define (one-visual-test)
  (place-repeatedly (open-window) 0.5 (cycle-lists nums files) 27))

; similar to previous but uses only two files and one position on the grid
(define (visual-zero-only)
  (place-repeatedly (open-window) 0.5 (stream-add-zero dan-then-dog) 27))

(check-equal? (sequence 0 5 1)
              '(0 1 2 3 4 5) "sequence #1")

(check-equal? (sequence 3 11 2)
              '(3 5 7 9 11) "sequence #2")

(check-equal? (sequence 3 8 3)
              '(3 6) "sequence #3")

(check-equal? (sequence 3 2 1)
              '() "sequence #4")

(check-equal? (string-append-map '("a" "b" "c") "-1")
              '("a-1" "b-1" "c-1") "string-append-map #1" )

(check-equal? (string-append-map '("a") "-1")
              '("a-1") "string-append-map #2" )

(check-equal? (string-append-map null "-1")
              '() "string-append-map #3" )

(check-equal? (list-nth-mod '("a" "b" "c") 0) 
              "a" "list-nth-mod #1")
(check-equal? (list-nth-mod '("a" "b" "c") 2)
              "c" "list-nth-mod #2")
(check-equal? (list-nth-mod '("a" "b" "c") 4)
              "b" "list-nth-mod #3")

(check-exn (regexp "list-nth-mod: negative number") 
           (lambda () (list-nth-mod '("a" "b" "c") -1) ) "not a 'list-nth-mod: negative number' thrown #5")

(check-exn (regexp "list-nth-mod: empty list") 
           (lambda () (list-nth-mod '() 0)) "not a 'list-nth-mod: empty list' thrown #6")

(define nats-for-test
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

(check-equal? (stream-for-n-steps nats-for-test 5)
              '(1 2 3 4 5) "should return 5 elements in list")

(check-equal? (stream-for-n-steps funny-number-stream 16)
              '(1 2 3 4 -5 6 7 8 9 -10 11 12 13 14 -15 16) "should return 16 numbers")

(check-equal? (stream-for-n-steps funny-number-stream 0)
              '() "should return empty list")

(check-equal? (stream-for-n-steps funny-number-stream 1) 
              '(1) "should return list with 1 element")

(check-equal? (stream-for-n-steps dan-then-dog 4)
              '("dan.jpg" "dog.jpg" "dan.jpg" "dog.jpg") "should return dan.jpg dog.jpg ... of 4 item list")

(check-equal? (stream-for-n-steps dan-then-dog 1)
              '("dan.jpg") "should return dan.jpg item in list")

(check-equal? (stream-for-n-steps dan-then-dog 2)
              '("dan.jpg" "dog.jpg") "should return dan.jpg and dog.jpg items in list")

(check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 2)
              '((0 . "dan.jpg") (0 . "dog.jpg")) "should return 2 pairs (0 . 'dan.jpg') and (0 . 'dog.jpg')")

(check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 4) 
              '((0 . "dan.jpg") (0 . "dog.jpg") (0 . "dan.jpg") (0 . "dog.jpg"))  "should return 4 pairs (0 . 'dan.jpg') and (0 . 'dog.jpg')")

(check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 0) 
              '() "should return empty list")

(check-equal? (stream-for-n-steps (cycle-lists '(1 2 3) '("a" "b") ) 4) 
              '((1 . "a") (2 . "b") (3 . "a") (1 . "b")) "should return mixed lists 4 pairs")

(check-equal? (vector-assoc 5 (list->vector '((1 . "a") (2 . "b") (3 . "c") (4 . "d") (5 . "e")))) 
              (cons 5 "e") "should return pair ( 5 . 'e' )" )

(check-equal? (vector-assoc 6 (list->vector '((1 . "a") (2 . "b") (3 . "c") (4 . "d") (5 . "e")))) 
              #f "should return pair with '5' in field" )

(check-equal? (vector-assoc 5 (list->vector '(1 2 3 4 5))) 
              #f "should return #f for non paired items vector" )

(check-equal? (vector-assoc 7 (list->vector '(1 2 3 4 5 (7 . 8)))) 
              (cons 7 8) "should return pair with '7' in field" )

(check-equal? (vector-assoc 3 (list->vector '(1 2 (3 . 7) 4 5 (7 . 8)))) 
              (cons 3 7) "should return pair with '7' in field" )

(define ctf (cached-assoc '((1 . 2) (3 . 4) (5 . 6) (7 . 8) (9 . 10)) 3 ))

(check-equal? (ctf 3) (cons 3 4) "should return (3 . 4)")
(check-equal? (ctf 5) (cons 5 6) "should return (5 . 6)")
(check-equal? (ctf 9) (cons 9 10) "should return (9 . 10)")
(check-equal? (ctf 11) #f "should return #f for  v=11")