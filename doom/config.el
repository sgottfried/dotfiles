;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 16 :weight 'semi-light))
;; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 16))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/notes")
(setq org-journal-enable-agenda-integration t)

(setq projectile-project-search-path '("~/workspace/"))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Themes
(defun my/appearance-change-hook ()
  (let ((appearance (plist-get (mac-application-state) :appearance)))
    (cond ((equal appearance "NSAppearanceNameAqua")
           (load-theme 'doom-gruvbox-light))
          ((equal appearance "NSAppearanceNameDarkAqua")
           (load-theme 'doom-gruvbox)))))

(add-hook 'after-init-hook 'my/appearance-change-hook)
(add-hook 'mac-effective-appearance-change-hook 'my/appearance-change-hook)

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(setq flycheck-check-syntax-automatically '(save mode-enable))

(use-package edit-server
  :ensure t
  :commands edit-server-start
  :init (if after-init-time
            (edit-server-start)
          (add-hook 'after-init-hook
                    #'(lambda() (edit-server-start)))))

(evil-define-key 'normal 'global (kbd "C-w o") 'delete-other-windows)
(evil-define-key 'normal 'global (kbd "C-h") 'evil-window-left)
(evil-define-key 'normal 'global (kbd "C-j") 'evil-window-down)
(evil-define-key 'normal 'global (kbd "C-k") 'evil-window-up)
(evil-define-key 'normal 'global (kbd "C-l") 'evil-window-right)
(evil-define-key 'normal 'global (kbd "-") 'dired-jump)
(evil-define-key 'normal 'global (kbd "gh") 'lsp-ui-doc-glance)
(evil-define-key 'normal 'global (kbd ",d") 'magit-ediff-show-unstaged)
(evil-define-key 'normal 'global (kbd ",l") 'doom/toggle-line-numbers)
(map! :leader
      :desc "Toggle Alternate File"
      "f a" #'projectile-toggle-between-implementation-and-test)
(map! :leader
      :desc "Close other windows"
      "w o" #'delete-other-windows)
(global-set-key (kbd "C-{") 'vterm-copy-mode)

;; Org-mode
(setq org-agenda-files (directory-files-recursively "~/notes" "\\.org$"))
(after! org
  (setq evil-auto-indent nil))

(setq electric-indent-mode nil)
(setq org-src-preserve-indentation t)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; org-journal
(setq org-journal-file-format "%Y/%m/%d.org" )
(setq sg/org-journal-daily-template
      (concat "** Meetings\n"
              "** Tickets\n"
              "** Tasks\n"
              "** Merged PRs\n"
              "** Reviewed PRs\n"
              "** Thoughts\n"
              "** Todos"
              ))
(setq org-journal-time-format "")

(defun sg/set-org-journal-date-format (&rest _args)
  (if (file-exists-p (concat org-directory "/journal/" (format-time-string "%Y/%m/%d") ".org")) "" (concat (format-time-string "%A, %B %d, %Y" "\n") sg/org-journal-daily-template)
      ))
(setq org-journal-date-format #'sg/set-org-journal-date-format)

(defun my-old-carryover (old_carryover)
  (save-excursion
    (let ((matcher (cdr (org-make-tags-matcher org-journal-carryover-items))))
      (dolist (entry (reverse old_carryover))
        (save-restriction
          (narrow-to-region (car entry) (cadr entry))
          (goto-char (point-min))
          (org-scan-tags '(lambda ()
                            (org-set-tags ":carried:"))
                         matcher org--matcher-tags-todo-only))))))

(setq org-journal-handle-old-carryover 'my-old-carryover)

;; magit
(setq magit-ediff-dwim-show-on-hunks t)

;; feature-mode
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
(add-hook 'feature-mode-hook 'display-line-numbers-mode)

;; blamer-mode
(use-package! blamer :defer t :config (blamer-mode 1))
