;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-compute-statistics t)
(setq use-package-always-ensure t)
(setq use-package-always-defer t)
(use-package diminish :ensure t)

(use-package doom-themes
  :defer nil
  :config
  (load-theme 'doom-gruvbox t))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(display-time)

(set-face-attribute 'default nil :font "Fira Code Retina" :height 160)
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 160)
(when (member "Source Sans Pro" (font-family-list))
  (set-face-attribute 'variable-pitch nil :font "Source Sans Pro" :height 160 :weight 'regular))

(scroll-bar-mode -1) ;Disable visible scrollbar
(tool-bar-mode -1) ;Disable the toolbar
(tooltip-mode -1) ;Disable tooltips
(set-fringe-mode 10) ;Give some breathing room
(menu-bar-mode -1) ;Disable the menu bar
(setq visual-bell t) ;visual bell
(setq ring-bell-function 'ignore)
(electric-pair-mode)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq inhibit-startup-screen t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
                ))
  (add-hook mode (lambda () (display-line-numbers-mode 0)
                   (git-gutter-mode 0)
                                                   )))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package helpful)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :custom
  (which-key-idle-delay 0.3))

(use-package general 
  :config
  (general-create-definer sg/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (sg/leader-keys
    "SPC" '(consult-project-buffer :which-key "find file in project")
    "/" '(consult-git-grep  :which-key "search project")
    "W" '(:ignore t :which-key "workspace")
    "Wn" '(persp-next :which-key "next")
    "Wp" '(persp-prev :which-key "next")
    "Wr" '(persp-rename :which-key "rename")
    "Ws" '(persp-switch :which-key "switch")
    "b" '(:ignore t :which-key "buffer")
    "bi" '(consult-buffer :which-key "switch")
    "bn" '(evil-jump-forward :which-key "forward")
    "bo" '(evil-jump-backward :which-key "backward")
    "bs" '(evil-write :which-key "save")
    "f" '(:ignore t :which-key "file")
    "ff" '(find-file :which-key "find")
    "fp" '((lambda() (interactive)(find-file "~/workspace/dotfiles/init.el")) :which-key "init.el")
    "g" '(magit-status :which-key "Git")
    "h" '(:ignore t :which-key "help")
    "hf" '(helpful-function :which-key "describe-function")
    "hi" '(info :which-key "info")
    "hk" '(describe-key  :which-key "describe-key")
    "hm" '(describe-mode  :which-key "describe-mode")
    "hv" '(helpful-variable :which-key "describe-variable")
    "n" '(:ignore t :which-key "notes")
    "nt" '(:ignore t :which-key "tasks")
    "nr" '(:ignore t :which-key "org roam")
    "nri" '(org-roam-node-insert :which-key "insert node")
    "nrf" '(org-roam-node-find :which-key "find node")
    "ntc" '(org-gtd-capture :which-key "capture task")
    "nti" '(org-gtd-process-inbox :which-key "process inbox")
    "o" '(:ignore t :which-key "open")
    "oa" '((lambda () (interactive) (org-agenda nil "a")) :which-key "org agenda")
    "ot" '(project-eshell t :which-key "open")
    "p" '(:ignore t :which-key "project")
    "pb" '(project-switch-to-buffer  t :which-key "buffer")
    "pp" '(project-switch-project  t :which-key "switch")
    "t" '(:ignore t :which-key "toggles")
    "tf" '(toggle-frame-fullscreen  :which-key "toggle fullscreen")
    "xe" '(eval-last-sexp :which-key "eval last expression")
    "w" '(evil-window-map :which-key "window"))

  (general-define-key
   :states 'normal
   :keymaps 'override
   "-" 'dired-jump))

(general-define-key 
 :states '(normal)
 :keymaps 'override
 "gt" 'persp-next)

(general-define-key 
 :states '(normal)
 :keymaps 'override
 "gT" 'persp-prev)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(define-key global-map (kbd "C-x g") 'magit-status)

(use-package evil
  :defer nil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (evil-mode 1))

  (use-package evil-collection
  :defer nil
  :after (evil magit)
  :config
  (evil-collection-init))


(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

;; enable evil-mode when opening org agenda

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(use-package blamer
  :bind (("s-i" . blamer-show-commit-info)
         ("C-c i" . blamer-show-posframe-commit-info))
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :background nil
                   :height 140
                   :italic t))))
(use-package gptel-magit
  :hook (magit-mode . gptel-magit-install))

(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq magit-ediff-dwim-show-on-hunks t)

;; performance tuning
(setq magit-refresh-status-buffer nil)
(setq magit-status-sections-hook
      '(magit-insert-status-headers
        magit-insert-untracked-files
        magit-insert-unstaged-changes
        magit-insert-staged-changes))
(setq magit-process-connection-type nil)
(setq magit-diff-context 3)
(setq magit-auto-revert-mode nil)
(setq magit-status-show-hunk-summary nil)
(setq magit-fetch nil)

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package gptel
:config
(setq gptel-model 'claude-sonnet-3.7
      gptel-backend (gptel-make-openai-oauth "OpenAI-sub")
      gptel-default-mode 'org-mode))

(use-package copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
	      ("<tab>" . 'copilot-accept-completion)
	      ("TAB" . 'copilot-accept-completion)
	      ("C-TAB" . 'copilot-accept-completion-by-word)
	      ("C-<tab>" . 'copilot-accept-completion-by-word))
  )

(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match 'insert) ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :init

  ;; Recommended: Enable Corfu globally.  Recommended since many modes provide
  ;; Capfs and Dabbrev can be used globally (M-/).  See also the customization
  ;; variable `global-corfu-modes' to exclude certain modes.
  (global-corfu-mode)

  ;; Enable optional extension modes:
  ;; (corfu-history-mode)
  ;; (corfu-mouse-mode)
  ;; (corfu-popupinfo-mode)
  )
(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
)

(use-package consult)

(use-package eglot
  :ensure nil
  :commands (eglot eglot-ensure)
  :hook ((typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (js-ts-mode . eglot-ensure))
  :custom
  (eglot-autoshutdown t))


(use-package typescript-ts-mode
  :ensure nil
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :hook ((typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure))
  :custom
  (typescript-ts-mode-indent-offset 2))

(setq treesit-language-source-alist
      '((typescript
         "https://github.com/tree-sitter/tree-sitter-typescript"
         "master"
         "typescript/src")
        (tsx
         "https://github.com/tree-sitter/tree-sitter-typescript"
         "master"
         "tsx/src")))

(defun sg/project-local-eslint ()
  "Return the project-local ESLint executable."
  (when-let* ((project (project-current nil))
              (root (project-root project))
              (eslint
               (expand-file-name "node_modules/.bin/eslint" root)))
    (when (file-executable-p eslint)
      eslint)))

(use-package flycheck
  :init
  (global-flycheck-mode))

(use-package flycheck-eglot
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (js . t)
   ))
(setq org-confirm-babel-evaluate nil)


(add-to-list 'org-structure-template-alist '("em" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("js" . "src js"))

(defun sg/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :hook (org-mode . sg/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers t)
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  )

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "◆" "◇" "✸" "✿")))

(setq org-gtd-update-ack "3.0.0")
(use-package org-gtd)

(with-eval-after-load 'org-faces
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    
    
    (when (member "Source Sans Pro" (font-family-list))
      (set-face-attribute (car face) nil :weight 'regular :height (cdr face) :font "Source Sans Pro"))))

(setq org-agenda-files (directory-files-recursively "~/notes" "\\.org$" nil nil 1))
(setq org-gtd-directory "~/notes/beorg")
(setq electric-indent-mode t)
(setq org-src-preserve-indentation t)

(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :foreground nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

(defun sg/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . sg/org-mode-visual-fill))

(setq org-todo-keywords
      '(
	(sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "IN_PROGRESS(p)" "|" "DONE(d)")
	(sequence "WAIT(w)" "CANCELLED(c)")))    


(setq org-refile-targets '(("Archive.org" . (:maxlevel . 1))))

(advice-add 'org-refile :after 'org-save-all-org-buffers)

(setq org-capture-templates
      `(("t" "Tasks / Projects")
	("tt" "Task" entry (file+olp "~/notes/beorg/Tasks.org" "Inbox")
         "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

	))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (js . t)
   ))
(setq org-confirm-babel-evaluate nil)

(use-package org-roam)
(setq org-roam-directory "~/notes/roam")
(setq org-roam-complete-everywhere t)

(use-package prettier-js
  :hook ((js-mode . prettier-js-mode)
         (web-mode . prettier-js-mode)
         (typescript-ts-mode . prettier-js-mode))
  :config
  (add-hook 'before-save-hook 'prettier-js))

(use-package json-mode)

(use-package feature-mode
  :mode ("\\.feature\\'" . feature-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
