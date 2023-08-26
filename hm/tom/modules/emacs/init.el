;;; init.el --- tom's init.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

; ** Evil **

(defun dired-open-in-current-dir () "Open dired in the directory of the current file"
       (interactive)
       (dired (file-name-directory buffer-file-name)))

(let ((leader-prefix (define-prefix-command 'my-evil-leader-map))
      (leader-mode-prefix (define-prefix-command 'my-evil-leader-mode-map))
      (leader-project-prefix (define-prefix-command 'my-evil-leader-project-map))
      (leader-bookmark-prefix (define-prefix-command 'my-evil-leader-bookmark-map))
      )
  (use-package evil
    :init
    (setq evil-want-keybinding nil)
    (setq evil-undo-system 'undo-redo)
    (setq evil-redo-system 'undo-redo)
    (setq evil-want-C-u-scroll t)

    :config
    (keymap-set evil-normal-state-map "<SPC>" leader-prefix)
    (keymap-set leader-prefix "<SPC>" '("Find file" . project-find-file))
    (keymap-set leader-prefix "b" `("Bookmarks" . ,leader-bookmark-prefix))
    (keymap-set leader-prefix "d" 'dired-open-in-current-dir)
    (keymap-set leader-prefix "m" `("Mode" . ,leader-mode-prefix))
    (keymap-set leader-prefix "p" `("Project" . ,leader-project-prefix))
    (keymap-set leader-prefix "u" '("Universal argument" . universal-argument))

    (keymap-set leader-mode-prefix "i" 'indent-region)

    (keymap-set leader-bookmark-prefix "j" 'bookmark-jump)
    (keymap-set leader-bookmark-prefix "s" 'bookmark-set)

    (keymap-set leader-project-prefix "f" 'project-find-file)

    (evil-global-set-key 'visual (kbd "gc") 'comment-dwim)
    (evil-global-set-key 'normal (kbd "gcc") 'comment-line)

    ; Make sure <SPC> as a leader key works in other modes.
    (dolist (hook-name '(dired-mode-hook help-mode-hook))
	    (add-hook hook-name
		      (lambda () (keymap-set evil-normal-state-local-map "<SPC>" leader-prefix))))

    (evil-mode 1)))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

; see https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :config
  (evil-collection-init))

; ** Appearance **

; Color themes
(use-package doom-themes
  :config
  (load-theme 'doom-earl-grey t))

(use-package emacs
  :config

  ; UI
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)

  ; Line numbers
  (add-hook 'prog-mode-hook #'display-line-numbers-mode)

  ; Font
  (add-to-list 'default-frame-alist
	       '(font . "Hack-14"))

  ; Disable customize. From doom-emacs. See https://github.com/doomemacs/doomemacs/blob/35865ef5e89442e3809b8095199977053dd4210f/core/core-ui.el#L626C1-L640C1
  (dolist (sym '(customize-option customize-browse customize-group customize-face
				  customize-rogue customize-saved customize-apropos
				  customize-changed customize-unsaved customize-variable
				  customize-set-value customize-customized customize-set-variable
				  customize-apropos-faces customize-save-variable
				  customize-apropos-groups customize-apropos-options
				  customize-changed-options customize-save-customized))
    (put sym 'disabled "Doom doesn't support `customize', configure Emacs from $DOOMDIR/config.el instead"))
  (put 'customize-themes 'disabled "Set `doom-theme' or use `load-theme' in $DOOMDIR/config.el instead"))

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

;; Completion
(use-package vertico
  :init
  (vertico-mode))

;; Completion at point
(use-package corfu
  :init
  (global-corfu-mode 1)
  (setq tab-always-indent 'complete)
  (corfu-echo-mode 1))

(provide 'init)
;;; init.el ends here
