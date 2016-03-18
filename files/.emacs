;; Quickly open large erlang logfiles in correct mode,
(setq large-file-warning-threshold nil)
;; and without font lock for performant search
(add-hook 'log-view-mode-hook (lambda () (font-lock-mode nil)))
;; http://stackoverflow.com/questions/730751/hiding-m-in-emacs
(defun hide-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))
(add-hook 'log-view-mode-hook 'hide-dos-eol)
(add-to-list 'auto-mode-alist '("\\.[0-9]+\\'" . log-view-mode))

(define-key ctl-x-map "\^b" 'electric-buffer-list)
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(global-font-lock-mode t)
(define-key esc-map "g" 'goto-line)
(setq-default transient-mark-mode t)
(setq initial-scratch-message nil)
(setq make-backup-files nil)
(menu-bar-mode -1)
(setq inhibit-startup-message t)
(if (fboundp 'desktop-save-mode) (desktop-save-mode 1))
(setq vc-follow-symlinks t)
(custom-set-variables
 ;; Your init file should contain only one such instance.
 ;; If there are more than one, they won't work right.
 '(show-paren-mode t nil (paren)))

(require 'whitespace)
;(global-whitespace-mode nil)
(setq whitespace-line-column 90
      whitespace-style '(tabs trailing tab-mark lines-tail))


(let ((dir "~/.emacs.d/"))
  (when (file-accessible-directory-p dir)
    (add-to-list 'load-path dir)))

;; erlang
(let ((dir "/usr/local/lib/erlang/"))
  (when (file-accessible-directory-p dir)
    (setq erlang-root-dir dir)
    (add-to-list 'load-path
                 (concat dir
                         "lib/"
                         (car (file-name-all-completions "tools-" (concat dir "lib")))
                         "emacs"))
    (add-to-list 'exec-path (concat dir "bin"))
    (require 'erlang-start)
    (add-hook 'erlang-mode-hook
              (lambda ()
                ;; when starting an Erlang shell in Emacs, default in the node name
                (setq inferior-erlang-machine-options '("-sname" "emacs"))
                ;; add Erlang functions to an imenu menu
                (imenu-add-to-menubar "imenu")))
    ;; A number of the erlang-extended-mode key bindings are useful in the shell too
    (defconst distel-shell-keys
      '(("\C-\M-i"   erl-complete)
        ("\M-?"      erl-complete)
        ("\M-."      erl-find-source-under-point)
        ("\M-,"      erl-find-source-unwind)
        ("\M-*"      erl-find-source-unwind)
        )
      "Additional keys to bind when in Erlang shell.")
    (add-hook 'erlang-shell-mode-hook
              (lambda ()
                ;; add some Distel bindings to the Erlang shell
                (dolist (spec distel-shell-keys)
                  (define-key erlang-shell-mode-map (car spec) (cadr spec)))))
    ))

(add-to-list 'auto-mode-alist '("\\.app\\'" . erlang-mode))

(defun revert-buffer-without-confirmation()
  "revert buffer without asking for confirmation"
  (interactive "")
  (revert-buffer t t t))

(global-set-key (kbd "C-c C-v") 'revert-buffer-without-confirmation)
