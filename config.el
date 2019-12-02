;;; .doom.d/config.el -*- lexical-binding: t; -*-

;;; Commentary: Place your private configuration here
;;; Code:
;; Keybindings for emacs-mac
(global-set-key (kbd "s-c") #'clipboard-kill-ring-save)
(global-set-key (kbd "s-v") #'clipboard-yank)
(global-set-key (kbd "s-w") #'delete-frame)
(global-set-key (kbd "s-o") #'ace-window)
(global-set-key (kbd "s-x") #'execute-extended-command)
(global-set-key (kbd "s-n") #'make-frame-command)
(global-set-key (kbd "s-s") #'save-buffer)

;; disable the command + H feature of macOS
(setq mac-pass-command-to-system nil)
;;中文字体加强
(defun +my/better-font()
  (interactive)
  ;; english font
  (if (display-graphic-p)
      (progn
        ;; (set-face-attribute 'default nil :font (format "%s:pixelsize=%d" "Iosevka Slab" 19)) ;; 11 13 17 19 23
        (set-face-attribute 'default nil :font (format "%s:pixelsize=%d" "Source Code Pro" 19)) ;; 11 13 17 19 23
        (dolist (charset '(kana han symbol cjk-misc bopomofo))
          (set-fontset-font (frame-parameter nil 'font)
                            charset
                            (font-spec :family "Songti SC")))) ;; 14 16 20 22 28
    ))

(defun +my|init-font(frame)
  (with-selected-frame frame
    (if (display-graphic-p)
        (+my/better-font))))

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions #'+my|init-font)
  (+my/better-font))

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

(load-theme 'spacemacs-dark)
;; (load-theme 'doom-wilmersdorf)

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
(require 'auto-save)
(auto-save-enable)
(setq auto-save-silent t)

;; Tabnine
(use-package! company-tabnine
    :after company
    :config
    (add-to-list 'company-backends #'company-tabnine)
    (set-company-backend! 'company-tabnine))
(setq company-idle-delay 0)
(setq company-show-numbers t)
(global-company-mode)
;; Flycheck

;; Blog Export
(use-package! ox-hugo :after ox)

;; Global Python3 Environment
(setq python-shell-interpreter "python3"
      flycheck-python-pycompile-executable "python3")

;; Awesome Tab
(require 'awesome-tab)
(awesome-tab-mode t)
(setq awesome-tab-style 'bar)
(global-set-key (kbd "s-h") 'awesome-tab-backward-tab)
(global-set-key (kbd "s-l") 'awesome-tab-forward-tab)
(global-set-key (kbd "s-j") 'awesome-tab-forward-group)
(global-set-key (kbd "s-k") 'awesome-tab-backward-group)

;; Wakatime
(global-wakatime-mode)
