;;; -*- lexical-binding: t; -*-

; ** Evil **

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  (setq evil-redo-system 'undo-redo)
  :config
  (evil-global-set-key 'normal (kbd "<SPC>d")
		       (lambda () (interactive)
			 (dired (file-name-directory buffer-file-name))))
  (evil-mode 1))

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
  :mode "\\.rs\\'")

; Tree-sitter
(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

