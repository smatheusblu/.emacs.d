(require 'windmove)

(defun buf-move (direction)
  "Move buffer in DIRECTION (up, down, left, right)."
  (let* ((other-win (windmove-find-other-window direction))
         (buf-this-buf (window-buffer (selected-window))))
    (cond
     ((null other-win)
      (error "No window %s this one" direction))
     ((and (eq direction 'down)
           (string-match "^ \\*Minibuf" (buffer-name (window-buffer other-win))))
      (error "No window under this one"))
     (t
      (set-window-buffer (selected-window) (window-buffer other-win))
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win)))))

;;;###autoload
(defun buf-move-up () (interactive) (buf-move 'up))
;;;###autoload  
(defun buf-move-down () (interactive) (buf-move 'down))
;;;###autoload
(defun buf-move-left () (interactive) (buf-move 'left))
;;;###autoload
(defun buf-move-right () (interactive) (buf-move 'right))

(provide 'buffer-move)
