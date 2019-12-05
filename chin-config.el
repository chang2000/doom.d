;;; input/chinese/config.el -*- lexical-binding: t; -*-


(setq load-path (cons (file-truename "~/.emacs.d/modules/input/chinese/rime") load-path))
(use-package! pyim
  :after-call after-find-file pre-command-hook
  :config
  (setq pyim-dcache-directory (concat doom-cache-dir "pyim/")
        pyim-page-length 9
        pyim-page-tooltip 'posframe
        default-input-method "pyim"))

(require 'liberime)
(liberime-start "/Library/Input Methods/Squirrel.app/Contents/SharedSupport" (file-truename "~"))


(use-package! pangu-spacing
  :hook (text-mode . pangu-spacing-mode)
  :config
  ;; Always insert `real' space in org-mode.
  (setq-hook! 'org-mode-hook pangu-spacing-real-insert-separtor t))
