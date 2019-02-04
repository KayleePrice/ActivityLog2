#lang racket

(require "../rkt/data-frame/meanmax.rkt")
(require "../rkt/data-frame/csv.rkt")
(require "../rkt/al-profiler.rkt")

;; NOTE: `df-mean-max` is using `define/profiled`. -- the final report printed
;; out contains only the time `df-mean-max` runs, not the time it takes to
;; read the data.

(module+ main
  (printf "Racket version: ~a; OS: ~a; VM: ~a~%"
          (version)
          (system-type 'os)
          (system-type 'vm))
  (define df (df-read/csv "./test-data/track-data-2333.csv"))
  (profile-enable-all #t)
  (profile-reset-all)
  (for ([round (in-range 100)])
    (df-mean-max df "pwr"))
  (profile-display))
