;;; -*- lexical-binding: t; -*-

(use-package app-launcher
  :ensure '(app-launcher :host github :repo "SebastienWae/app-launcher"))

(defun emacs-run-launcher ()
  "Launch a temporary frame for app-launcher and delete the initial frame."
  (interactive)
  (let ((initial-frame (selected-frame))
        (frame (make-frame '((name . "emacs-run-launcher")
                             (minibuffer . only)
                             (width . 80)
                             (height . 23)
                             (undecorated . t)
                             (internal-border-width . 10)))))
    (when (and initial-frame
               (not (eq initial-frame frame))
               (> (length (frame-list)) 1))
      (delete-frame initial-frame))

    (select-frame frame)
    ;; Use unwind-protect to ensure the new popup frame is always deleted
    (unwind-protect
        (call-interactively 'app-launcher-run-app)
      (delete-frame frame))))

(provide 'app-launchers)
