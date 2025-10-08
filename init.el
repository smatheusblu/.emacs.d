(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1bbce512ed3f0b1a5aabef5e0371c4d5f0d04b14939d4bb200375419ba6da523"
     "1bc640af8b000ae0275dbffefa2eb22ec91f6de53aca87221c125dc710057511"
     "9b9d7a851a8e26f294e778e02c8df25c8a3b15170e6f9fd6965ac5f2544ef2a9"
     "83550d0386203f010fa42ad1af064a766cfec06fc2f42eb4f2d89ab646f3ac01"
     default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-current-time ((t (:foreground "#e74c3c" :weight bold))))
 '(org-agenda-date ((t (:height 1.1 :weight bold :foreground "#34495e"))))
 '(org-agenda-date-today ((t (:height 1.15 :weight bold :foreground "#e74c3c" :box t))))
 '(org-agenda-date-weekend ((t (:height 1.1 :weight bold :foreground "#7f8c8d"))))
 '(org-agenda-date-weekend-today ((t (:height 1.15 :weight bold :foreground "#e74c3c" :box t))))
 '(org-agenda-structure ((t (:height 1.2 :weight bold :foreground "#2c3e50"))))
 '(org-habit-alert-face ((t (:background "#f39c12" :foreground "white"))))
 '(org-habit-overdue-face ((t (:background "#e74c3c" :foreground "white"))))
 '(org-habit-ready-face ((t (:background "#2ecc71" :foreground "white"))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
 '(org-level-6 ((t (:inherit outline-6 :height 1.2))))
 '(org-level-7 ((t (:inherit outline-7 :height 1.1))))
 '(org-super-agenda-header ((t (:inherit custom-button :weight bold :height 1.05))))
 '(org-time-grid ((t (:foreground "#95a5a6")))))
