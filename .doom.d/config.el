(setq user-full-name "Lucas Kerbs"
      user-mail-address "lucaskerbs@gmail.com")
(setq default-directory "~/Library/CloudStorage/Dropbox/math")

(setq undo-limit 100000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      scroll-margin 3
      evil-move-cursor-back nil)                            ; It's nice to maintain a little margin

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(setq doom-font (font-spec :family "JuliaMono" :size 15)
      doom-big-font (font-spec :family "JuliaMono" :size 24)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-unicode-font (font-spec :family "JuliaMono")
      doom-serif-font (font-spec :family "IBM Plex Mono" :size 22 :weight 'light))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-theme 'doom-monokai-classic)
;;(setq doom-theme 'doom-horizon)
(require 'ewal-doom-themes)

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                                 '(coding-category-undecided coding-category-utf-8))
                           (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
                t)))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(setq display-line-numbers-type 'relative)

(add-hook 'text-mode-hook  'auto-fill-mode)
(setq-default fill-column 80)

(set-frame-parameter (selected-frame) 'alpha '(80 . 65))
(add-to-list 'default-frame-alist '(alpha . (80 . 65)))

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
  ;; Maximie window with SPC-w-J (this makes sense with my yabai/skhd config)
  (define-key evil-window-map "J" 'doom/window-maximize-buffer)

(after! org
  (setq org-ellipsis " ▼ "
        org-log-repeat t
        org-log-done t
        org-log-into-drawer "LOGBOOK"
        org-hide-emphasis-markers t
        org-directory "~/Dropbox/Slipbox/"
        org-roam-directory "~/Dropbox/Slipbox/"))

(sp-local-pair
 '(org-mode)
 "<<" ">>"
 :actions '(insert))

(add-to-list 'org-modules 'org-checklist)
(require 'org-checklist)

(after! org
(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements)))

(after! org
    (setq org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
          ;("kmtrigger" . "")
         ( "wiki" . "https://en.wikipedia.org/wiki/")))
    (org-link-set-parameters "kmtrigger"  :follow (lambda (test) (browse-url (concat "kmtrigger://" test))))
)

(after! org
   (setq
       org-capture-todo-file "/gtd/inbox.org"
       org-archive-location  "~/Dropbox/Slipbox/gtd/archive.org::* From %s"

        org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "WAIT(w)" "|" "DONE(d)" "KILL(k)")
                            (sequence "BLOG(b)" "DRFT(d)" "|" "PBSH(p)"))
        org-agenda-files (list "~/Dropbox/Slipbox/"
                               "~/Dropbox/Slipbox/gtd/"
                               "~/Dropbox/Slipbox/course work/"))


  (setq org-refile-targets '(("~/Dropbox/Slipbox/gtd/todo.org" :maxlevel . 3)
                             ("~/Dropbox/Slipbox/gtd/tickler.org" :maxlevel . 3)
                             ("~/Dropbox/Slipbox/gtd/birthday_and_similar.org" :maxlevel . 1)
                             ("~/Dropbox/Slipbox/course work/" :maxlevel . 1 ))
        org-refile-allow-creating-parent-nodes t)
)

(after! org

(setq org-default-properties (cons "RESET_SUBTASKS" org-default-properties))

(defun org-reset-subtask-state-subtree ()
  "Reset all subtasks in an entry subtree."
  (interactive "*")
  (if (org-before-first-heading-p)
      (error "Not inside a tree")
    (save-excursion
      (save-restriction
	(org-narrow-to-subtree)
	(org-show-subtree)
	(goto-char (point-min))
        (beginning-of-line 2)
        (narrow-to-region (point) (point-max))
        (org-map-entries
         '(when (member (org-get-todo-state) org-done-keywords)
            (org-todo (car org-todo-keywords))))
        ))))

(defun org-reset-subtask-state-maybe ()
  "Reset all subtasks in an entry if the `RESET_SUBTASKS' property is set"
  (interactive "*")
  (if (org-entry-get (point) "RESET_SUBTASKS")
      (org-reset-subtask-state-subtree)))

(defun org-subtask-reset ()
  (when (member org-state org-done-keywords) ;; org-state dynamically bound in org.el/org-todo
    (org-reset-subtask-state-maybe)
    (org-update-statistics-cookies t)))

