;;; init.el --- Emacs init file for shuuji3

;;; Commentary:
;;; There is nothing to say

;;; Code:

;;; 98-global-set-key.el
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "M-?") 'help)

(global-set-key (kbd "C-x C-k") 'kill-buffer)
(global-set-key (kbd "C-x C-o") 'other-window)
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "C-,") 'other-window)
(global-set-key (kbd "C-x C-0") 'delete-window)
(global-set-key (kbd "C-x 0") 'text-scale-adjust)
(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)

(global-set-key (kbd "C-#") 'hs-toggle-hiding)

;;; isearch
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
(define-key isearch-mode-map "\M-h" 'isearch-backward-kill-word)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (eq window-system 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-alternate-modifier 'super))

;;; tramp
(require 'tramp)
;;; add gcloud ssh support
;;; cf. [gcloud compute ssh でも tramp したい！](http://qiita.com/tanatana/items/218b19808f2428b125fe)
(add-to-list 'tramp-methods
  '("gc"
    (tramp-login-program "gcloud compute ssh")
    (tramp-login-args (("%h")))
    (tramp-async-args (("-q")))
    (tramp-remote-shell "/bin/sh")
    (tramp-remote-shell-args ("-c"))
    (tramp-gw-args
     (("-o" "GlobalKnownHostsFile=/dev/null")
      ("-o" "UserKnownHostsFile=/dev/null")
      ("-o" "StrictHostKeyChecking=no")))
    (tramp-default-port 22)))

;;; jslint
(require 'flymake-jslint)
(add-hook 'js-mode-hook 'flymake-jslint-load)

;;; crontab-mode
(add-to-list 'auto-mode-alist '("\\.cron\\(tab\\)?\\'" . crontab-mode))
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."    . crontab-mode))

;;; helm
(require 'helm-config)
(require 'helm-ag)
(require 'helm-descbinds)
(require 'helm)
(helm-mode 1)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-;") 'helm-mini)
(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-c b") 'helm-descbinds)
(global-set-key (kbd "C-c o") 'helm-occur)
(global-set-key (kbd "C-c s") 'helm-ag)
(global-set-key (kbd "C-c y") 'helm-show-kill-ring)
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;;; add an extension `psgi` for perl-mode
(add-to-list 'auto-mode-alist '("\\.psgi$" . perl-mode))

;;; edit server chrome extension
(require 'edit-server)
(add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
(add-hook 'edit-server-done-hook 'edit-server-maybe-htmlize-buffer)
(edit-server-start)

;;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; paredit
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'geiser-repl-mode-hook           #'enable-paredit-mode)

;;; popwin
(require 'popwin)
(popwin-mode 1)

;;; slime
(require 'slime)
(setq inferior-lisp-program "/usr/local/bin/ccl")
(setq slime-contribs '(slime-fancy))
(slime-setup '(slime-repl slime-fancy slime-banner slime-indentation slime-company))
(setq slime-net-coding-system 'utf-8-unix)
(append
 (list
  '("*slime-apropos*")
  '("*slime-macroexpansion*")
  '("*slime-description*")
  '("*slime-compilation*" :noselect t)
  '("*slime-xref*")
  '(sldb-mode :stick t)
  '(slime-repl-mode)
  '(slime-connection-list-mode))
 popwin:special-display-config)

;;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.3)
(setq company-minimum-prefix-length 2)
(setq company-echo-delay 0)
;; (company-quickhelp-mode)
(global-set-key (kbd "C-M-i") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)
(define-key company-active-map (kbd "C-h") 'backward-delete-char)
(define-key company-active-map (kbd "C-d") 'company-show-doc-buffer)
(define-key company-active-map (kbd "M-.") 'company-show-location)
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

;;; company-jedi
(add-to-list 'company-backends 'company-jedi)

;;; company-go
(require 'company-go)

;;; company-emoji
(require 'company-emoji)
(add-to-list 'company-backends 'company-emoji)
(defun --set-emoji-font (frame)
  "Adjust the font settings of FRAME so Emacs can display emoji properly."
  (if (eq system-type 'darwin)
      ;; For NS/Cocoa
      (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") frame 'prepend)
    ;; For Linux
    (set-fontset-font t 'symbol (font-spec :family "Symbola") frame 'prepend)))
(--set-emoji-font nil)
(add-hook 'after-make-frame-functions '--set-emoji-font)

;;; initial frame size
(setq initial-frame-alist
      '((top . 1) (left . 1) (width . 100) (height . 55)))
;; (setq default-frame-alist
;;       '((top . 1) (left . 1) (width . 85) (height . 55)))

;;; jedi
;; (require 'jedi-core)
;; (setq jedi:complete-on-dot t)
;; (setq jedi:use-shortcuts t)
;; (add-hook 'python-mode-hook 'jedi:setup)

;;; exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "PYTHONPATH")
  (exec-path-from-shell-copy-env "GOPATH"))

;;; ruby
(require 'inf-ruby)
(add-hook 'ruby-mode-hook 'inf-ruby-mode-hook)
(setq inf-ruby-default-implementation "pry")
(define-key inf-ruby-mode-map (kbd "C-i") 'company-complete)

;;; visual-regex-steroids
(require 'visual-regexp-steroids)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
;; to use visual-regexp-steroids's isearch instead of the built-in regexp isearch, also include the following lines:
(define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
(define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s

;;; emmet-mode
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;;; cua-mode
(cua-selection-mode t)
(global-set-key (kbd "M-RET") 'cua-set-rectangle-mark)

;;; ocaml
(add-to-list 'auto-mode-alist '("\\.ml$" . tuareg-mode))
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'caml-mode-hook 'merlin-mode)

;;; org-mode
(setq org-src-fontify-natively t)       ;coloring program source code
(setq org-return-follows-link t)        ;when return on the link, open
                                        ;the browser
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

;;; migemo
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

;; Set your installed path
(setq migemo-dictionary "/usr/local/opt/cmigemo/share/migemo/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(migemo-init)

;;; haskell
(require 'haskell)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(setq haskell-process-type 'auto)
(setq haskell-process-path-ghci "stack")
(setq haskell-process-args-ghci '("ghci"))

;;; credencials
(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "credencials")

;;; y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;;; customize
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("" . "/tmp"))))
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(column-number-mode t)
 '(custom-enabled-themes (quote (material)))
 '(custom-safe-themes
   (quote
    ("98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(global-linum-mode t)
 '(global-wakatime-mode t)
 '(haskell-interactive-popup-errors nil)
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-bookmarks helm-source-recentf helm-source-buffer-not-found)))
 '(helm-recentf-fuzzy-match t)
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(linum-format " %4d")
 '(org-agenda-files (quote ("~/Dropbox/org/todo.org")))
 '(org-log-done (quote note))
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (wakatime-mode mediawiki scratch gitignore-mode twittering-mode web-mode migemo processing-mode rhtml-mode persistent-scratch fortune-cookie angular-mode merlin markdown-mode jedi tuareg caml typescript-mode php-mode php+-mode emmet-mode django-mode company-ghci company-ghc flycheck-haskell multiple-cursors visual-regexp-steroids flymake-lua company-lua lua-mode company-inf-ruby inf-ruby company-go slime-company exec-path-from-shell company-jedi company-quickhelp company-emoji company fuzzy popwin slime paredit ein edit-server-htmlize edit-server gist helm-ag helm-ag-r helm-descbinds helm helm-dash magit autopair crontab-mode material-theme dart-mode flymake-jslint google-translate fish-mode yaml-mode osx-plist)))
 '(recentf-max-menu-items 1000)
 '(recentf-max-saved-items 2000)
 '(recentf-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(twittering-display-remaining t)
 '(twittering-status-format
   "%RT{↻ %R
} %i %S(@%s) %C / %@ %r
%FOLD[  ]{%T %QT{
+----
%FOLD[|]{%S(@%s)  %C(%@):
%FOLD[  ]{%T }}
+----}}
  via %f @ %l
--------------------------------------------------------------------------------")
 '(twittering-timeline-footer "-- old --")
 '(twittering-timeline-header "-- new --
")
 '(twittering-tinyurl-service (quote goo\.gl))
 '(twittering-use-icon-storage t)
 '(twittering-use-native-retweet t)
 '(typescript-indent-level 2)
 '(wakatime-python-bin "/Users/shuuji/.pyenv/versions/3.6.0/bin/python"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit font-lock-comment-face))))
 '(org-indent ((t nil)) t))

;;; emacsclient server
(server-start)

(provide 'init)
;;; init.el ends here
