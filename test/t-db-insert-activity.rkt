#lang racket
(require "./test-util.rkt")
(require "../rkt/al-profiler.rkt")
(require "../rkt/fit-file/fit-file.rkt")
(require "../rkt/database.rkt")

;; NOTE: `db-insert-activity` is using 'define/profiled' -- the final report
;; printed out contains only the time `db-insert-activity` runs, not the time
;; it takes to create the fresh database.

(module+ main
  (printf "Racket version: ~a; OS: ~a; VM: ~a~%"
          (version)
          (system-type 'os)
          (system-type 'vm))

  (profile-enable-all #t)
  (profile-reset-all)

  (define activity (read-activity-from-file "./test-data/920xt-bike.fit"))
  (for ([round (in-range 10)])
    (with-fresh-database
      (lambda (db)
        (db-insert-activity activity db))))

  (profile-display)
  )