(add-hook 'org-after-todo-state-change-hook 'org-subtask-reset)
)

(after! org
(defun dt/org-colors-doom-one ()
  "Enable Doom One colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#51afef" ultra-bold)
         (org-level-2 1.1 "#c678dd" extra-bold)
         (org-level-3 1.1 "#98be65" bold)
         (org-level-4 1.1 "#da8548" semi-bold)
         (org-level-5 1.1 "#5699af" normal)
         (org-level-6 1.1 "#a9a1e1" normal)
         (org-level-7 1.1 "#46d9ff" normal)
         (org-level-8 1.1 "#ff6c6b" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-dracula ()
  "Enable Dracula colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#8be9fd" ultra-bold)
         (org-level-2 1.1 "#bd93f9" extra-bold)
         (org-level-3 1.1 "#50fa7b" bold)
         (org-level-4 1.1 "#ff79c6" semi-bold)
         (org-level-5 1.1 "#9aedfe" normal)
         (org-level-6 1.1 "#caa9fa" normal)
         (org-level-7 1.1 "#5af78e" normal)
         (org-level-8 1.1 "#ff92d0" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-gruvbox-dark ()
  "Enable Gruvbox Dark colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#458588" ultra-bold)
         (org-level-2 1.1 "#b16286" extra-bold)
         (org-level-3 1.1 "#98971a" bold)
         (org-level-4 1.1 "#fb4934" semi-bold)
         (org-level-5 1.1 "#83a598" normal)
         (org-level-6 1.1 "#d3869b" normal)
         (org-level-7 1.1 "#d79921" normal)
         (org-level-8 1.1 "#8ec07c" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-monokai-pro ()
  "Enable Monokai Pro colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#78dce8" ultra-bold)
         (org-level-2 1.1 "#ab9df2" extra-bold)
         (org-level-3 1.1 "#a9dc76" bold)
         (org-level-4 1.1 "#fc9867" semi-bold)
         (org-level-5 1.1 "#ff6188" normal)
         (org-level-6 1.1 "#ffd866" normal)
         (org-level-7 1.1 "#78dce8" normal)
         (org-level-8 1.1 "#ab9df2" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-nord ()
  "Enable Nord colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#81a1c1" ultra-bold)
         (org-level-2 1.1 "#b48ead" extra-bold)
         (org-level-3 1.1 "#a3be8c" bold)
         (org-level-4 1.1 "#ebcb8b" semi-bold)
         (org-level-5 1.1 "#bf616a" normal)
         (org-level-6 1.1 "#88c0d0" normal)
         (org-level-7 1.1 "#81a1c1" normal)
         (org-level-8 1.1 "#b48ead" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-oceanic-next ()
  "Enable Oceanic Next colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#6699cc" ultra-bold)
         (org-level-2 1.1 "#c594c5" extra-bold)
         (org-level-3 1.1 "#99c794" bold)
         (org-level-4 1.1 "#fac863" semi-bold)
         (org-level-5 1.1 "#5fb3b3" normal)
         (org-level-6 1.1 "#ec5f67" normal)
         (org-level-7 1.1 "#6699cc" normal)
         (org-level-8 1.1 "#c594c5" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-palenight ()
  "Enable Palenight colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#82aaff" ultra-bold)
         (org-level-2 1.1 "#c792ea" extra-bold)
         (org-level-3 1.1 "#c3e88d" bold)
         (org-level-4 1.1 "#ffcb6b" semi-bold)
         (org-level-5 1.1 "#a3f7ff" normal)
         (org-level-6 1.1 "#e1acff" normal)
         (org-level-7 1.1 "#f07178" normal)
         (org-level-8 1.1 "#ddffa7" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-solarized-dark ()
  "Enable Solarized Dark colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#268bd2" ultra-bold)
         (org-level-2 1.1 "#d33682" extra-bold)
         (org-level-3 1.1 "#859900" bold)
         (org-level-4 1.1 "#b58900" semi-bold)
         (org-level-5 1.1 "#cb4b16" normal)
         (org-level-6 1.1 "#6c71c4" normal)
         (org-level-7 1.1 "#2aa198" normal)
         (org-level-8 1.1 "#657b83" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-solarized-light ()
  "Enable Solarized Light colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#268bd2" ultra-bold)
         (org-level-2 1.1 "#d33682" extra-bold)
         (org-level-3 1.1 "#859900" bold)
         (org-level-4 1.1 "#b58900" semi-bold)
         (org-level-5 1.1 "#cb4b16" normal)
         (org-level-6 1.1 "#6c71c4" normal)
         (org-level-7 1.1 "#2aa198" normal)
         (org-level-8 1.1 "#657b83" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-tomorrow-night ()
  "Enable Tomorrow Night colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.1 "#81a2be" ultra-bold)
         (org-level-2 1.1 "#b294bb" extra-bold)
         (org-level-3 1.1 "#b5bd68" bold)
         (org-level-4 1.1 "#e6c547" semi-bold)
         (org-level-5 1.1 "#cc6666" normal)
         (org-level-6 1.1 "#70c0ba" normal)
         (org-level-7 1.1 "#b77ee0" normal)
         (org-level-8 1.1 "#9ec400" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

;; Load our desired dt/org-colors-* theme on startup
(dt/org-colors-monokai-pro))

(after! org
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤")
                          (45 . "–")
                          (42 . "•"))
        org-modern-todo-faces
        '(("TODO" :inverse-video t :inherit org-todo)
          ("PROJ" :inverse-video t :inherit +org-todo-project)
          ("STRT" :inverse-video t :inherit +org-todo-active)
          ("[-]"  :inverse-video t :inherit +org-todo-active)
          ("HOLD" :inverse-video t :inherit +org-todo-onhold)
          ("WAIT" :inverse-video t :inherit +org-todo-onhold)
          ("[?]"  :inverse-video t :inherit +org-todo-onhold)
          ("KILL" :inverse-video t :inherit +org-todo-cancel)
          ("NO"   :inverse-video t :inherit +org-todo-cancel))
        org-modern-footnote
        (cons nil (cadr org-script-display))
        org-modern-block-fringe nil
        org-modern-block-name
        '((t . t)
          ("src" "»" "«")
          ("example" "»–" "–«")
          ("quote" "❝" "❞")
          ("export" "⏩" "⏪"))
        org-modern-progress nil
        org-modern-priority t
        org-modern-horizontal-rule (make-string 36 ?─)
        org-modern-keyword
        '((t . t)
          ("title" . "𝙏")
          ("subtitle" . "𝙩")
          ("author" . "𝘼")
          ("email" . #("" 0 1 (display (raise -0.14))))
          ("date" . "𝘿")
          ("property" . "☸")
          ("options" . "⌥")
          ("startup" . "⏻")
          ("macro" . "𝓜")
          ("bind" . #("" 0 1 (display (raise -0.1))))
          ("bibliography" . "")
          ("print_bibliography" . #("" 0 1 (display (raise -0.1))))
          ("cite_export" . "⮭")
          ("print_glossary" . #("ᴬᶻ" 0 1 (display (raise -0.1))))
          ("glossary_sources" . #("" 0 1 (display (raise -0.14))))
          ("include" . "⇤")
          ("setupfile" . "⇚")
          ("html_head" . "🅷")
          ("html" . "🅗")
          ("latex_class" . "🄻")
          ("latex_class_options" . #("🄻" 1 2 (display (raise -0.14))))
          ("latex_header" . "🅻")
          ("latex_header_extra" . "🅻⁺")
          ("latex" . "🅛")
          ("beamer_theme" . "🄱")
          ("beamer_color_theme" . #("🄱" 1 2 (display (raise -0.12))))
          ("beamer_font_theme" . "🄱𝐀")
          ("beamer_header" . "🅱")
          ("beamer" . "🅑")
          ("attr_latex" . "🄛")
          ("attr_html" . "🄗")
          ("attr_org" . "⒪")
          ("call" . #("" 0 1 (display (raise -0.15))))
          ("name" . "⁍")
          ("header" . "›")
          ("caption" . "☰")
          ("RESULTS" . "🠶")))
  (custom-set-faces! '(org-modern-statistics :inherit org-checkbox-statistics-todo))))

(after! org
(setq org-journal-dir "~/Dropbox/Slipbox/journal/"))

;;(use-package! org-super-agenda
  ;;:after org-agenda
  ;;:init
  ;;(setq org-super-agenda-groups
        ;;'((:name "Today"
                                  ;;:time-grid t
                                  ;;:scheduled today)
                           ;;(:name "Due today"
                                  ;;:deadline today)
                           ;;(:name "Important"
                                  ;;:priority "A")
                           ;;(:name "Overdue"
                                  ;;:deadline past)
                           ;;(:name "Due soon"
                                  ;;:deadline future)
                           ;;(:name "Big Outcomes"
                                  ;;:tag "bo"))
  ;;:config
  ;;(org-super-agenda-mode))

(after! org
(setq org-roam-db-update-method 'immediate)
(setq org-roam-capture-templates
      '(("s" "slipbox" plain "%?"
          :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                               "#+title: ${title}\n#+STARTUP: latexpreview\n")
                                :unnarrowed t
                                :jump-to-captured t))
      ))

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

(setq org-preview-latex-default-process 'imagemagick)

(after! org
  (add-to-list 'org-latex-packages-alist '("" "/Users/lucaskerbs/Library/CloudStorage/Dropbox/math/Automation/style/lucastex" t))
)

(use-package! org-auto-tangle
  :defer t
        :hook (org-mode . org-auto-tangle-mode))

(use-package! org-chef
  :commands (org-chef-insert-recipe org-chef-get-recipe-from-url))

(require 'cl-lib)
(require 'org-element)

(defun org-element-parse-headline (&optional granularity visible-only)
  "Parse current headline.
GRANULARITY and VISIBLE-ONLY are like the args of `org-element-parse-buffer'."
  (let ((level (org-current-level)))
    (org-element-map
    (org-element-parse-buffer granularity visible-only)
    'headline
      (lambda (el)
    (and
     (eq (org-element-property :level el) level)
     (<= (org-element-property :begin el) (point))
     (<= (point) (org-element-property :end el))
     el))
      nil 'first-match 'no-recursion)))

(cl-defun org+-count-words-of-heading (&key (worthy '(paragraph bold italic underline code footnote-reference link strike-through subscript superscript table table-row table-cell))
                        (no-recursion nil))
  "Count words in the section of the current heading.
WORTHY is a list of things worthy to be counted.
This list should at least include the symbols:
paragraph, bold, italic, underline and strike-through.

If NO-RECURSION is non-nil don't count the words in subsections."
  (interactive (and current-prefix-arg
            (list :no-recursion t)))
  (let ((word-count 0))
    (org-element-map
    (org-element-contents (org-element-parse-headline))
    '(paragraph table)
      (lambda (par)
    (org-element-map
        par
        worthy
        (lambda (el)
          (cl-incf
           word-count
           (cl-loop
        for txt in (org-element-contents el)
        when (eq (org-element-type txt) 'plain-text)
        sum
        (with-temp-buffer
          (insert txt)
          (count-words (point-min) (point-max))))
           ))))
      nil nil (and no-recursion 'headline)
      )
      (when (called-interactively-p 'any)
      (message "Word count in section: %d" word-count))
    word-count))

(require 'latex)
(add-hook 'latex-mode-hook #'TeX-latex-mode)

(setq TeX-electric-sub-and-superscript t)

(after! tex
  (map!
   :map LaTeX-mode-map
   :ei [C-return] #'LaTeX-insert-item)
  (setq TeX-electric-math '("\\(" . "")))

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
   ( ?c  ("\\chi"           "\\circ"          "\\cos"))
   ( ?_  ("\\downarrow"     ""                "\\inf"))
   ( ?2  ("^2"              "\\sqrt{?}"       ""     ))
   ( ?3  ("^3"              "\\sqrt[3]{?}"    ""     ))
   ( ?e  ("\\varepsilon"    "\\epsilon"       "\\exp"))
   ( ?+  ("\\cup"           "\\oplus"         ""     ))
   ( ?x  ("\\xi"            "\\otimes"        ""     ))
   ( ?U  ("\\Upsilon"       "\\cup"           "\\bigcup"     ))
   ( ?N  ("\\nabla"         "\\cap"           "\\bigcap")))
 cdlatex-math-modify-alist
 '( ;; my own stuff
     (?B    "\\mathbb"        nil          t    nil  nil)
     (?a    "\\abs"           nil          t    nil  nil)
     (?S    "\\mathscr"       nil          t    nil  nil)
     (?s    "\\sqrt"          nil          t    nil  nil)
     (?n    "\\norm"          nil          t    nil  nil)
     (?F    "\\mathfrak"      nil          t    nil  nil)
     ))

(setq cdlatex-make-sub-superscript-roman-if-pressed-twice t)

;; Making \( \) less visible
(defface unimportant-latex-face
  '((t :inherit font-lock-comment-face :weight extra-light))
  "Face used to make \\(\\), \\[\\] less visible."
  :group 'LaTeX-math)

(font-lock-add-keywords
 'latex-mode
 `(("\\\\[]()[]" 0 'unimportant-latex-face prepend))
 'end)

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
        ("ℂ" ("CC"))
        ("𝔼" ("EE"))
        ("ℍ" ("HH"))
        ("ℝ" ("RR"))
        ("𝕊" ("SS"))
        ("𝕋" ("TT"))
        ("ℕ" ("NN"))
        ("ℙ" ("PP"))
        ("ℚ" ("QQ"))
        ("ℤ" ("ZZ"))
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

;(setq TeX-view-program-list
 ;'("sioyek"
   ;("/Applications/sioyek.app/Contents/MacOS/sioyek %o"
    ;(mode-io-correlate
     ;,(concat
       ;" --forward-search-file \"%b\""
       ;" --forward-search-line %n"
       ;" --inverse-search \"emacsclient +%2 %1\"")))
   ;"sioyek"))
;(add-to-list 'TeX-view-program-selection
             ;'(output-pdf "sioyek"))

(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-source-correlate-method 'synctex)

(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pvc -synctex=1 -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

(add-hook 'pdf-view-mode-hook #'pdf-view-themed-minor-mode)

(defun replace-quiver-diagram ()
  "Extracts the quiver URL from the diagram under cursor and runs it in browser. Selects the diagram."
  (interactive)
        (let ((start 0)
              (end 0)
              (url-start 0)
              (url-end 0)
              (url ""))
    (save-excursion
      (save-excursion
        (re-search-backward "% https://q.uiver.app" nil)
        (setq url-start (+ 2 (point)))
        (beginning-of-line)
        (setq start (point))
      (save-excursion
	    (re-search-forward "\\\\end{tikzcd}" nil)
        (setq end (point)))
      (save-excursion
        (goto-char url-start)
        (re-search-forward "\n" nil)
        (setq url-end (- (point) 1))
        (skip-chars-forward " ")
        ;; If the next two symbols after new line, up to whitespace,
        ;; are "\[", modify the `end` value to be after \].
        (when (string= "[" (string (char-after (+ 1 (point)))))
          (setq end (+ 2 end))))
      (setq url (buffer-substring-no-properties url-start url-end))
      (start-process "" nil
                     ;; Edit this line to change the browser.
                     "flatpak" "run" "org.chromium.Chromium" url)))
    (goto-char start)
    (push-mark end t t)))

(add-hook 'TeX-mode-hook (lambda ()
                           (interactive)
                           (define-key TeX-mode-map (kbd "C-x q") 'replace-quiver-diagram)))

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
(setq doom-fallback-buffer-master "*dashboard*")

(defun new-workspace ()
  "Open a new workspace and open the dashboard at the same time"
  (interactive)
  (+workspace/new)
  (dashboard-refresh-buffer))

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
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.doom.d/packages.el"))
       :desc "Edit yabai config" "y" #'(lambda () (interactive) (find-file "~/.config/yabai/README.org"))
       :desc "Open todo.org" "t" #'(lambda () (interactive) (find-file "~/Dropbox/Slipbox/gtd/todo.org"))
       :desc "Open inbox.org" "n" #'(lambda () (interactive) (find-file "~/Dropbox/Slipbox/gtd/inbox.org"))
       :desc "Open review.org" "r" #'(lambda () (interactive) (find-file "~/Dropbox/Slipbox/gtd/review.org"))))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(global-rainbow-mode 1 )

(after! evil-snipe
  (setq evil-snipe-scope 'visible
        evil-snipe-spillover-scope 'whole-visible))

;(require 'elcord)
;(elcord-mode)
;(setq elcord-use-major-mode-as-icon t)

(setq projectile-project-search-path '("~/Dropbox/math/"
                                       "~/Dropbox/PhD Applications/"
                                       "~/Projects/"))

(add-to-list 'warning-suppress-types '(defvaralias))
