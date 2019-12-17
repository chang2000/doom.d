;;; .doom.d/config.el -*- lexical-binding: t; -*-

;;; Commentary: Place your private configuration here
;;; Code:
;; Keybindings for emacs-mac
(global-set-key (kbd "M-c") #'clipboard-kill-ring-save)
(global-set-key (kbd "M-v") #'clipboard-yank)
(global-set-key (kbd "M-w") #'delete-frame)
(global-set-key (kbd "M-o") #'ace-window)
(global-set-key (kbd "M-x") #'execute-extended-command)
(global-set-key (kbd "M-n") #'make-frame-command)
(global-set-key (kbd "M-s") #'save-buffer)



(set-frame-font "Source Code Pro 15" nil t)

;; Add custom theme
(add-to-list 'custom-theme-load-path "~/.doom.d/themes/")

;; Set line space for better readability
(setq-default line-spacing 3)

;; No line number for the better performance
(setq display-line-numbers-mode nil)

;; Private load-path
(add-to-list 'load-path "~/.doom.d/elisp")

;; My prefered themes
(defun disable-all-themes ()
  (dolist (i custom-enabled-themes)
    (disable-theme i)))
(defadvice load-theme (before disable-themes-first activate)
  (disable-all-themes))

;(load-theme 'lazycat)
;(load-theme 'spacemacs-dark)
;(load-theme 'doom-city-lights)

;; Some personaliized Evil settings
;;
;; Vim style buffer management
;; Reserve the operate style of original Emacs
(with-eval-after-load 'evil-maps
(define-key evil-insert-state-map (kbd "C-n") nil)
(define-key evil-insert-state-map (kbd "C-f") nil)
(define-key evil-insert-state-map (kbd "C-b") nil)
(define-key evil-insert-state-map (kbd "C-p") nil))

(evil-set-initial-state 'term-mode 'emacs)
(defun alex/save-and-kill-this-buffer ()
    (interactive)
    (save-buffer)
    (kill-this-buffer))
(evil-ex-define-cmd "q" 'kill-this-buffer)
(evil-ex-define-cmd "wq" 'alex/save-and-kill-this-buffer)

;; Auto save
(use-package! auto-save
  :config
  (auto-save-enable)
  (setq auto-save-silent t)
)

;; Blog Export
(use-package! ox-hugo :after ox)

;; Global Python3 Environment
;(setq python-shell-interpreter "python3"
      ;flycheck-python-pycompile-executable "python3")

;; Awesome Tab
(use-package! awesome-tab
  :config
  (awesome-tab-mode t) (setq awesome-tab-style 'wave) (global-set-key (kbd "M-h") 'awesome-tab-backward-tab)
  (global-set-key (kbd "M-l") 'awesome-tab-forward-tab)
  (global-set-key (kbd "M-j") 'awesome-tab-forward-group)
  (global-set-key (kbd "M-k") 'awesome-tab-backward-group)
)

;; Wakatime
(global-wakatime-mode)
