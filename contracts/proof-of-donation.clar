(define-map donations
  { donor: principal }
  { hash: (buff 32) })

(define-public (submit-donation (hash (buff 32)))
  (begin
    (match (map-get? donations { donor: tx-sender })
      some-donation
        (err u100)
      (begin
        (map-set donations
          { donor: tx-sender }
          { hash: hash })
        (ok true)))))

(define-read-only (get-donation (donor principal))
  (map-get? donations { donor: donor }))

(define-read-only (has-donated (donor principal))
  (is-some (map-get? donations { donor: donor })))
