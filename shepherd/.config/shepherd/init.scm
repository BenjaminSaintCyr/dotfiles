;; init.scm -- default shepherd configuration file.

;; Emacs Daemon
(define emacs-daemon
  (make <service>
    #:provides '(emacs-daemon)
    #:docstring "Run `emacs' as daemon"
    #:start (make-forkexec-constructor '("emacs" "--fg-daemon"))
    #:stop (make-kill-destructor)
    #:respawn? #t))


;; Services known to shepherd:
;; Add new services (defined using 'make <service>') to shepherd here by
;; providing them as arguments to 'register-services'.
(register-services emacs-daemon)

;; Send shepherd into the background
(action 'shepherd 'daemonize)

;; Services to start when shepherd starts:
;; Add the name of each service that should be started to the list
;; below passed to 'for-each'.
(for-each start '(emacs-deamon))
