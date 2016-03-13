#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

; 1
(define (sequence low high stride)
  (if (> low high)
  null
  (cons low (sequence (+ low stride) high stride))))

; 2
(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

; 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (let ([i (remainder n (length xs))])
            (if (= i 0) (car xs)
            (car (list-tail xs i))))]))

; 4
(define (stream-for-n-steps s n)
  (letrec ([f (lambda (s n)
                (let ([pr (s)])
                  (if (<= n 0)
                      null
                      (cons (car pr) (f (cdr pr) (- n 1))))))])
    (f s n)))

;5 stream of numbers; the ones divisible by 5 are negated
(define funny-number-stream
  (letrec ([f (lambda (x) (cons (if (= (remainder x 5) 0) (- 0 x) x) (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

;6 "dan.jpg" "dog.jpg" ...
(define dan-then-dog
  (letrec ([f (lambda (x)
                (if (equal? x "dan.jpg")
                    (cons "dan.jpg" (lambda () (f "dog.jpg")))
                    (cons "dog.jpg" (lambda () (f "dan.jpg"))))
                )])
    (lambda () (f "dan.jpg"))))
 
;7 stream-add-zero
(define (stream-add-zero s)
 (letrec ([f (lambda (s)
               (let ([pr (s)])
                    (cons (cons 0 (car pr)) (lambda () (f (cdr pr))))))])
   (lambda () (f s))))

;8 cycle-lists [1, 2, 3] ["a", "b"] -> (1 . "a"), (2 . "b"), (3 . "a"), (1 . "b"), (2 . "a"), (3 . "b")...
(define (cycle-lists xs ys)
  (letrec ([f (lambda (a b n)
              (let ([x (list-nth-mod a n)]
                    [y (list-nth-mod b n)])
                (cons (cons x y) (lambda() (f a b (+ n 1))))))])
                (lambda () (f xs ys 0))))

;9
(define (vector-assoc v vec)
  (letrec ([f (lambda (i l)
              (cond [(>= i l) #f]
                    [(and (pair? (vector-ref vec i)) (equal? (car (vector-ref vec i)) v)) (vector-ref vec i)]
                    [#t (f (+ i 1) l)]))])
    (f 0 (vector-length vec))))

;10
(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [i 0]
           [f (lambda (v)
              (let ([x (vector-assoc v memo)])
                     (if x
                         x
                         (begin
                           (let ([ans (assoc v xs)])
                           (vector-set! memo i ans)
                           (set! i (remainder (+ i 1) n))
                           ans)))
               ))])
    (lambda (v) (f v))))




