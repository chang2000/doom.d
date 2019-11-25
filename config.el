;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;
;;
;; Keybindings for emacs-mac
(global-set-key (kbd "s-c") #'clipboard-kill-ring-save)
(global-set-key (kbd "s-v") #'clipboard-yank)
(global-set-key (kbd "s-w") #'delete-frame)
(global-set-key (kbd "s-t") #'split-window-horizontally)
(global-set-key (kbd "s-T") #'split-window-vertically)
(global-set-key (kbd "s-o") #'ace-window)
(global-set-key (kbd "s-x") #'execute-extended-command)
(global-set-key (kbd "s-n") #'make-frame-command)
(global-set-key (kbd "s-s") #'save-buffer)

;; disable the command + H feature of macOS
(setq mac-pass-command-to-system nil)

;(setq doom-font (font-spec :family "Iosevka Slab" :size 20))
;;中文字体加强
(when IS-WINDOWS
  (when (display-graphic-p)
    (defun set-font (english chinese english-size chinese-size)
      (set-face-attribute 'default nil :font
                          (format   "%s:pixelsize=%d"  english english-size))
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font) charset
                          (font-spec :family chinese :size chinese-size))))
    (set-font "Iosevka Slab" "STFangsong" 21 21)
    ))

;; Private load-path
(add-to-list 'load-path "~/.doom.d/elisp")

;; My prefered themes
;; ;; disable all the theme before loading a new theme
(defun disable-all-themes ()
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(defadvice load-theme (before disable-themes-first activate)
  (disable-all-themes))

(load-theme 'spacemacs-dark)


;; Vim style buffer management
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
(setq auto-save-silent t)   ; quietly save

;; Tabnine
(use-package! company-tabnine
    :after company
    :config
    (add-to-list 'company-backends #'company-tabnine)
    (set-company-backend! 'prog-mode
      'company-tabnine 'company-capf 'company-yasnippet)
    (setq company-idle-delay 0)
    (setq company-show-numbers t))

(global-company-mode)

;; Awesome Tab
(require 'awesome-tab)
(awesome-tab-mode t)
(setq awesome-tab-style 'bar)
;; (global-set-key (kbd "s-1") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-2") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-3") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-4") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-5") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-6") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-7") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-8") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-9") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-0") 'awesome-tab-select-visible-tab)

(global-set-key (kbd "s-h") 'awesome-tab-backward-tab)
(global-set-key (kbd "s-l") 'awesome-tab-forward-tab)
(global-set-key (kbd "s-j") 'awesome-tab-forward-group)
(global-set-key (kbd "s-k") 'awesome-tab-backward-group)

;; Wakatime
(global-wakatime-mode)
