;;; package --- init
;;; Commentary:

;;; Code:

;; Cask configuration
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; Theme
(require 'moe-theme)
(moe-dark)

;; Disable bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode (cons 0 nil))

(mapc
 (lambda (face)
   (set-face-attribute face nil :weight 'normal))
 (face-list))

;; No backup files
(setq make-backup-files nil)

;; "y or n" instard of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Don't show the startup screen
(setq inhibit-startup-message t)

;; Highlight matching brackets
(show-paren-mode 1)

;; Remove bell
(setq ring-bell-function 'ingore)

(require 'whitespace)

;; Use linux coding style
(require 'cc-mode)
(setq c-default-style "linux")
(setq-default c-basic-offset 8       ; Make all tab-spaces to 4 spaces
	      tab-width 8)           ; Make all tabs to 4 spaces

;; [C-c o] will try to find corresponding *.[ch] file.
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

(add-hook 'c-mode-common-hook 'flyspell-prog-mode)

;; Tabs or spaces? (set `t' for tabs)
;; Highlight characters that are at position 81 or more
(if t
    (progn
      ;; Always use `insert tabs when tab is pressed' and don't highlight tabs
      (setq c-tab-always-indent nil) ; Modify default c-mode behaviour
      (setq-default indent-tabs-mode t)
      (setq whitespace-style '(face empty trailing lines-tail))
      )
  ;; Never user tabs and show all tabs
  (setq-default indent-tabs-mode nil)
  (setq whitespace-style '(face empty trailing tabs lines-tail)))

;; scroll four lines at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(4 ((shift) . 4))) ;; four lines at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;;(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Paragraph auto-fill config
(setq-default fill-column 80)

;; Org configuration
(require 'org)
(setq org-log-done t)

;; Font configuration
;; Only use 'Source Code Pro' if it's installed.
(if (find-font (font-spec :name "Source Code Pro"))
    (set-face-attribute 'default nil :font "Source Code Pro-10"))

;; Flycheck configuration
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; Company configuration
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(global-set-key [f8] 'compile)
(global-set-key [f9] 'recompile)

(provide 'init)
;;; init.el ends here
