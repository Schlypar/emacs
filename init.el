(defvar schlypar/home (concat (getenv "HOME") "/") "My home directory.")

;; Garbage Collections
(setq gc-cons-percentage 0.6)

;; Compile warnings
;;  (setq warning-minimum-level :emergency)
(setq native-comp-async-report-warnings-errors 'silent) ;; native-comp warning
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))


;; MISC OPTIMIZATIONS ----
;;; optimizations (froom Doom's core.el). See that file for descriptions.
(setq idle-update-delay 1.0)

;; Disabling bidi (bidirectional editing stuff)
(setq-default bidi-display-reordering 'left-to-right 
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)  ; emacs 27 only - disables bidirectional parenthesis

(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)
(setq fast-but-imprecise-scrolling t)
(setq inhibit-compacting-font-caches t)

(menu-bar-mode 0)

;; Remove all the litter

;; (setq user-emacs-directory (expand-file-name "~/.cache/emacs"))

;; (setq backup-directory-alist '(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))
;; or
(setq make-backup-files nil)

;; Move autosave
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
	  auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

;; remove locked files (not recommended)
;; (setq create-lockfiles nil)

;; Plugins folders
(setq projectile-known-projects-file (expand-file-name "tmp/projectile-bookmarks.eld" user-emacs-directory)
	  lsp-session-file (expand-file-name "tmp/.lsp-session-v1" user-emacs-directory))

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-verbose nil)

(use-package gcmh
  :diminish gcmh-mode
  :config
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 16 1024 1024))  ; 16mb
  (gcmh-mode 1))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-percentage 0.1))) ;; Default value for `gc-cons-percentage'

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" default))
 '(haskell-mode-hook '(flymake-haskell-multi-load lsp t))
 '(package-selected-packages
   '(dashboard flymake-haskell-multi lsp-haskell haskell-mode evil-nerd-commenter clang-format rainbow-delimiters elpy python-mode evil-magit dired-hide-dotfiles dired-open all-the-icons-dired dired-single yasnippet highlight-doxygen history-doxygen rtags irony auto-complete-clang flycheck cmake-ide company-box dap-lldb lsp-ivy lsp-ui lsp-mode smartparens ivy-prescient prescient cape company ace-window windresize hydra counsel all-the-icons-ivy-rich ivy general evil-collection evil which-key gcmh use-package))
 '(tab-stop-list
   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load (expand-file-name "jibfuncs.el" user-emacs-directory))

(use-package simpleclip :config (simpleclip-mode 1))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                vterm-mode-hook
                shell-mode-hook
	                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package doom-themes
  :init (load-theme 'doom-one t))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 25)))

(add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font Mono"))

(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 120)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font Propo" :height 120)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 135 :weight 'regular)

(use-package ligature
  :load-path "path-to-ligature-repo"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))
  ;; )

(server-start)

;; A cool mode to revert window configurations.
(winner-mode 1)

;; INTERACTION -----
(setq use-short-answers t) ;; When emacs asks for "yes" or "no", let "y" or "n" suffice
(setq confirm-kill-emacs 'yes-or-no-p) ;; Confirm to quit
(setq initial-major-mode 'org-mode ;; Major mode of new buffers
      initial-scratch-message ""
      initial-buffer-choice t) ;; Blank scratch buffer

;; WINDOW -----------
(setq frame-resize-pixelwise t)
(setq ns-pop-up-frames nil) ;; When opening a file (like double click) on Mac, use an existing frame
(setq window-resize-pixelwise nil)
(setq split-width-threshold 80) ;; How thin the window should be to stop splitting vertically (I think)

;; LINES -----------
(setq-default truncate-lines t)
(setq-default tab-width 4)
(setq default-tab-width 4)

(setq-default fill-column 80)
(setq line-move-visual t) ;; C-p, C-n, etc uses visual lines

(use-package paren
  ;; highlight matching delimiters
  :ensure nil
  :config
  (setq show-paren-delay 0.1
        show-paren-highlight-openparen t
        show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t)
  (show-paren-mode 1))

(setq sentence-end-double-space nil) ;; Sentences end with one space

(setq bookmark-set-fringe-mark nil)

;; SCROLLING ---------
(setq scroll-conservatively 1)
(setq
 mouse-wheel-follow-mouse 't
 mouse-wheel-progressive-speed nil
 ;; The most important setting of all! Make each scroll-event move 2 lines at
 ;; a time (instead of 5 at default). Simply hold down shift to move twice as
 ;; fast, or hold down control to move 3x as fast. Perfect for trackpads.
 mouse-wheel-scroll-amount '(3 ((shift) . 9)))
(setq mac-redisplay-dont-reset-vscroll t ;; sane trackpad/mouse scroll settings (doom)
      mac-mouse-wheel-smooth-scroll nil)

;; BELL/WARNING ------------
(setq visible-bell nil) ;; Make it ring (so no visible bell) (default)
(setq ring-bell-function 'ignore) ;; BUT ignore it, so we see and hear nothing


;; Uses system trash rather than deleting forever
(setq trash-directory (concat schlypar/home ".Trash"))
(setq delete-by-moving-to-trash t)

;; Try really hard to keep the cursor from getting stuck in the read-only prompt
;; portion of the minibuffer.
(setq minibuffer-prompt-properties '(read-only t intangible t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Explicitly define a width to reduce the cost of on-the-fly computation
(setq-default display-line-numbers-width 3)

;; When opening a symlink that links to a file in a git repo, edit the file in the
;; git repo so we can use the Emacs vc features (like Diff) in the future
(setq vc-follow-symlinks t)

;; BACKUPS/LOCKFILES --------
;; Don't generate backups or lockfiles.
(setq create-lockfiles nil
      make-backup-files nil
      ;; But in case the user does enable it, some sensible defaults:
      version-control t     ; number each backup file
      backup-by-copying t   ; instead of renaming current file (clobbers links)
      delete-old-versions t ; clean up after itself
      kept-old-versions 5
      kept-new-versions 5
      backup-directory-alist (list (cons "." (concat user-emacs-directory "backup/"))))

(use-package recentf
  :ensure nil
  :config
  (setq ;;recentf-auto-cleanup 'never
   ;; recentf-max-menu-items 0
   recentf-max-saved-items 200)
  (setq recentf-filename-handlers ;; Show home folder path as a ~
        (append '(abbreviate-file-name) recentf-filename-handlers))
  (recentf-mode))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; ENCODING -------------
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))       ; pretty
(prefer-coding-system 'utf-8)            ; pretty
(setq locale-coding-system 'utf-8)       ; please

(setq blink-cursor-interval 0.6)
(blink-cursor-mode 0)

(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t)

(setq what-cursor-show-names t) ;; improves C-x =

;; Weird thing where `list-colors-display` doesn't show all colors.
;; https://bug-gnu-emacs.gnu.narkive.com/Bo6OdySs/bug-5683-23-1-93-list-colors-display-doesn-t-show-all-colors
;; (setq x-colors (ns-list-colors))

(setq dired-kill-when-opening-new-dired-buffer t)

(setq reb-re-syntax 'string) ;; https://www.masteringemacs.org/article/re-builder-interactive-regexp-builder


(use-package which-key
  :diminish which-key-mode
  :init
  (which-key-mode)
  (which-key-setup-minibuffer)
  :config
  (setq which-key-idle-delay 0.3)
  (setq which-key-prefix-prefix "◉ ")
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-min-display-lines 3
        which-key-max-display-columns nil))



(use-package evil
  :init
  (setq evil-want-keybinding nil) ;; don't load Evil keybindings in other modes
  (setq evil-want-C-i-jump nil)
  (setq evil-want-fine-undo t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-Y-yank-to-eol t)
  :config

  ;;(evil-set-initial-state 'dashboard-mode 'motion)
  ;;(evil-set-initial-state 'debugger-mode 'motion)
  ;;(evil-set-initial-state 'pdf-view-mode 'motion)
  ;;(evil-set-initial-state 'bufler-list-mode 'emacs)
  ;;(evil-set-initial-state 'inferior-python-mode 'emacs)
  ;;(evil-set-initial-state 'term-mode 'emacs)
  ;;(evil-set-initial-state 'calc-mode 'emacs)

  ;; ----- Keybindings
  ;; I tried using evil-define-key for these. Didn't work.
  (define-key evil-window-map "\C-q" 'evil-delete-buffer) ;; Maps C-w C-q to evil-delete-buffer (The first C-w puts you into evil-window-map)
  (define-key evil-window-map "\C-w" 'kill-this-buffer)
  (define-key evil-motion-state-map "\C-b" 'evil-scroll-up) ;; Makes C-b how C-u is
  (define-key evil-motion-state-map [?\s-\\] 'evil-execute-in-emacs-state) ;; `super-\', by default it's just `\'

  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :ensure t)

(require 'general)

(defun jib/rg ()
  "Allows you to select a folder to ripgrep."
  (interactive)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    (call-interactively 'counsel-rg)))

(global-set-key (kbd "<tab>") (kbd "C-q <tab>"))
;; (setq-default tab-width 4)

(general-define-key
 :states '(normal motion visual)
 :keymaps 'override
 :prefix "SPC"

 ;; Top level functions
 ";" '(spacemacs/deft :which-key "deft")
 ":" '(project-find-file :which-key "p-find file")
 "," '(counsel-recentf :which-key "recent files")
 "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
 "q" '(save-buffers-kill-terminal :which-key "quit emacs")
 "r" '(jump-to-register :which-key "registers")
 "c" 'org-capture
 "e" 'eval-expression
 "/" 'evilnc-comment-or-uncomment-lines
 "u" 'undo-tree-visualize
 "sd" 'flymake-show-buffer-diagnostics
 "vca" 'lsp-execute-code-action
 "k" 'lsp-ui-doc-show
 "K" 'lsp-ui-doc-hide

 ;; "Applications"
"a" '(nil :which-key "applications")
"ao" '(org-agenda :which-key "org-agenda")
"am" '(mu4e :which-key "mu4e")
"aC" '(calc :which-key "calc")
"ac" '(org-capture :which-key "org-capture")
"aqq" '(org-ql-view :which-key "org-ql-view")
"aqs" '(org-ql-search :which-key "org-ql-search")

"ab" '(nil :which-key "browse url")
"abf" '(browse-url-firefox :which-key "firefox")
"abc" '(browse-url-chrome :which-key "chrome")
"abx" '(xwidget-webkit-browse-url :which-key "xwidget")
"abg" '(jib/er-google :which-key "google search")

;; Buffers
"b" '(nil :which-key "buffer")
"bb" '(counsel-switch-buffer :which-key "switch buffers")
"bd" '(evil-delete-buffer :which-key "delete buffer")
"bs" '(jib/switch-to-scratch-buffer :which-key "scratch buffer")
"bm" '(jib/kill-other-buffers :which-key "kill other buffers")
"bi" '(clone-indirect-buffer  :which-key "indirect buffer")
"br" '(revert-buffer :which-key "revert buffer")

;; Files
"f" '(nil :which-key "files")
"fb" '(counsel-bookmark :which-key "bookmarks")
"ff" '(counsel-find-file :which-key "find file")
"fn" '(spacemacs/new-empty-buffer :which-key "new file")
"fr" '(counsel-recentf :which-key "recent files")
"fR" '(rename-file :which-key "rename file")
"fs" '(save-buffer :which-key "save buffer")
"fS" '(evil-write-all :which-key "save all buffers")
"fo" '(reveal-in-osx-finder :which-key "reveal in finder")
"fO" '(jib/open-buffer-file-mac :which-key "open buffer file")

;; Help/emacs
"h" '(nil :which-key "help/emacs")

"hv" '(counsel-describe-variable :which-key "des. variable")
"hb" '(counsel-descbinds :which-key "des. bindings")
"hM" '(describe-mode :which-key "des. mode")
"hf" '(counsel-describe-function :which-key "des. func")
"hF" '(counsel-describe-face :which-key "des. face")
"hk" '(describe-key :which-key "des. key")

"hed" '((lambda () (interactive) (jump-to-register 67)) :which-key "edit dotfile")

"hm" '(nil :which-key "switch mode")
"hme" '(emacs-lisp-mode :which-key "elisp mode")
"hmo" '(org-mode :which-key "org mode")
"hmt" '(text-mode :which-key "text mode")

"hp" '(nil :which-key "packages")
"hpr" 'package-refresh-contents
"hpi" 'package-install
"hpd" 'package-delete

;; Text
"x" '(nil :which-key "text")
"xc" '(rtags-create-doxygen-comment :which-key "create doxygen comment")
"xC" '(jib/copy-whole-buffer-to-clipboard :which-key "copy whole buffer to clipboard")
"xr" '(anzu-query-replace :which-key "find and replace")
"xs" '(yas-insert-snippet :which-key "insert yasnippet")
"xf" '(flush-lines :which-key "flush-lines")
"xR" '(replace-regexp :which-key "replace-regexp")

;; Toggles
"t" '(nil :which-key "toggles")
"tt" '(toggle-truncate-lines :which-key "truncate lines")
"tv" '(visual-line-mode :which-key "visual line mode")
"tn" '(display-line-numbers-mode :which-key "display line numbers")
"ta" '(mixed-pitch-mode :which-key "variable pitch mode")
"ty" '(counsel-load-theme :which-key "load theme")
"tw" '(writeroom-mode :which-key "writeroom-mode")
"tR" '(read-only-mode :which-key "read only mode")
"tI" '(toggle-input-method :which-key "toggle input method")
"tr" '(display-fill-column-indicator-mode :which-key "fill column indicator")
"tm" '(hide-mode-line-mode :which-key "hide modeline mode")

;; Project
"p" '(nil :which-key "project")
"pf" '(jib/rg :which-key "ripgrep")
"ps" 'swiper
"pv" '(dired-jump :which-key "find file")

;; Cmake
"c" '(nil :which-key "cmake")'
"cc" 'cmake-ide-compile
"cr" 'cmake-ide-run-cmake
"cf" 'clang-format-buffer

;; Python
"P" '(nil :which-key "python")
"Pc" 'elpy-check
"Ps" 'elpy-shell-switch-to-shell-in-current-window
"Pf" 'elpy-format-code

;; Haskell
"H" '(nil :which-key "haskell")
"Hs" '(haskell-session-change :which-key "haskell interactive shell")

;; Git
"g" '(nil :which-key "git")
"gg" 'magit-status

;; Windows
"w" '(nil :which-key "window")
"wm" '(jib/toggle-maximize-buffer :which-key "maximize buffer")
"wN" '(make-frame :which-key "make frame")
"wd" '(evil-window-delete :which-key "delete window")
"wc" '(evil-window-delete :which-key "delete window")
"w-" '(jib/split-window-vertically-and-switch :which-key "split below")
"w/" '(jib/split-window-horizontally-and-switch :which-key "split right")
"wr" '(jb-hydra-window/body :which-key "hydra window")
"wl" '(evil-window-right :which-key "evil-window-right")
"wh" '(evil-window-left :which-key "evil-window-left")
"wj" '(evil-window-down :which-key "evil-window-down")
"wk" '(evil-window-up :which-key "evil-window-up")
"wz" '(text-scale-adjust :which-key "text zoom")
) ;; End SPC prefix block

;; All-mode keymaps
(general-def
  :keymaps 'override

  ;; Emacs --------
  "M-x" 'counsel-M-x
  "ß" 'evil-window-next ;; option-s
  "Í" 'other-frame ;; option-shift-s
  "C-S-B" 'counsel-switch-buffer
  "∫" 'counsel-switch-buffer ;; option-b
  "s-b" 'counsel-switch-buffer ;; super-b
  "s-o" 'jb-hydra-window/body

  ;; Remapping normal help features to use Counsel version
  "C-h v" 'counsel-describe-variable
  "C-h o" 'counsel-describe-symbol
  "C-h f" 'counsel-describe-function
  "C-h F" 'counsel-describe-face

  ;; Editing ------
  "M-v" 'simpleclip-paste
  "M-V" 'evil-paste-after ;; shift-paste uses the internal clipboard
  "M-c" 'simpleclip-copy
  "M-u" 'capitalize-dwim ;; Default is upcase-dwim
  "M-U" 'upcase-dwim ;; M-S-u (switch upcase and capitalize)

  ;; Utility ------
  "C-c c" 'org-capture
  "C-c a" 'org-agenda
  "s-\"" 'ispell-word ;; that's super-shift-'
  "M-+" 'jib/calc-speaking-time
  "M-=" 'count-words
  "C-'" 'avy-goto-char-2
  "C-x C-b" 'bufler-list

  ;; super-number functions
  "s-1" 'mw-thesaurus-lookup-dwim
  "s-!" 'mw-thesaurus-lookup
  "s-2" 'ispell-buffer
  "s-3" 'revert-buffer
  "s-4" '(lambda () (interactive) (counsel-file-jump nil jib/dropbox))
  "s-5" '(lambda () (interactive) (counsel-rg nil jib/dropbox))
  "s-6" 'org-capture
  "s-7" 'jib/open-dropbox-folder-in-finder
  "s-8" 'jib/zoxide-wrapper

  "s-w" 'kill-this-buffer
  )

(general-def
  :states '(normal visual motion)
  ;; "gc" 'comment-dwim
  ;; "gC" 'comment-line


  "u" 'undo-tree-undo
  "U" 'undo-tree-redo

  "j" 'evil-next-visual-line ;; I prefer visual line navigation
  "k" 'evil-previous-visual-line ;; "

  ;; "gf" 'xah-open-file-at-cursor
  ;; "f" 'evil-avy-goto-char-in-line

  ";" 'jib/split-window-horizontally-and-switch
  "-" 'jib/split-window-vertically-and-switch  

  "\\" '(lambda () (interactive) (org-agenda nil "c"))
  "|" '(lambda () (interactive) (org-ql-view "Columbia Todo"))
  "]\\" '(lambda () (interactive) (org-agenda nil "w"))
  )

(general-def
 :keymaps 'emacs
  "C-w C-q" 'kill-this-buffer
 )

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative) ;; for relative line numbers

(use-package ivy
  :diminish ivy-mode
  :config
  (setq ivy-extra-directories nil) ;; Hides . and .. directories
  (setq ivy-initial-inputs-alist nil) ;; Removes the ^ in ivy searches
  (setq-default ivy-height 10)
  (setq ivy-fixed-height-minibuffer t)
  (add-to-list 'ivy-height-alist '(counsel-M-x . 7)) ;; Don't need so many lines for M-x, I usually know what command I want

  (ivy-mode 1)

  ;; Shows a preview of the face in counsel-describe-face
  (add-to-list 'ivy-format-functions-alist '(counsel-describe-face . counsel--faces-format-function))

  :general
  (general-define-key
   ;; Also put in ivy-switch-buffer-map b/c otherwise switch buffer map overrides and C-k kills buffers
   :keymaps '(ivy-minibuffer-map ivy-switch-buffer-map)
   "S-SPC" 'nil
   "C-SPC" 'ivy-restrict-to-matches ;; Default is S-SPC, changed this b/c sometimes I accidentally hit S-SPC
   ;; C-j and C-k to move up/down in Ivy
   "C-k" 'ivy-previous-line
   "C-j" 'ivy-next-line)
  )

;; Nice icons in Ivy. Replaces all-the-icons-ivy.
(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1)
  :config
  (setq all-the-icons-ivy-rich-icon-size 1.0))

(use-package ivy-rich
  :after ivy
  :init
  (setq ivy-rich-path-style 'abbrev)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  :config
  (ivy-rich-mode 1))

(use-package prescient
  :config
  (setq-default history-length 1000)
  (setq-default prescient-history-length 1000) ;; More prescient history
  (prescient-persist-mode +1))

;; Use `prescient' for Ivy menus.
(use-package ivy-prescient
  :after ivy
  :config
  ;; don't prescient sort these commands
  (dolist (command '(org-ql-view counsel-find-file fontaine-set-preset))
    (setq ivy-prescient-sort-commands (append ivy-prescient-sort-commands (list command))))
  (ivy-prescient-mode +1))

;; (use-package company-prescient
;;   :defer 2
;;   :after company
;;   :config
;;   (company-prescient-mode +1))

(require 'undo-tree)
(setq undo-tree-auto-save-history 1)

(defadvice undo-tree-make-history-save-file-name
  (after undo-tree activate)
  (setq ad-return-value (concat ad-return-value ".gz")))

(global-undo-tree-mode)

(use-package smartparens
  :diminish smartparens-mode
  :defer 1
  :config
  ;; Load default smartparens rules for various languages
  (require 'smartparens-config)
  (setq sp-max-prefix-length 25)
  (setq sp-max-pair-length 4)
  (setq sp-highlight-pair-overlay nil
        sp-highlight-wrap-overlay nil
        sp-highlight-wrap-tag-overlay nil)

  (with-eval-after-load 'evil
    (setq sp-show-pair-from-inside t)
    (setq sp-cancel-autoskip-on-backward-movement nil)
    (setq sp-pair-overlay-keymap (make-sparse-keymap)))

  (let ((unless-list '(sp-point-before-word-p
                       sp-point-after-word-p
                       sp-point-before-same-p)))
    (sp-pair "'"  nil :unless unless-list)
    (sp-pair "\"" nil :unless unless-list))

  ;; In lisps ( should open a new form if before another parenthesis
  (sp-local-pair sp-lisp-modes "(" ")" :unless '(:rem sp-point-before-same-p))

  ;; Don't do square-bracket space-expansion where it doesn't make sense to
  (sp-local-pair '(emacs-lisp-mode org-mode markdown-mode gfm-mode)
                 "[" nil :post-handlers '(:rem ("| " "SPC")))


  (dolist (brace '("(" "{" "["))
    (sp-pair brace nil
             :post-handlers '(("||\n[i]" "RET") ("| " "SPC"))
             ;; Don't autopair opening braces if before a word character or
             ;; other opening brace. The rationale: it interferes with manual
             ;; balancing of braces, and is odd form to have s-exps with no
             ;; whitespace in between, e.g. ()()(). Insert whitespace if
             ;; genuinely want to start a new form in the middle of a word.
             :unless '(sp-point-before-word-p sp-point-before-same-p)))
  (smartparens-global-mode t))

(setq c-default-style "bsd")
(setq c-default-style "bsd" c-basic-offset 4)
;; (add-to-list 'c-default-style '(c-mode "bsd"))
;; (add-to-list 'c-offsets-alist '(substatement-open . 0))

;; (use-package smartparens)

;; (defun indent-between-pair (&rest _ignored)
;;   (newline)
;;   (indent-according-to-mode)
;;   (forward-line -1)
;;   (indent-according-to-mode))

;; (sp-local-pair 'prog-mode "{" nil :post-handlers '((indent-between-pair "RET")))
;; (sp-local-pair 'prog-mode "[" nil :post-handlers '((indent-between-pair "RET")))
;; (sp-local-pair 'prog-mode "(" nil :post-handlers '((indent-between-pair "RET")))

(use-package hydra :defer t)

;; This Hydra lets me swich between variable pitch fonts.
(defhydra jb-hydra-variable-fonts (:pre (mixed-pitch-mode 0)
                                     :post (mixed-pitch-mode 1))
  ("t" (set-face-attribute 'variable-pitch nil :family "Times New Roman" :height 160) "Times New Roman")
  ("g" (set-face-attribute 'variable-pitch nil :family "EB Garamond" :height 160 :weight 'normal) "EB Garamond")
  ("n" (set-face-attribute 'variable-pitch nil :slant 'normal :weight 'normal :height 160 :width 'normal :foundry "nil" :family "Nunito") "Nunito")
  )

(defhydra jb-hydra-theme-switcher (:hint nil)
  "
     Dark                ^Light^
----------------------------------------------
_1_ one              _z_ one-light 
_2_ vivendi          _x_ operandi
_3_ molokai          _c_ jake-plain
_4_ snazzy           _v_ flatwhite
_5_ old-hope         _b_ tomorrow-day
_6_ henna                ^
_7_ kaolin-galaxy        ^
_8_ peacock              ^
_9_ jake-plain-dark      ^
_0_ monokai-machine      ^
_-_ xcode                ^
_q_ quit                 ^
^                        ^
"

  ;; Dark
  ("1" (jib/load-theme 'doom-one)				 "one")
  ("2" (jib/load-theme 'modus-vivendi)			 "modus-vivendi")
  ("3" (jib/load-theme 'doom-molokai)			 "molokai")
  ("4" (jib/load-theme 'doom-snazzy)			 "snazzy")
  ("5" (jib/load-theme 'doom-old-hope)			 "old-hope")
  ("6" (jib/load-theme 'doom-henna)				 "henna")
  ("7" (jib/load-theme 'kaolin-galaxy)			 "kaolin-galaxy")
  ("8" (jib/load-theme 'doom-peacock)			 "peacock")
  ("9" (jib/load-theme 'jake-doom-plain-dark)	 "jake-plain-dark")
  ("0" (jib/load-theme 'doom-monokai-machine)	 "monokai-machine")
  ("-" (jib/load-theme 'doom-xcode)				 "xcode")

  ;; Light
  ("z" (jib/load-theme 'doom-one-light)			 "one-light")
  ("x" (jib/load-theme 'modus-operandi)			 "modus-operandi")
  ("c" (jib/load-theme 'jake-doom-plain)		 "jake-plain")
  ("v" (jib/load-theme 'doom-flatwhite)			 "flatwhite")
  ("b" (jib/load-theme 'doom-opera-light)		 "tomorrow-day")
  ("q" nil))

;; I think I need to initialize windresize to use its commands
;;(windresize)
;;(windresize-exit)

;;(require 'windresize)

;; All-in-one window managment. Makes use of some custom functions,
;; `ace-window' (for swapping), `windmove' (could probably be replaced
;; by evil?) and `windresize'.
;; inspired by https://github.com/jmercouris/configuration/blob/master/.emacs.d/hydra.el#L86

(use-package hydra :defer t)

;; This Hydra lets me swich between variable pitch fonts.
(defhydra jb-hydra-variable-fonts (:pre (mixed-pitch-mode 0)
                                     :post (mixed-pitch-mode 1))
  ("t" (set-face-attribute 'variable-pitch nil :family "Times New Roman" :height 160) "Times New Roman")
  ("g" (set-face-attribute 'variable-pitch nil :family "EB Garamond" :height 160 :weight 'normal) "EB Garamond")
  ("n" (set-face-attribute 'variable-pitch nil :slant 'normal :weight 'normal :height 160 :width 'normal :foundry "nil" :family "Nunito") "Nunito")
  )

(defhydra jb-hydra-theme-switcher (:hint nil)
  "
     Dark                ^Light^
----------------------------------------------
_1_ one              _z_ one-light 
_2_ vivendi          _x_ operandi
_3_ molokai          _c_ jake-plain
_4_ snazzy           _v_ flatwhite
_5_ old-hope         _b_ tomorrow-day
_6_ henna                ^
_7_ kaolin-galaxy        ^
_8_ peacock              ^
_9_ jake-plain-dark      ^
_0_ monokai-machine      ^
_-_ xcode                ^
_q_ quit                 ^
^                        ^
"

  ;; Dark
  ("1" (jib/load-theme 'doom-one)				 "one")
  ("2" (jib/load-theme 'modus-vivendi)			 "modus-vivendi")
  ("3" (jib/load-theme 'doom-molokai)			 "molokai")
  ("4" (jib/load-theme 'doom-snazzy)			 "snazzy")
  ("5" (jib/load-theme 'doom-old-hope)			 "old-hope")
  ("6" (jib/load-theme 'doom-henna)				 "henna")
  ("7" (jib/load-theme 'kaolin-galaxy)			 "kaolin-galaxy")
  ("8" (jib/load-theme 'doom-peacock)			 "peacock")
  ("9" (jib/load-theme 'jake-doom-plain-dark)	 "jake-plain-dark")
  ("0" (jib/load-theme 'doom-monokai-machine)	 "monokai-machine")
  ("-" (jib/load-theme 'doom-xcode)				 "xcode")

  ;; Light
  ("z" (jib/load-theme 'doom-one-light)			 "one-light")
  ("x" (jib/load-theme 'modus-operandi)			 "modus-operandi")
  ("c" (jib/load-theme 'jake-doom-plain)		 "jake-plain")
  ("v" (jib/load-theme 'doom-flatwhite)			 "flatwhite")
  ("b" (jib/load-theme 'doom-opera-light)		 "tomorrow-day")
  ("q" nil))

;; I think I need to initialize windresize to use its commands
(windresize)
(windresize-exit)

;; (require 'windresize)

;; All-in-one window managment. Makes use of some custom functions,
;; `ace-window' (for swapping), `windmove' (could probably be replaced
;; by evil?) and `windresize'.
;; inspired by https://github.com/jmercouris/configuration/blob/master/.emacs.d/hydra.el#L86
(defhydra jb-hydra-window (:hint nil)
   "
Movement      ^Split^            ^Switch^        ^Resize^
----------------------------------------------------------------
_M-<left>_  <   _;_ vertical      _b_uffer        _<left>_  <
_M-<right>_ >   _-_ horizontal    _f_ind file     _<down>_  ↓
_M-<up>_    ↑   _m_aximize        _s_wap          _<up>_    ↑
_M-<down>_  ↓   _c_lose           _[_backward     _<right>_ >
_q_uit          _e_qualize        _]_forward     ^
^               ^               _K_ill         ^
^               ^                  ^             ^
"
   ;; Movement
   ("M-<left>" windmove-left)
   ("M-<down>" windmove-down)
   ("M-<up>" windmove-up)
   ("M-<right>" windmove-right)

   ;; Split/manage
   ("-" jib/split-window-vertically-and-switch)
   (";" jib/split-window-horizontally-and-switch)
   ("c" evil-window-delete)
   ("d" evil-window-delete)
   ("m" delete-other-windows)
   ("e" balance-windows)

   ;; Switch
   ("b" counsel-switch-buffer)
   ("f" counsel-find-file)
   ("P" project-find-file)
   ("s" ace-swap-window)
   ("[" previous-buffer)
   ("]" next-buffer)
   ("K" kill-this-buffer)

   ;; Resize
   ("<left>" windresize-left)
   ("<right>" windresize-right)
   ("<down>" windresize-down)
   ("<up>" windresize-up)

   ("q" nil))

(defhydra jb-hydra-org-table ()
  "
_c_ insert col    _v_ delete col    Move col: _h_, _l_
_r_ insert row    _d_ delete row    Move row: _j_, _k_
_n_ create table  _i_ create hline
_u_ undo
_q_ quit

"
  ("n" org-table-create "create table")
  ("c" org-table-insert-column "insert col")
  ("r" org-table-insert-row "insert row")
  ("v" org-table-delete-column "delete col")
  ("d" org-table-kill-row "delete row")
  ("i" org-table-insert-hline "hline")

  ("u" undo-fu-only-undo "undo")

  ("h" org-table-move-column-left "move col left")
  ("l" org-table-move-column-right "move col right")
  ("k" org-table-move-row-up "move row up")
  ("j" org-table-move-row-down "move row down")

  ("<left>" org-table-previous-field)
  ("<right>" org-table-next-field)
  ("<up>" previous-line)
  ("<down>" org-table-next-row)

  ("q" nil "quit"))

(use-package company
  :after lsp-mode
  :diminish company-mode
  :general
  (general-define-key :keymaps 'company-active-map
                      "<tab>" 'company-select-next
                      "<backtab>" 'company-select-previous)
  :init
  ;; These configurations come from Doom Emacs:
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-minimum-prefix-length 2
        company-tooltip-limit 14
        company-tooltip-align-annotations t
        company-require-match 'never
        company-global-modes '(not erc-mode message-mode help-mode gud-mode)
        company-frontends
        '(company-pseudo-tooltip-frontend  ; always show candidates in overlay tooltip
          company-echo-metadata-frontend)  ; show selected candidate docs in echo area
        company-backends '(company-capf company-files company-keywords)
        company-auto-complete nil
        company-auto-complete-chars nil
        company-dabbrev-other-buffers nil
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil)

  :custom
     (company-minimum-prefix-length 1)
     (company-idle-delay 0.0))
  ;; :custom-face
  ;; (company-tooltip ((t (:family "FiraCode Nerd Font")))))

;; (use-package company
;;   :after lsp-mode
;;   :hook (prog-mode . company-mode)
;;   :bind (:map company-active-map
;;               ("<tab>" . company-complete-selection))
;;   ;;       (:map lsp-mode-map
;;   ;;             ("<tab>" . company-indent-or-complete-common))
;;   :custom
;;     (company-minimum-prefix-length 1)
;;     (company-idle-delay 0.0))


;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

;; (use-package cape
;;   :init
;;   (add-to-list 'completion-at-point-functions #'cape-file)
;;   (add-to-list 'completion-at-point-functions #'cape-keyword)
;;   ;; kinda confusing re length, WIP/TODO
;;   ;; :hook (org-mode . (lambda () (add-to-list 'completion-at-point-functions #'cape-dabbrev)))
;;   ;; :config
;;   ;; (setq dabbrev-check-other-buffers nil
;;   ;;       dabbrev-check-all-buffers nil
;;   ;;       cape-dabbrev-min-length 6)
;;   )

(defun sch/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c-mode . lsp)
         (c++-mode . lsp)
		 (python-mode . lsp)
		 (haskell-mode . lsp)
         (lsp-mode . sch/lsp-mode-setup)
		 (lsp-mode . flymake-mode)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

(highlight-indentation-mode -1)

(use-package indent-guide
  :ensure t
  :hook (prog-mode . indent-guide-mode))

(setq indent-guide-char "|")



;; (use-package highlight-indent-guides
;;   :ensure nil
;;   :hook (prog-mode . highlight-indent-guides-mode))

;; (setq highlight-indent-guides-method 'line)
;; (setq highlight-indent-guides-character 124)
;; (setq highlight-indent-guides-character-face "FiraCode Nerd Font Mono")
;; (setq highlight-indent-guides-responsive 'nil)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package python-mode
  :ensure t
  :custom
  (python-shell-interpreter "python3"))

(use-package haskell-mode)
(add-hook 'haskell-mode-hook
      (lambda ()
        (setq indent-tabs-mode t)
        (setq tab-width 4)
        (setq haskell-indent-offset 4)))
;; (use-package lsp-haskell
;;   :ensure t
;;   :hook (haskell-mode . lsp-haskell)
;;   		(haskell-literate-mode . lsp-haskell))
;; (use-package lsp-haskell
;;   :ensure t
;;   :config
;;   (setq lsp-haskell-process-path-hie "ghcide")
;;   (setq lsp-haskell-process-args-hie '())
(use-package lsp-haskell
  :hook
  (haskell-mode . lsp)
  (haskell-literate-mode . lsp))

(setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/.ghcup/bin")))
(setq exec-path (append exec-path '(expand-file-name "~/.ghcup/bin")))

(use-package flymake-haskell-multi)
(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)
;; (setenv "PATH" (concat (getenv "PATH") ":/home/schlypar/.local/bin"))
;; (setq lsp-haskell-process-args-hie (list "-d" "-l" (make-temp-file "hie." nil ".log")))
(setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")

(use-package dap-mode
  :defer
  :custom
  (dap-auto-configure-mode t                           "Automatically configure dap.")
  (dap-auto-configure-features
   '(sessions locals breakpoints expressions tooltip)  "Remove the button panel in the top.")
  :config
  ;;; dap for c++
  (require 'dap-lldb)

  ;;; set the debugger executable (c++)
  (setq dap-lldb-debug-program '("/usr/bin/lldb-vscode"))

  ;;; ask user for executable to debug if not specified explicitly (c++)
  (setq dap-lldb-debugged-program-function (lambda () (read-file-name "Select file to debug.")))

  ;;; default debug template for (c++)
  (dap-register-debug-template
   "C++ LLDB dap"
   (list :type "lldb-vscode"
         :cwd nil
         :args nil
         :request "launch"
         :program nil))
  
  (defun dap-debug-create-or-edit-json-template ()
    "Edit the C++ debugging configuration or create + edit if none exists yet."
    (interactive)
    (let ((filename (concat (lsp-workspace-root) "/launch.json"))
	  (default "~/.emacs.d/default-launch.json"))
      (unless (file-exists-p filename)
	(copy-file default filename))
      (find-file-existing filename))))

;; (require 'dap-lldb) ;; to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))

(use-package lsp-mode
    :hook (prog-mode . lsp-deferred)
    :commands (lsp lsp-deferred))


(use-package lsp-ui
             ;; :hook (lsp-mode . lsp-ui-mode)
             :custom
             (lsp-ui-doc-position 'top))

(setq lsp-ui-sideline-show-diagnostics 1)
(setq lsp-ui-sideline-show-hover nil)
(setq lsp-ui-sideline-show-code-actions 1)

;; (lsp-ui-peek-enable 1)

(use-package highlight-doxygen
    :hook (prog-mode . highlight-doxygen-mode))

(use-package yasnippet
    :hook (prog-mode . yas-minor-mode-on))

(yas-minor-mode-on)

(require 'tree-sitter)
(require 'tree-sitter-langs)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(require 'rtags) ;; optional, must have rtags installed
(setq cmake-ide-build-dir "build")

(setq cmake-ide-flags-c++ "-g")
(setq cmake-ide-cmake-opts "-DCMAKE_BUILD_TYPE=Debug")

(cmake-ide-setup)

(use-package clang-format
  :ensure t)

(setq clang-format-style-option "file")

;; Python IDE like
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(setq elpy-formatter "black")
(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))

(use-package dired
  :ensure nil
  :hook (dired-mode . flycheck-mode)
  :commands (dired dired-jump)
  ;; :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    (kbd "<left>") 'dired-single-up-directory
    (kbd "<right>") 'dired-single-buffer
    "l" 'dired-single-buffer))

(use-package dired-single)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

(use-package term
  :config
  (setq explicit-shell-file-name "zsh") ;; Change this to zsh, etc
  (setq explicit-zsh-args '()))         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  ;; (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  ;; (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  (setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Desktop/repos/")
    (setq projectile-project-search-path '("~/Desktop/repos/")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package dashboard
  :ensure t
  :init
  (progn
	(setq dashboard-items '((recents . 1)
						   (projects . 1)))

	(setq dashboard-banner-logo-title "VIM + EMACS = GOD POWER")
	(setq dashboard-footer-messages '("OOP of Functional? What do you chose?"))
	(setq dashboard-set-file-icons t)
	(setq dashboard-set-heading-icons t)
	(setq dashboard-startup-banner 'logo)
	)

  :config
  (dashboard-setup-startup-hook))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

