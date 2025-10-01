;;; -*- lexical-binding: t; -*-

(defun emacs-counsel-launcher ()
  "Create and select a frame called emacs-counsel-launcher which consists only of a minibuffer and has specific dimensions. Runs counsel-linux-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
  (interactive)
  (with-selected-frame 
    (make-frame '((name . "emacs-run-launcher")
                  (minibuffer . only)
                  (fullscreen . 0) ; no fullscreen
                  (undecorated . t) ; remove title bar
                  ;;(auto-raise . t) ; focus on this frame
                  ;;(tool-bar-lines . 0)
                  ;;(menu-bar-lines . 0)
                  (internal-border-width . 10)
                  (width . 80)
                  (height . 11)))
                  (unwind-protect
                    (counsel-linux-app)
                    (delete-frame))))

(use-package app-launcher
  :ensure '(app-launcher :host github :repo "SebastienWae/app-launcher"))

(defun emacs-run-launcher ()
  "Launch a temporary frame for app-launcher and delete the initial frame."
  (interactive)
  (let ((initial-frame (selected-frame))
        (frame (make-frame '((name . "emacs-run-launcher")
                             (minibuffer . only)
                             (width . 80)
                             (height . 11)
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