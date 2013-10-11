(when (eq system-type 'darwin)
  ; OS X does some funky stuff by default when internationalization is enabled
  (set-keyboard-coding-system nil)
  (setq mac-option-key-is-meta nil) ; Use command instead of alt as meta
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(server-start)

(setq user-mail-address "jeffreycharles@gmail.com")
(setq user-full-name "Jeffrey Charles")

(setq column-number-mode t)

(require 'whitespace)
(setq whitespace-display-mappings
      '((space-mark 32 [183] [46] [32])
        (newline-mark 10 [172 10] [10])
        (tab-mark 9 [9656 9] [9])))
(setq whitespace-style
      (delete 'spaces
              (delete 'space-mark whitespace-style)))
(global-whitespace-mode 1)

(electric-indent-mode 1) ; auto-indent

(add-hook 'find-file-hook (lambda () (linum-mode 1))) ; turn on line numbering

(require 'package)
; add melpa before initializing (necessary on Windows to install packages)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             t)
(package-initialize)
; install packages
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package))))
 '(ac-nrepl better-defaults cl-lib clojure-mode dash evil evil-paredit load-dir
            magit midje-mode nrepl nrepl-ritz obsidian-theme paredit pkg-info
            powerline rainbow-delimiters undo-tree))

(load-theme 'obsidian t)

(require 'evil)
(evil-mode 1)

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(autoload 'enable-paredit-mode
  "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(require 'evil-paredit)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       'evil-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'evil-paredit-mode)
(add-hook 'ielm-mode-hook             'enable-paredit-mode)
(add-hook 'ielm-mode-hook             'evil-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'evil-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'evil-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'evil-paredit-mode)
(add-hook 'clojure-mode-hook          'enable-paredit-mode)
(add-hook 'clojure-mode-hook          'evil-paredit-mode)

(require 'nrepl)
(add-hook 'nrepl-mode-hook 'subword-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)

(defun my-nrepl-mode-setup ()
  (require 'nrepl-ritz))
(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)

(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

; Use tab to auto-complete in the repl
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook
          'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-mode-hook
          'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook
          'set-auto-complete-as-completion-at-point-function)

; Use ac-nrepl's documentation in place of nrepl-doc
(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)

; Load all scripts in custom (for non-version controlled stuff)
(require 'load-dir)
(setq load-dirs "~/.emacs.d/custom")
(load-dirs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("bf42c68919c09268cb40934a66bc75c785001f3872ab5ad85c74988e60809b29" "61a83dbf3d3722d70abee8fb6dbc3566766ff86c098c2a925f2ccfd4d5b3a756" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit (shadow default) :background "black" :foreground "DarkSlateGray")))))
