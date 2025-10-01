;; Example Elpaca early-init.el -*- lexical-binding: t; -*-
(setq package-enable-at-startup nil)
(setq gc-cons-threshold (* 256 1024 1024))
(setq read-process-output-max (* 4 1024 1024))
(setq comp-deferred-compilation t)
(setq comp-async-jobs-number 8)
(setq gcmh-idle-delay 5)
(setq gcmh-high-cons-threshold (* 1024 1024 1024))
(add-hook 'elpaca-after-init-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1024 1024))    ; 2MB
            (setq gc-cons-percentage 0.1)))
