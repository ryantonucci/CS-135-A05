;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname examples-a05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Q2a
(define selections
  (list
   (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
   (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
   (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
   (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102))))

        
(check-expect (taking-course? selections  "bboucher" 'CS136) true)
(check-expect (taking-course? selections  "owinfrey" 'MATH249) false)
(check-expect (taking-course? selections  "mallan" 'ECON101) false)
(check-expect (taking-course? selections  "owinfrey" 'HIST111) true)

;;Q2b
(check-expect (missed-deadline-add selections "edegener")
              (list
   (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
   (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
   (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
   (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102 ))
   (list "edegener" empty)))

(check-expect (missed-deadline-add selections "tswift")
              (list
   (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
   (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
   (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
   (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102 ))
   (list "tswift" empty)))

;;Q2c
(check-expect (add-course 'PHYS115 "cchiarel")
              (list
   (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
   (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
   (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
   (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102 'PHYS115))))

(check-expect (add-course 'LS101 "agrande")
              (list
   (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
   (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
   (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
   (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102))
   (list "agrande" (list 'LS101))))

(check-expect (add-course 'MATH136 "bboucher")
 (list
   (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
   (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
   (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
   (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102))))

;;Q2d
(check-expect (create-classlist selections 'ECON101) (list "rvaughn" "cchiarel"))
(check-expect (create-classlist selections 'ENGL109) (list "rvaughn" "bboucher"))
(check-expect (create-classlist selections 'LS101) (list "LS101" "bboucher"))

;;Q3a
(check-expect (solos (list 3 5 5 8 9 'Queen 'King 2))
              (list (list 3) (list 5) (list 8) (list 9) (list 'Queen) (list 'King) (list 2)))
(check-expect (solos (list 3 3 3 5 5 8 9 'Queen 'King 2))
              (list (list 3) (list 5) (list 8) (list 9) (list 'Queen) (list 'King) (list 2)))

;;Q3b
(check-expect (pairs (list 4 4 5 7 7 10 'Jack 'Jack 'King 2))
              (list (list 4 4) (list 7 7) (list 'Jack 'Jack))) 
(check-expect (pairs (list 3 3 3 4 5 5 6 7 7 7 8 8 8 8 8 10 'Jack 'Jack 'King 'Ace 'Ace 2 'Red))
              (list (list 3 3) (list 5 5) (list 7 7) (list 8 8) (list 'Jack 'Jack) (list 'Ace 'Ace)))

;;Q3c
(check-expect (trios (list 3 3 4 4 4 7 9 9 'Jack 'King 'King 'King 2 2 2 2))
              (list (list 4 4 4) (list 'King 'King 'King) (list 2 2 2 2)))
(check-expect (trios (list 3 3 3 3 4 4 10 10 10 'Jack 'Queen 'Queen 'King))
              (list (list 3 3 3) (list 10 10 10)))

;;Q3d
(check-expect (sort-hands (list (list 6 7 8) (list 'Jack 'Jack) (list 4 4) (list 4 4) (list 2 2 2)
                                (list 'Black 'Red)))
              (list (list 4 4) (list 4 4) (list 'Jack 'Jack) (list 6 7 8)
                    (list 2 2 2) (list 'Black 'Red)))

(check-expect (sort-hands (list (list 3 4 5 6 7) (list 'Jack 'Jack) (list 'Queen 'Queen)
                                (list 4 4) (list 2 2) (list 'Black 'Red) (list 9 9 9 9)
                                (list 7 7 7) (list 7 8 9)))
              (list (list 4 4) (list 7 7) (list 'Jack 'Jack) (list 'Queen 'Queen)
                    (list 2 2) (list 7 7 7) (list 7 8 9) (list 9 9 9 9) (list 'Black 'Red)))

;;Q3e
(check-expect (straights (list 3 3 4 4 4 5 5 7 7 7 8 8 8 8 9 9 9 9
                               10 10 10 'Jack 'Jack 'Jack' Queen 'Queen 'King 'Ace 2 'Black))
              (list (list 3 4 5) (list 3 4 5) (list 7 8 9 10 'Jack 'Queen 'King 'Ace)
                    (list 7 8 9 10 'Jack 'Queen) (list 7 8 9 10 'Jack)))



;;Q3f
(check-expect (straight-pairs
               (list 3 3 4 4 4 5 5 7 7 7 8 8 8 8 9 9 9 9 10 10 10
                     'Jack 'Jack 'Jack' Queen 'Queen 'King 'Ace 2 'Black))
              (list (list 3 3 4 4 5 5) (list 7 7 8 8 9 9 10 10 'Jack 'Jack 'Queen 'Queen)))
              
;;Q3g
(check-expect (airplanes
               (list 3 3 4 4 4 5 5 7 7 7 8 8 8 8 9 9 9 9 10 10 10
                     'Jack 'Jack 'Jack' Queen 'Queen 'King 'Ace 2 'Black))
              (list (list 7 7 7 8 8 8 9 9 9)))

(check-expect (airplanes (list 4 7 7 7 8 8 8 10 10
                               'Jack 'Jack 'Jack 'Queen 'Queen 'Queen 'King 'King 'King))
              (list (list 7 7 7 8 8 8) ('Jack 'Jack 'Jack 'Queen 'Queen 'Queen 'King 'King 'King)))



 