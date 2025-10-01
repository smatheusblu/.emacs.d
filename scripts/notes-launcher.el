(defun thanos/wtype-text (text)
  "Process TEXT for wtype, handling newlines properly."
  (let* ((has-final-newline (string-match-p "\n$" text))
         (lines (split-string text "\n"))
         (last-idx (1- (length lines))))
    (string-join
     (cl-loop for line in lines
              for i from 0
              collect (cond
                       ;; Last line without final newline
                       ((and (= i last-idx) (not has-final-newline))
                        (format "wtype -s 350 \"%s\""
                                (replace-regexp-in-string "\"" "\\\"" line)))
                       ;; Any other line
                       (t
                        (format "wtype -s 350 \"%s\" && wtype -k Return"
                                (replace-regexp-in-string "\"" "\\\"" line)))))
     " && ")))

(define-minor-mode thanos/type-mode
  "Minor mode for inserting text via wtype."
  :keymap `((,(kbd "C-c C-c") . ,(lambda () (interactive)
                                   (call-process-shell-command
                                    (thanos/wtype-text (buffer-string))
                                    nil 0)
                                   ;; Find and delete frame with type-cleanup parameter
                                   (dolist (f (frame-list)) (when (frame-parameter f 'type-cleanup) (delete-frame f)))))
            (,(kbd "C-c C-k") . ,(lambda () (interactive)
                                   (kill-buffer (current-buffer))
                                   ;; Find and delete frame with type-cleanup parameter
                                   (dolist (f (frame-list)) (when (frame-parameter f 'type-cleanup) (delete-frame f)))))))

(defun thanos/type ()
  "Launch a temporary frame with a clean buffer for typing."
  (interactive)
  (let ((initial-frame (selected-frame))
        (frame (make-frame '((name . "emacs-float")
                             (fullscreen . 0)
                             (undecorated . t)
                             (width . 70)
                             (height . 20))))
        (buf (get-buffer-create "emacs-float")))

    (when (and initial-frame
               (not (eq initial-frame frame))
               (> (length (frame-list)) 1))
      (delete-frame initial-frame))

    ;; Set frame parameter for cleanup identification
    (set-frame-parameter frame 'type-cleanup t)

    (select-frame frame)
    (switch-to-buffer buf)
    (with-current-buffer buf
      (erase-buffer)
      (org-mode)
      (flyspell-mode)
      (thanos/type-mode)
      (setq-local header-line-format
                  (format " %s to insert text or %s to cancel."
                          (propertize "C-c C-c" 'face 'help-key-binding)
                          (propertize "C-c C-k" 'face 'help-key-binding)))
      ;; Make the frame more temporary-like
      (set-frame-parameter frame 'delete-before-kill-buffer t)
      (set-window-dedicated-p (selected-window) t))))

;; Fixed version of thanos/quick-capture
(defun thanos/quick-capture ()
  "Launch a temporary frame for org-roam capture to Inbox."
  (interactive)
  (let ((initial-buffer-choice initial-buffer-choice)) ; Save the original value
    (setq initial-buffer-choice nil) ; Prevent dashboard from opening
    (let ((initial-frame (selected-frame))
          (frame (make-frame '((name . "emacs-capture")
                               (fullscreen . 0)
                               (undecorated . t)
                               (width . 80)
                               (height . 25)))))

      (when (and initial-frame
                 (not (eq initial-frame frame))
                 (> (length (frame-list)) 1))
        (delete-frame initial-frame))

      (select-frame frame)

      ;; Temporarily disable Doom's popup system
      (let ((display-buffer-alist nil)
            (pop-up-frames nil)
            (pop-up-windows nil))

        ;; Set frame property for cleanup
        (set-frame-parameter frame 'capture-cleanup t)

        ;; Set up cleanup hooks - find frame by parameter
        (let ((cleanup-fn (lambda ()
                            (dolist (f (frame-list))
                              (when (frame-parameter f 'capture-cleanup)
                                (delete-frame f))))))
          (add-hook 'org-capture-after-finalize-hook cleanup-fn nil t)
          (add-hook 'org-capture-kill-hook cleanup-fn nil t))

        ;; Force capture to happen in current frame
        (org-capture nil "N")

        ;; Set up the capture buffer
        (setq-local header-line-format
                    (format " %s to save or %s to cancel."
                            (propertize "C-c C-c" 'face 'help-key-binding)
                            (propertize "C-c C-k" 'face 'help-key-binding)))

        ;; Ensure capture fills the frame
        (delete-other-windows)))
    (setq initial-buffer-choice initial-buffer-choice))) ; Restore the original value

(provide 'notes-launcher)
