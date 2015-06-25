;; Emacs configuration file

;; Environment
(setenv "PATH" (concat "/usr/local/bin:/opt/local/bin:/usr/bin:/bin" (getenv "PATH")))
(require 'cl)

(load "package")
(package-initialize)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-archive-enable-list '(("melpa" deft magit)))

;; Define default packages
(defvar cyb/packages '(gist
		       magit
		       org
		       autopair)
  "Default packages")

;; magit configuration
(setq magit-last-seen-setup-instructions "1.4.0")

;; Install default packages
(defun cyb/packages-installed-p ()
  (loop for pkg in cyb/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (cyb/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg cyb/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; Startup options

;; splash screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; scroll bar, tool bar, menu bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; marking text
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;; indentation
(setq tab-width 2
      indent-tabs-mode nil)

;; turn off backup files
(setq make-backup-files nil)

;; yes and no
(defalias 'yes-or-no-p 'y-or-n-p)

;; ido mode ofcourse
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-user-virtual-buffers t)

;; column number
(setq column-number-mode t)

;; temp files
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transorms `((".*" ,temporary-file-directory t)))

;; autopair-mode
(require 'autopair)

;; themes - the same for window and terminal
(if window-system
    (load-theme 'wombat t)
  (load-theme 'wombat t))
