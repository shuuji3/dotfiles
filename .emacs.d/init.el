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
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
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

;;; slime
(setq inferior-lisp-program "/usr/local/bin/ccl")
(setq slime-contribs '(slime-fancy))

;;; popwin
(require 'popwin)
(popwin-mode 1)

;;; company
(add-hook 'after-init-hook 'global-company-mode)
;; (company-quickhelp-mode)

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
      '((top . 1) (left . 1) (width . 85) (height . 55)))
;; (setq default-frame-alist
;;       '((top . 1) (left . 1) (width . 85) (height . 55)))

;;; customize
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("" . "/tmp"))))
 '(column-number-mode t)
 '(custom-enabled-themes (quote (material)))
 '(custom-safe-themes
   (quote
    ("98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(linum-format " %4d")
 '(package-selected-packages
   (quote
    (company-quickhelp company-emoji company fuzzy auto-complete popwin slime paredit geiser ein edit-server-htmlize edit-server gist helm-ag helm-ag-r helm-descbinds helm helm-dash magit autopair crontab-mode material-theme dart-mode flymake-jslint google-translate fish-mode yaml-mode osx-plist)))
 '(recentf-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit font-lock-comment-face)))))

;;; emacsclient server
(server-start)

(provide 'init)
;;; init.el ends here
