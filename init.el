(when (eq system-type 'darwin)
  ; OS X does some funky stuff by default when internationalization is enabled
  (set-keyboard-coding-system nil)
  (setq mac-option-key-is-meta nil) ; Use command instead of alt as meta
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(load-theme 'tango-dark t)

(setq user-mail-address "jeffreycharles@gmail.com")
(setq user-full-name "Jeffrey Charles")

(setq whitespace-display-mappings
      '((space-mark 32 [183] [46] [32])
        (newline-mark 10 [172 10] [10])
        (tab-mark 9 [9656 9] [9])))
(global-whitespace-mode 1)

(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             t)
; install packages
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package))))
 '(better-defaults clojure-mode evil powerline undo-tree))

(require 'evil)
(evil-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("61a83dbf3d3722d70abee8fb6dbc3566766ff86c098c2a925f2ccfd4d5b3a756" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
