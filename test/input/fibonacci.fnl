;; Example used from https://fennel-lang.org/see
(fn fibonacci [n]
  (if (< n 2)
      n
      (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(print (fibonacci 10))

