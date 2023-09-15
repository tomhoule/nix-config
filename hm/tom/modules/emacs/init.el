;;; init.el --- tom's init.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; "GC magic hack" for latency
(use-package gcmh :config (gcmh-mode 1))

; ** Evil **

(defun dired-open-in-current-dir () "Open Dired in the directory of the current file."
       (interactive)
       (dired (file-name-directory buffer-file-name)))

(defvar my-leader-prefix (define-prefix-command 'my-evil-leader-map) "Leader keymap.")
(defvar my-localleader-prefix (define-prefix-command 'my-evil-localleader-map) "Local Leader keymap.")
(defvar my-leader-project-prefix (define-prefix-command 'my-evil-leader-project-map) "Project prefix keymap.")
(defvar my-leader-bookmark-prefix (define-prefix-command 'my-evil-leader-bookmark-map) "Bookmark prefix keymap.")

(use-package evil
  :init

  (setq evil-want-keybinding nil
	evil-undo-system 'undo-redo
	evil-redo-system 'undo-redo
	evil-want-C-u-scroll t)

  :config

  (keymap-set evil-normal-state-map "<SPC>" my-leader-prefix)
  (keymap-set evil-visual-state-map "<SPC>" my-leader-prefix)

  (keymap-set my-leader-prefix "<SPC>" '("Find file" . project-find-file))
  (keymap-set my-leader-prefix "b" `("Bookmarks" . ,my-leader-bookmark-prefix))
  (keymap-set my-leader-prefix "d" 'dired-open-in-current-dir)
  (keymap-set my-leader-prefix "m" `("Mode" . ,my-localleader-prefix))
  (keymap-set my-leader-prefix "p" `("Project" . ,my-leader-project-prefix))
  (keymap-set my-leader-prefix "u" '("Universal argument" . universal-argument))
  (keymap-set my-leader-prefix "t" '("Terminal" . term))
  (keymap-set my-leader-prefix "g" '("Git" . magit-status))
  (keymap-set my-leader-prefix "f" '("Format buffer" . eglot-format-buffer))

  (keymap-set my-leader-bookmark-prefix "j" 'bookmark-jump)
  (keymap-set my-leader-bookmark-prefix "s" 'bookmark-set)

  (keymap-set my-leader-project-prefix "f" 'project-find-file)
  (keymap-set my-leader-project-prefix "f" 'project-find-file)
  (keymap-set my-leader-project-prefix "r" 'project-find-regexp)

  (evil-global-set-key 'visual (kbd "gc") 'comment-dwim)
  (evil-global-set-key 'normal (kbd "gcc") 'comment-line)

  ;; Make sure <SPC> as a leader key works in other modes.
  (dolist (hook-name '(dired-mode-hook help-mode-hook))
    (add-hook hook-name
	      (lambda () (keymap-set evil-normal-state-local-map "<SPC>" my-leader-prefix))))

  (add-hook 'emacs-lisp-mode-hook
	    (lambda ()
	      (keymap-set my-localleader-prefix "r" 'eval-region)
	      (keymap-set my-localleader-prefix "f" 'flycheck-list-errors)
	      ))

  (evil-mode 1))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

; see https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :config
  (evil-collection-init))

; ** Appearance **

(use-package emacs
  :config

  ; UI
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)

  ; Inhibit the start theme. I like it, but the scratch buffer is more
  ; useful as a welcome screen.
  (setq inhibit-splash-screen t)

  ; Color theme
  (load-theme 'modus-operandi t)

  ; Line numbers
  (add-hook 'prog-mode-hook #'display-line-numbers-mode)

  ; Font
  (add-to-list 'default-frame-alist
	       '(font . "Hack-14"))

  ; Disable backup files
  (setq backup-directory-alist `(("." . "~/.emacs.d/backups")))

  ; Disable customize. From doom-emacs. See https://github.com/doomemacs/doomemacs/blob/35865ef5e89442e3809b8095199977053dd4210f/core/core-ui.el#L626C1-L640C1
  (dolist (sym '(customize-option customize-browse customize-group customize-face
				  customize-rogue customize-saved customize-apropos
				  customize-changed customize-unsaved customize-variable
				  customize-set-value customize-customized customize-set-variable
				  customize-apropos-faces customize-save-variable
				  customize-apropos-groups customize-apropos-options
				  customize-changed-options customize-save-customized))
    (put sym 'disabled "Customize is disabled from init.el."))
  (put 'customize-themes 'disabled "Use load-theme instead."))

; Display available shortcuts in popup. See
; https://github.com/justbur/emacs-which-key
(use-package which-key
  :init
  (setq which-key-idle-delay 0.2)
  :config
  (which-key-mode 1))

; Languages

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (add-hook 'rust-mode-hook 'eglot-ensure))

; Tree-sitter
(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; flycheck
(use-package flycheck
  :init
  (global-flycheck-mode 1))

;; Completion
(use-package vertico
  :init
  (vertico-mode))

;; Completion at point
(use-package corfu
  :config
  (setq tab-always-indent 'complete)
  :init
  (setq corfu-auto t
	corfu-auto-prefix 0)
  (global-corfu-mode 1)
  (corfu-echo-mode 1))

;; direnv integration
(use-package envrc
  :init
  (envrc-global-mode))

(use-package magit)

(provide 'init)
;;; init.el ends here
