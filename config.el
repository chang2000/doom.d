;; Private packagies
(add-to-list 'load-path "~/.doom.d/elisp")
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq user-full-name "WANG Tianchang Alex"
      user-mail-address "wangtcalex@gmail.com")

;; (setq doom-font (font-spec :family "Source Code Variable" :size 18))
;; (setq doom-font (font-spec :family "Fira Code" :size 16))
(setq doom-font (font-spec :family "SF Mono" :size 16))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset (font-spec :family "PingFang SC"
                                       :size 16)))
(setq-default line-spacing 2)


(defun alex/disable-bold-and-fringe-bg-face-globally ()
"Disable bold face and fringe background in Emacs."
(interactive)
(set-face-attribute 'fringe nil :background nil)
(mapc #'(lambda (face)
            (when (eq (face-attribute face :weight) 'bold)
            (set-face-attribute face nil :weight 'normal)))
      (face-list)))

(add-hook 'after-init-hook #'alex/disable-bold-and-fringe-bg-face-globally)


;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-acario-light)
;; (setq doom-theme 'doom-one)

(setq org-directory "~/org/")

(setq display-line-numbers-type t)

(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(global-set-key (kbd "s-c") #'clipboard-kill-ring-save)
(global-set-key (kbd "s-v") #'clipboard-yank)
(global-set-key (kbd "s-w") #'delete-frame)
(global-set-key (kbd "s-o") #'ace-window)
(global-set-key (kbd "s-x") #'execute-extended-command)
(global-set-key (kbd "M-x") #'execute-extended-command)
(global-set-key (kbd "s-n") #'make-frame-command)
(global-set-key (kbd "s-s") #'save-buffer)


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


;; Package Preference

;; More completion congig
(setq company-idle-delay 0.01)
;; (set-company-backend! 'prog-mode
;;   'company-tabnine 'company-capf 'company-yasnippet)
(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"))

;; Disable line numbers
(setq display-line-numbers-type nil)

;(use-package! tron-legacy-theme
  ;:config
  ;(setq tron-legacy-theme-vivid-cursor t)
  ;(load-theme 'tron-legacy t))

;(use-package! org-bullets
  ;:config
  ;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  ;)

;(use-package! auto-save
  ;:config
  ;(auto-save-enable)
  ;(setq auto-save-silent t)
  ;(setq auto-save-delete-trailing-whitespace nil))

;; (use-package! telega
;;   :load-path  "~/telega.el"
;;   :commands (telega)
;;   :defer t)
