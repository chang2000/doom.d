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
        (set-face-attribute 'default nil :font (format "%s:pixelsize=%d" "Iosevka Slab" 19)) ;; 11 13 17 19 23
        ;; (set-face-attribute 'default nil :font (format "%s:pixelsize=%d" "Source Code Pro" 19)) ;; 11 13 17 19 23
        (dolist (charset '(kana han symbol cjk-misc bopomofo))
          (set-fontset-font (frame-parameter nil 'font)
                            charset
                            (font-spec :family "STFangsong")))) ;; 14 16 20 22 28
    ))

(defun +my|init-font(frame)
  (with-selected-frame frame
    (if (display-graphic-p)
        (+my/better-font))))

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions #'+my|init-font)
  (+my/better-font))

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
(load-theme 'spacemacs-dark)

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
(setq python-shell-interpreter "python3"
      flycheck-python-pycompile-executable "python3")

;; Awesome Tab
(use-package! awesome-tab
  :config
  (awesome-tab-mode t)
  (setq awesome-tab-style 'wave)
  (global-set-key (kbd "s-h") 'awesome-tab-backward-tab)
  (global-set-key (kbd "s-l") 'awesome-tab-forward-tab)
  (global-set-key (kbd "s-j") 'awesome-tab-forward-group)
  (global-set-key (kbd "s-k") 'awesome-tab-backward-group)
)

;; Wakatime
(global-wakatime-mode)

;; Chinese Input Method 

(setq load-path (cons (file-truename "~/.doom.d/rime") load-path))

(use-package! posframe)
(require 'liberime)
(use-package! pyim
  :ensure nil
  :demand t
  :config
  (setq default-input-method "pyim")
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-page-length 9)
)
(liberime-start "/Library/Input Methods/Squirrel.app/Contents/SharedSupport" (file-truename "~/.emacs.d/pyim/rime/"))
(liberime-select-schema "luna_pinyin_simp")
(setq pyim-default-scheme 'rime-quanpin)
