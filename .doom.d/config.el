(setq user-full-name "Lucas Kerbs"
      user-mail-address "lucaskerbs@gmail.com")
(setq default-directory "~/Dropbox/Graduate School/")

(setq doom-font (font-spec :family "JetBrains Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 14)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-theme 'doom-monokai-pro)
;;(setq doom-theme 'doom-horizon)
(require 'ewal-doom-themes)

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(setq display-line-numbers-type 'relative)

(add-hook 'text-mode-hook  'auto-fill-mode)
(setq-default fill-column 80)

(set-frame-parameter (selected-frame) 'alpha '(90 . 75))
(add-to-list 'default-frame-alist '(alpha . (90 . 75)))

(use-package all-the-icons
  :if (display-graphic-p))
;;(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(setq evil-tex-toggle-override-m nil)

(with-eval-after-load 'evil-tex
  (evil-define-key 'normal evil-tex-mode-map [remap evil-set-marker]
    (evil-tex-dispatch-single-key ?t #'evil-tex-read-and-execute-toggle
                                  'evil-tex-m-functions)))

(require 'evil-colemak-basics)
(use-package evil-colemak-basics
  :config
  (global-evil-colemak-basics-mode)
  )
  (define-key evil-window-map "n" 'evil-window-down)
  (define-key evil-window-map "N" 'evil-window-move-very-bottom)
  (define-key evil-window-map (kbd "C-S-n") 'evil-window-move-very-bottom)
  (define-key evil-window-map "e" 'evil-window-up)
  (define-key evil-window-map "E" 'evil-window-move-very-top)
  (define-key evil-window-map (kbd "C-S-e") 'evil-window-move-very-top)
  (define-key evil-window-map "m" 'evil-window-left)
  (define-key evil-window-map "M" 'evil-window-move-far-left)
  (define-key evil-window-map (kbd "C-S-m") 'evil-window-move-far-left)
  (define-key evil-window-map "i" 'evil-window-right)
  (define-key evil-window-map "I" 'evil-window-move-far-right)
  (define-key evil-window-map (kbd "C-S-i") 'evil-window-move-far-right)
  ;; Kreate new window
  (define-key evil-window-map "k" 'evil-window-new)
  (define-key evil-window-map "\C-k" 'evil-window-new)

(setq org-directory "~/Dropbox/Slipbox/")
(setq org-roam-directory "~/Dropbox/Slipbox/")

(setq org-roam-db-update-method 'immediate)
(setq org-roam-capture-templates '(("d" "default" plain "%?"
    :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                               "#+title: ${title}\n")
                                :unnarrowed t)))

(add-to-list 'display-buffer-alist
    '("\\*org-roam\\*"
        (display-buffer-in-side-window)
        (side . right)
        (slot . 0)
        (window-width . 0.25)
        (preserve-size . (t . nil))
        (window-parameters . ((no-other-window . t)
                              (no-delete-other-windows . t)))))
;; (setq org-roam-buffer nil)

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
 (setq org-highlight-latex-and-related '(latex script entities))

(defun my-org-latex-yas ()
  (yas-minor-mode)
  (yas-activate-extra-mode 'latex-mode))
(add-hook 'org-mode-hook #'my-org-latex-yas)

(add-hook 'org-mode-hook 'org-fragtog-mode)

(require 'latex)
(add-hook 'latex-mode-hook #'TeX-latex-mode)

(setq TeX-electric-sub-and-superscript nil)

(setq bibtex-completion-bibliography '("~/Dropbox/Biblio/main.bib"))

(setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation)

(defun my-yas-try-expanding-auto-snippets ()
    (when (and (boundp 'yas-minor-mode) yas-minor-mode)
      (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
        (yas-expand))))
  (add-hook 'post-command-hook #'my-yas-try-expanding-auto-snippets)

(use-package! laas
  :hook (LaTeX-mode . laas-mode)
  ;; if you want it in org-mode too
  :hook (org-mode . laas-mode)
  :config
  (aas-set-snippets 'laas-mode
                    ;; set condition!
                    :cond #'texmathp ; expand only while in math
                    ;;"supp" "\\supp"
                    ;; bind to functions!
                    ;;        (yas-expand-snippet "\\frac{$1}{$2}$0"))
                    "Span" (lambda () (interactive)
                             (yas-expand-snippet "\\Span($1)$0"))))

(map! :map cdlatex-mode-map
    :i "TAB" #'cdlatex-tab)

(setq cdlatex-math-symbol-alist
 '(
   ( ?c  ("\\chi"                 "\\circ"                "\\cos"))
   ( ?e  ("\\varepsilon"          "\\epsilon"             "\\exp"))
   ( ?+  ("\\cup"                 "\\oplus"               ""))
   ( ?x  ("\\xi"                  "\\otimes"              ""))
    ))

(after! latex
  (setcar (assoc "⋆" LaTeX-fold-math-spec-list) "★")) ;; make \star bigger
(setq TeX-fold-math-spec-list
      `(;; missing/better symbols
        ("≤" ("le"))
        ("≥" ("ge"))
        ("≠" ("ne"))
        ;; convenience shorts -- these don't work nicely ATM
        ;; ("‹" ("left"))
        ;; ("›" ("right"))
        ;; private macros
        ("ℝ" ("RR"))
        ("ℕ" ("NN"))
        ("ℤ" ("ZZ"))
        ("ℚ" ("QQ"))
        ("ℂ" ("CC"))
        ("ℙ" ("PP"))
        ("ℍ" ("HH"))
        ("𝔼" ("EE"))
        ("𝑑" ("dd"))
        ;; known commands
        ("" ("phantom"))
        (,(lambda (num den) (if (and (TeX-string-single-token-p num) (TeX-string-single-token-p den))
                                (concat num "／" den)
                              (concat "❪" num "／" den "❫"))) ("frac"))
        (,(lambda (arg) (concat "√" (TeX-fold-parenthesize-as-necessary arg))) ("sqrt"))
        (,(lambda (arg) (concat "⭡" (TeX-fold-parenthesize-as-necessary arg))) ("vec"))
        ("‘{1}’" ("text"))
        ;; private commands
        ("|{1}|" ("abs"))
        ("‖{1}‖" ("norm"))
        ("⌊{1}⌋" ("floor"))
        ("⌈{1}⌉" ("ceil"))
        ("⌊{1}⌉" ("round"))
        ("𝑑{1}/𝑑{2}" ("dv"))
        ("∂{1}/∂{2}" ("pdv"))
        ;; fancification
        ("{1}" ("mathrm"))
        (,(lambda (word) (string-offset-roman-chars 119743 word)) ("mathbf"))
        (,(lambda (word) (string-offset-roman-chars 119951 word)) ("mathcal"))
        (,(lambda (word) (string-offset-roman-chars 120003 word)) ("mathfrak"))
        (,(lambda (word) (string-offset-roman-chars 120055 word)) ("mathbb"))
        (,(lambda (word) (string-offset-roman-chars 120159 word)) ("mathsf"))
        (,(lambda (word) (string-offset-roman-chars 120367 word)) ("mathtt"))
        )
      TeX-fold-macro-spec-list
      '(
        ;; as the defaults
        ("[f]" ("footnote" "marginpar"))
        ("[c]" ("cite"))
        ("[l]" ("label"))
        ("[r]" ("ref" "pageref" "eqref"))
        ("[i]" ("index" "glossary"))
        ("..." ("dots"))
        ("{1}" ("emph" "textit" "textsl" "textmd" "textrm" "textsf" "texttt"
                "textbf" "textsc" "textup"))
        ;; tweaked defaults
        ("©" ("copyright"))
        ("®" ("textregistered"))
        ("™"  ("texttrademark"))
        ("[1]:||►" ("item"))
        ("❡❡ {1}" ("part" "part*"))
        ("❡ {1}" ("chapter" "chapter*"))
        ("§ {1}" ("section" "section*"))
        ("§§ {1}" ("subsection" "subsection*"))
        ("§§§ {1}" ("subsubsection" "subsubsection*"))
        ("¶ {1}" ("paragraph" "paragraph*"))
        ("¶¶ {1}" ("subparagraph" "subparagraph*"))
        ;; extra
        ("⬖ {1}" ("begin"))
        ("⬗ {1}" ("end"))
        ))

(defun string-offset-roman-chars (offset word)
  "Shift the codepoint of each character in WORD by OFFSET with an extra -6 shift if the letter is lowercase"
  (apply 'string
         (mapcar (lambda (c)
                   (string-offset-apply-roman-char-exceptions
                    (+ (if (>= c 97) (- c 6) c) offset)))
                 word)))

(defvar string-offset-roman-char-exceptions
  '(;; lowercase serif
    (119892 .  8462) ; ℎ
    ;; lowercase caligraphic
    (119994 . 8495) ; ℯ
    (119996 . 8458) ; ℊ
    (120004 . 8500) ; ℴ
    ;; caligraphic
    (119965 . 8492) ; ℬ
    (119968 . 8496) ; ℰ
    (119969 . 8497) ; ℱ
    (119971 . 8459) ; ℋ
    (119972 . 8464) ; ℐ
    (119975 . 8466) ; ℒ
    (119976 . 8499) ; ℳ
    (119981 . 8475) ; ℛ
    ;; fraktur
    (120070 . 8493) ; ℭ
    (120075 . 8460) ; ℌ
    (120076 . 8465) ; ℑ
    (120085 . 8476) ; ℜ
    (120092 . 8488) ; ℨ
    ;; blackboard
    (120122 . 8450) ; ℂ
    (120127 . 8461) ; ℍ
    (120133 . 8469) ; ℕ
    (120135 . 8473) ; ℙ
    (120136 . 8474) ; ℚ
    (120137 . 8477) ; ℝ
    (120145 . 8484) ; ℤ
    )
  "An alist of deceptive codepoints, and then where the glyph actually resides.")

(defun string-offset-apply-roman-char-exceptions (char)
  "Sometimes the codepoint doesn't contain the char you expect.
Such special cases should be remapped to another value, as given in `string-offset-roman-char-exceptions'."
  (if (assoc char string-offset-roman-char-exceptions)
      (cdr (assoc char string-offset-roman-char-exceptions))
    char))

(defun TeX-fold-parenthesize-as-necessary (tokens &optional suppress-left suppress-right)
  "Add ❪ ❫ parenthesis as if multiple LaTeX tokens appear to be present"
  (if (TeX-string-single-token-p tokens) tokens
    (concat (if suppress-left "" "❪")
            tokens
            (if suppress-right "" "❫"))))

(defun TeX-string-single-token-p (teststring)
  "Return t if TESTSTRING appears to be a single token, nil otherwise"
  (if (string-match-p "^\\\\?\\w+$" teststring) t nil))

(setq fancy-splash-image "~/.doom.d/cute-doom/doom_512.png")

(use-package dashboard
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-banner-logo-title "\nKEYBINDINGS:\
\nFind file               (SPC .)     \
Open buffer list    (SPC b i)\
\nFind recent files       (SPC f r)   \
Open the eshell     (SPC e s)\
\nOpen dired file manager (SPC d d)   \
List of keybindings (SPC h b b)")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.doom.d/cute-doom/doom_512.png")
  (setq dashboard-banner-logo-title "Journey Before Destination!")
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 3)
                          (registers . 5)))
   :config
   (dashboard-setup-startup-hook)
   (dashboard-modify-heading-icons '((recents . "file-text")
                                     (bookmarks . "book"))))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq doom-fallback-buffer "*dashboard*")

(use-package ibuffer-sidebar
  :load-path "~/.emacs.d/fork/ibuffer-sidebar"
  :commands (ibuffer-sidebar-toggle-sidebar)
  :config
  (setq ibuffer-sidebar-use-custom-font t)
  (setq ibuffer-sidebar-face `(:family "Helvetica" :height 140)))
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))
(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))

(use-package evil-goggles
  :init
  (setq evil-goggles-duration 0.1
        evil-goggles-pulse nil ; too slow
        ;; evil-goggles provides a good indicator of what has been affected.
        ;; delete/change is obvious, so I'd rather disable it for these.
        evil-goggles-enable-delete t
        evil-goggles-enable-change t)
  :config
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

(after! company
  (setq company-idle-delay 1.5
       company-minimum-prefix-length 5))

(setq ispell-program-name "/usr/local/bin/ispell")

(map! :leader
      :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines))

(map! :leader
      (:prefix ("=" . "open file")
       :desc "Edit agenda file" "a" #'(lambda () (interactive) (find-file "~/Org/agenda.org"))
       :desc "Edit doom config.org" "c" #'(lambda () (interactive) (find-file "~/.doom.d/config.org"))
       :desc "Edit doom init.el" "i" #'(lambda () (interactive) (find-file "~/.doom.d/init.el"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.doom.d/packages.el"))))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(global-rainbow-mode 1 )

(after! evil-snipe
  (setq evil-snipe-scope 'visible
        evil-snipe-spillover-scope 'whole-visible))

(setq projectile-project-search-path '("~/Dropbox/Graduate School/"
                                       "~/Dropbox/PhD Applications/"
                                       "~/Projects/"))
