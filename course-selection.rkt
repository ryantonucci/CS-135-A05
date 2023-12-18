;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname course-selection) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;DesiredCourses is a type which requires a list of lists, each sublist must contain a first element
;;which is a string which is a valid user ID and a second element which is all of the valid course codes
;;that the user wants to take next semester.

;;Q2a
(define selections  ;Note this is defined strictly for examples/tests
  (list
   (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
   (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
   (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
   (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102))))

;;(taking-course? DesiredCourses username course-code) Checks if a student with username in
;;database (DesiredCourses) is enrolled in a certain class (course-code).
;;Examples
(check-expect (taking-course? selections  "bboucher" 'CS136) true)
(check-expect (taking-course? selections  "owinfrey" 'MATH249) false)
;;taking-course?: (DesiredCourses Str Sym)->Bool

(define (taking-course? DesiredCourses username course-code)
  (member? course-code (find-user-courses DesiredCourses username)))

(check-expect (taking-course? selections  "mallan" 'ECON101) false)
(check-expect (taking-course? selections  "owinfrey" 'HIST111) true)

;;(find-user-courses DesiredCourses username) ;finds all the courses the user has, returns them as a list.
;;Examples
(check-expect (find-user-courses selections "owinfrey") (list 'ENGL140 'HIST111 'CHEM101))
(check-expect (find-user-courses selections "bboucher") (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
;;find-user-courses: (DesiredCourses Str)->listof Sym

(define (find-user-courses DesiredCourses username) 
  (cond [(empty? DesiredCourses) empty]
        [(string=? username (first (first DesiredCourses))) (second (first DesiredCourses))]
        [else (find-user-courses (rest DesiredCourses) username)]))

;;Q2b
;;(missed-deadline-add DesiredCourses username) ;adds student to DesiredCourses
;;Examples
(check-expect (missed-deadline-add selections "edegener")
              (list
               (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
               (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
               (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
               (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102))
               (list "edegener" empty)))

(check-expect (missed-deadline-add selections "tswift")
              (list
               (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
               (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
               (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
               (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102))
               (list "tswift" empty)))
;;missed-deadline-add (DesiredCourses Str)->DesiredCourses

(define (missed-deadline-add DesiredCourses username)
  (cond [(student-in-list? DesiredCourses username) DesiredCourses]
        [else (append DesiredCourses (list (list username empty)))]))

(define (student-in-list? DesiredCourses username)
  (cond [(empty? DesiredCourses) false]
        [(string=? username (first (first DesiredCourses))) true]
        [else (student-in-list? (rest DesiredCourses) username)]))

(check-expect (student-in-list? selections "rvaughn") true)
(check-expect (student-in-list? selections "sharvey") false)

(check-expect (missed-deadline-add selections "rvaughn")
              (list
               (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
               (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
               (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
               (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102))))

;;2c
;;(add-course DesiredCourses username course-code) adds the code to the end
;;of the list of courses or adds student and course
;;Examples 
(check-expect (add-course selections "cchiarel" 'PHYS115)
              (list
               (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
               (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
               (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
               (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102 'PHYS115))))

(check-expect (add-course selections "agrande" 'LS101 )
              (list
               (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
               (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
               (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
               (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102))
               (list "agrande" (list 'LS101))))
(check-expect (add-course selections "cchiarel" 'MATH115)
              (list
               (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
               (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
               (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
               (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102))))
;;add-course: (DesiredCourses Str Sym)->DesiredCourses


(define (add-course DesiredCourses username course-code)
  (cond 
    [(student-in-list? DesiredCourses username)
     (cond [(student-have-course? DesiredCourses username course-code) DesiredCourses]
           [else (insert-course DesiredCourses username course-code)])]
    [else (append DesiredCourses (list (list username (list course-code))))]))

(define (student-have-course? DesiredCourses username course-code)
  (cond [(empty? DesiredCourses) false]
        [(and (string=? username (first (first DesiredCourses)))
              (member? course-code (second (first DesiredCourses)))) true]
        [else (student-have-course? (rest DesiredCourses) username course-code)]))

(check-expect (student-have-course? selections "cchiarel" 'MATH115) true)
(check-expect (student-have-course? selections "owinfrey" 'MATH135) false)

;;(insert-course username course-code) inserts course into last position of list
;;Example
(check-expect (insert-course selections "cchiarel" 'PHYS115)
              (list
               (list "rvaughn" (list 'CS135 'MATH135 'MATH137 'ENGL109 'ECON101))
               (list "bboucher" (list 'CS136 'MATH136 'MATH138 'ENGL109 'LS101))
               (list "owinfrey" (list 'ENGL140 'HIST111 'CHEM101))
               (list "cchiarel" (list 'ECON101 'MATH115 'MATH116 'CHE102 'PHYS115))))
;;insert-course: Str Sym->DesiredCourses

(define (insert-course DesiredCourses username course-code) 
  (cond [(empty? DesiredCourses) empty]
        [(string=? username (first (first DesiredCourses)))
         (cons (cons username (cons (append (second (first DesiredCourses)) (list course-code))
                                    (insert-course (rest DesiredCourses) username course-code))) empty)]
        [else (cons (first DesiredCourses) (insert-course (rest DesiredCourses) username course-code))]))

;;Q2d
;;(create-classlist DesiredCourses course-code)
;;Examples
(check-expect (create-classlist selections 'ECON101) (list "rvaughn" "cchiarel"))
(check-expect (create-classlist selections 'ENGL109) (list "rvaughn" "bboucher"))
(check-expect (create-classlist selections 'LS101) (list "bboucher"))
(check-expect (create-classlist selections 'MATH239) (list))
;;create-classlist: DesiredCourses Sym->listof Str

(define (create-classlist DesiredCourses course-code)
  (cond [(empty? DesiredCourses) empty]
        [(member? course-code (second (first DesiredCourses)))
         (cons (first (first DesiredCourses)) (create-classlist (rest DesiredCourses) course-code))]
        [else (create-classlist (rest DesiredCourses) course-code)]))

