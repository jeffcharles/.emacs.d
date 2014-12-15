(setq inhibit-startup-screen t)

(when (eq system-type 'darwin)
  ; OS X does some funky stuff by default when internationalization is enabled
  (set-keyboard-coding-system nil)
  (setq mac-option-key-is-meta nil) ; Use command instead of alt as meta
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)
  ; In OS X, the pasteboard raises quit instead of nil sometimes
  (defadvice ns-get-pasteboard (around hack-empty-pasteboard compile activate)
    (condition-case err ad-do-it
      (quit (message "%s" (cadr err)) nil))))

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

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)) ; turn on simpler window navigation

(add-hook 'find-file-hook (lambda () (linum-mode 1))) ; turn on line numbering

(icomplete-mode 99) ; autocomplete for describe-variable and describe-function

(require 'package)
(package-initialize) ; The order you need to run this in seems to vary by OS
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             t)
(package-initialize) ; The order you need to run this in seems to vary by OS
; install packages
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package))))
 '(ac-js2 ac-nrepl better-defaults cider cl-lib clojure-mode dash editorconfig
          evil evil-paredit exec-path-from-shell js2-mode js2-refactor
          linum-relative load-dir magit markdown-mode midje-mode obsidian-theme
          paredit pkg-info powerline rainbow-delimiters smex undo-tree web-mode
          yaml-mode yasnippet))

; maximize window on start-up (needs to run after package stuff to work)
(toggle-frame-maximized)

(load-theme 'obsidian t)

(require 'evil)
(evil-mode 1)

(require 'linum-relative)

; Emacs term on OS X has a different PATH by default
(when (eq system-type 'darwin)
  (exec-path-from-shell-initialize))

; ido autocomplete on Emacs commands
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

; yasnippets
(require 'yasnippet)
(yas-global-mode 1)

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

; Use js2 mode for js files
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(require 'js2-refactor)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(require 'midje-mode)
(add-hook 'clojure-mode-hook 'midje-mode)

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

(require 'cider)
(add-hook 'cider-mode-hook 'subword-mode)
(add-hook 'cider-mode-hook 'paredit-mode)
(add-hook 'cider-mode-hook 'rainbow-delimiters-mode)

(require 'ac-nrepl)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-mode))

; Use tab to auto-complete in the repl
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook
          'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook
          'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-interaction-mode-hook
          'set-auto-complete-as-completion-at-point-function)

; Load all scripts in custom (for non-version controlled stuff)
(require 'load-dir)
(setq load-dirs "~/.emacs.d/custom")
(load-dirs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("bf42c68919c09268cb40934a66bc75c785001f3872ab5ad85c74988e60809b29" "61a83dbf3d3722d70abee8fb6dbc3566766ff86c098c2a925f2ccfd4d5b3a756" default)))
 '(js2-skip-preprocessor-directives t)
 '(linum-relative-current-symbol "")
 '(linum-relative-plusp-offset 0)
 '(nil t t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit (shadow default) :background "black" :foreground "DarkSlateGray")))))
