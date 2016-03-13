#lang racket

(define (stream-for-n-steps s n)
  (letrec ([f (lambda (s n)
                (let ([pr (s)])
                  (if (<= n 0)
                      null
                      (cons (car pr) (f (cdr pr) (- n 1))))))])
    (f s n)))

(define dan-then-dog
  (letrec ([f (lambda (x)
                (if (equal? x "dan.jpg")
                    (cons "dan.jpg" (lambda () (f "dog.jpg")))
                    (cons "dog.jpg" (lambda () (f "dan.jpg"))))
                )])
    (lambda () (f "dan.jpg"))))

(define (twice-each s)
  (lambda ()
    (let ([pr (s)])
      (cons (car pr)
            (lambda ()
              (cons (car pr)
                    (twice-each (cdr pr))))))))
