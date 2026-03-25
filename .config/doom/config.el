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
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 20 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "ETbb" :size 28))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-lantern)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(setq org-agenda-files '("~/org/"))
(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-dir "~/notes/org/daily/")
(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %d-%m-%Y")


;; Hard stop
(setq fill-column 80)
(add-hook 'org-mode-hook #'auto-fill-mode)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
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


;; Keybindings
;; F2 split problem
(global-unset-key (kbd "<f2>"))


;; Epubs
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(setq nov-text-width 80)
(add-hook 'nov-mode-hook 'visual-line-mode)
(setq org-tag-alist
      '(
        ;;Places
        ("@home" . ?H)
        ("@university" . ?U)

        ;;Devices
        ("@computer" . ?C)
        ("@phone" . ?P)

        ;;Activities
        ("@planning" . ?n)
        ("@programming" . ?p)
        ("@writing" . ?w)
        ("@creative" . ?c)
        ("@email" . ?e)
        ("@messages" . ?m)
        ("@errants" . ?e)
        ))

;; Split vertically;
;; Source - https://stackoverflow.com/questions/2081577/setting-emacs-to-split-buffers-side-by-side

(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; toogle window-split
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(map! :leader
      :desc "Flip window layout"
      "w T" #'toggle-window-split)

;; Typescript
(after! typescript-mode
  (setq-hook! 'typescript-mode-hook
    tab-width 2
    typescript-indent-level 2))

(setq lsp-clients-typescript-prefer-use-project-ts-server t)

(after! typescript-ts-mode
  (setq-hook! 'typescript-ts-mode-hook
    tab-width 2
    typescript-ts-mode-indent-offset 2))





;; ORG FILES ________________________________________-
;;

;;; org-config.el — Comprehensive Org-Mode setup for Doom Emacs
;;
;; Paste this entire block into ~/.doom.d/config.el
;; Ensure your init.el has: (org +pretty) in the :lang section

;;; ─────────────────────────────────────────────────────────────
;;; 1. CORE PATHS
;;; ─────────────────────────────────────────────────────────────

(setq org-directory "~/org/")

(defun my/org-file (name)
  "Return full path to an org file in `org-directory'."
  (expand-file-name name org-directory))

;; All your main files
(defvar my/org-inbox     (my/org-file "inbox.org"))
(defvar my/org-projects  (my/org-file "projects.org"))
(defvar my/org-notes     (my/org-file "notes.org"))
(defvar my/org-ideas     (my/org-file "ideas.org"))
(defvar my/org-contacts  (my/org-file "contacts.org"))
(defvar my/org-calendar  (my/org-file "calendars.org"))
(defvar my/org-done      (my/org-file "done.org"))
(defvar my/org-daily-dir (expand-file-name "daily/" org-directory))

;;; ─────────────────────────────────────────────────────────────
;;; 2. GENERAL ORG SETTINGS
;;; ─────────────────────────────────────────────────────────────

(after! org
  ;; Agenda scans all org files plus the daily/ directory
  (setq org-agenda-files (list org-directory my/org-daily-dir))

  ;; Logging & history — write timestamps and notes into :LOGBOOK:
  (setq org-log-done 'time
        org-log-into-drawer t
        org-log-redeadline 'time
        org-log-reschedule 'time)

  ;; Visual polish
  (setq org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis " ▾"
        org-startup-folded 'content
        org-startup-indented t)

  ;; Refile: all agenda files up to 3 levels deep
  (setq org-refile-targets
        '((nil :maxlevel . 3)
          (org-agenda-files :maxlevel . 3)))
  (setq org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil)

  ;; Archive completed/cancelled tasks into done.org
  (setq org-archive-location (concat my/org-done "::* Archive"))

  ;; ── Todo keywords ──────────────────────────────────────────
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i!)" "WAITING(w@/!)" "|"
           "DONE(d!)" "CANCELLED(c@)")
          (sequence "EVENT(e)" "|" "HAPPENED(h!)")
          (sequence "IDEA(a)" "EXPLORING(x!)" "|" "ADOPTED(A!)" "DROPPED(D@)")))

  (setq org-todo-keyword-faces
        '(("TODO"        . (:foreground "#ff6c6b" :weight bold))
          ("NEXT"        . (:foreground "#da8548" :weight bold))
          ("IN-PROGRESS" . (:foreground "#ecbe7b" :weight bold))
          ("WAITING"     . (:foreground "#a9a1e1" :weight bold))
          ("DONE"        . (:foreground "#98be65" :weight bold))
          ("CANCELLED"   . (:foreground "#5B6268" :weight bold :strike-through t))
          ("EVENT"       . (:foreground "#51afef" :weight bold))
          ("HAPPENED"    . (:foreground "#98be65" :weight bold))
          ("IDEA"        . (:foreground "#c678dd" :weight bold))
          ("EXPLORING"   . (:foreground "#da8548" :weight bold))
          ("ADOPTED"     . (:foreground "#98be65" :weight bold))
          ("DROPPED"     . (:foreground "#5B6268" :weight bold))))

  ;; ── Tags ───────────────────────────────────────────────────
  (setq org-tag-alist
        '((:startgroup)
          ("@work"     . ?w)
          ("@home"     . ?h)
          ("@errands"  . ?e)
          ("@computer" . ?c)
          ("@phone"    . ?p)
          (:endgroup)
          ("URGENT"    . ?u)
          ("SOMEDAY"   . ?s)
          ("REVIEW"    . ?r)
          ("HABIT"     . ?H))))

;;; ─────────────────────────────────────────────────────────────
;;; 3. CAPTURE TEMPLATES
;;; ─────────────────────────────────────────────────────────────

(after! org
  (setq org-capture-templates
        `(
          ;; ── INBOX ──────────────────────────────────────────
          ("i" "📥 Inbox")

          ("it" "Task"
           entry (file ,my/org-inbox)
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%i\n"
           :empty-lines 1)

          ("ii" "Item with source link"
           entry (file ,my/org-inbox)
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:SOURCE:  %a\n:END:\n%i\n"
           :empty-lines 1)

          ;; ── CALENDAR / EVENTS ──────────────────────────────
          ("c" "📅 Calendar")

          ("ce" "Event"
           entry (file+headline ,my/org-calendar "Events")
           "* EVENT %?\n:PROPERTIES:\n:CREATED: %U\n:END:\nSCHEDULED: %^T\n%i\n"
           :empty-lines 1)

          ("cd" "Deadline / due date"
           entry (file+headline ,my/org-calendar "Deadlines")
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\nDEADLINE: %^T\n%i\n"
           :empty-lines 1)

          ("cb" "Birthday (recurring)"
           entry (file+headline ,my/org-calendar "Birthdays")
           "* %^{Name}'s Birthday\n:PROPERTIES:\n:CREATED:  %U\n:BIRTHDAY: %^{Date (YYYY-MM-DD)}\n:END:\n"
           :empty-lines 1)

          ;; ── PROJECTS ───────────────────────────────────────
          ("p" "📁 Projects")

          ("pp" "New project"
           entry (file+headline ,my/org-projects "Projetos")
           ,(concat "* TODO %^{Project name} [/]\n"
                    ":PROPERTIES:\n"
                    ":CREATED:  %U\n"
                    ":GOAL:     %^{Desired outcome}\n"
                    ":END:\n\n"
                    "** Vision\n%?\n\n"
                    "** Tasks [/]\n"
                    "*** TODO First action step\n\n"
                    "** Notes\n\n"
                    "** Resources\n")
           :empty-lines 1)

          ("pt" "Task for existing project"
           entry (file+headline ,my/org-projects "Projetos")
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%i"
           :empty-lines 1)

          ;; ── NOTES ──────────────────────────────────────────
          ("n" "📝 Notes")

          ("nn" "Titled note"
           entry (file+headline ,my/org-notes "Notes")
           "* %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?\n"
           :empty-lines 1)

          ("nq" "Quick / fleeting note"
           entry (file+headline ,my/org-notes "Fleeting")
           "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n"
           :empty-lines 1)

          ;; ── IDEAS ──────────────────────────────────────────
          ("a" "💡 Idea"
           entry (file+headline ,my/org-ideas "Ideas")
           "* IDEA %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?\n"
           :empty-lines 1)

          ;; ── CONTACTS ───────────────────────────────────────
          ("C" "👤 Contact"
           entry (file+headline ,my/org-contacts "Contacts")
           ,(concat "* %^{Full Name}\n"
                    ":PROPERTIES:\n"
                    ":CREATED:   %U\n"
                    ":EMAIL:     %^{Email}\n"
                    ":PHONE:     %^{Phone}\n"
                    ":BIRTHDAY:  %^{Birthday (YYYY-MM-DD)}\n"
                    ":ADDRESS:   %^{Address}\n"
                    ":COMPANY:   %^{Company}\n"
                    ":CATEGORY:  %^{Category|family|friend|work|acquaintance}\n"
                    ":END:\n\n"
                    "** Notes\n%?\n\n"
                    "** Interaction log\n")
           :empty-lines 1)

          ;; ── DAILY ──────────────────────────────────────────
          ("d" "📆 Daily")

          ("dj" "Journal / log entry"
           entry (function my/org-goto-today-log)
           "* %<%H:%M> %?\n"
           :empty-lines 0)

          ("dm" "Mood check-in"
           entry (function my/org-goto-today-log)
           ,(concat "* %<%H:%M> Check-in\n"
                    ":PROPERTIES:\n"
                    ":MOOD:   %^{Mood 1-10}\n"
                    ":ENERGY: %^{Energy 1-10}\n"
                    ":END:\n%?\n")
           :empty-lines 1))))

;;; ─────────────────────────────────────────────────────────────
;;; 4. DAILY FILE SYSTEM
;;; ─────────────────────────────────────────────────────────────

(defun my/org-daily-file (&optional date)
  "Return path for the daily file for DATE (defaults to today)."
  (let* ((time (or date (current-time)))
         (fname (format-time-string "%Y-%m-%d.org" time)))
    (expand-file-name fname my/org-daily-dir)))

(defun my/org-create-daily-file (&optional date)
  "Create today's daily org file from template if it doesn't exist."
  (interactive)
  (unless (file-exists-p my/org-daily-dir)
    (make-directory my/org-daily-dir t))
  (let* ((file     (my/org-daily-file date))
         (time     (or date (current-time)))
         (date-str (format-time-string "%A, %B %d %Y" time))
         (ymd      (format-time-string "%Y-%m-%d" time)))
    (unless (file-exists-p file)
      (with-temp-file file
        (insert
         (format
          "#+TITLE:    Daily — %s
#+DATE:     %s
#+STARTUP:  content

* Rotina Matinal :routine:

* Prioridades do Dia
1.
2.
3.

* Tarefas e eventos

* 📋 Notas e logs
** Intenções matinais

** Log

* 🌙 Fim da Tarde Rotina :routine:
** TODO Review completed tasks
** TODO Processar o inbox → zero                                       :HABIT:
   SCHEDULED: <%s .+1d>
   :PROPERTIES:
   :STYLE:    habit
   :END:
** TODO Escrever as prioridades de amanhã
** TODO Gratidão — 3 coisas que foram boas :HABIT:
   SCHEDULED: <%s .+1d>
   :PROPERTIES:
   :STYLE:    habit
   :END:
** Reflexões
*** O que deu certo ?

*** O que poderia melhorar ?

"
          date-str ymd
          ymd ymd   ; morning water
          ymd       ; morning movement
          ymd       ; inbox
          ymd))))   ; gratitude
    file))

(defun my/org-open-today ()
  "Open (creating if needed) today's daily file."
  (interactive)
  (find-file (my/org-create-daily-file)))

(defun my/org-goto-today-log ()
  "Navigate to the Log section of today's daily file (for capture)."
  (set-buffer (find-file-noselect (my/org-create-daily-file)))
  (goto-char (point-min))
  (or (search-forward "** Log" nil t)
      (goto-char (point-max))))

;;; ─────────────────────────────────────────────────────────────
;;; 5. HABIT TRACKING
;;; ─────────────────────────────────────────────────────────────

(after! org
  (require 'org-habit)
  (setq org-habit-show-habits              t
        org-habit-show-habits-only-for-today nil
        org-habit-graph-column             52   ; column where the bar starts
        org-habit-preceding-days           21   ; 3 weeks of history
        org-habit-following-days           7    ; 1 week preview
        org-habit-show-all-today           t))

;;; ─────────────────────────────────────────────────────────────
;;; 6. HABITS FILE  (~/org/habits.org)
;;; ─────────────────────────────────────────────────────────────
;;
;; A dedicated habits.org is simpler to maintain than embedding
;; habits inside daily files.  Create it once; the agenda reads it.
;;
;; Run  M-x my/org-create-habits-file  to bootstrap it.

(defvar my/org-habits (my/org-file "habits.org"))

(defun my/org-create-habits-file ()
  "Bootstrap ~/org/habits.org with starter habits."
  (interactive)
  (unless (file-exists-p my/org-habits)
    (with-temp-file my/org-habits
      (insert
       "#+TITLE: Habits
#+STARTUP: content

* Daily Habits
** TODO Drink 8 glasses of water                                   :HABIT:
   SCHEDULED: <2024-01-01 Mon .+1d>
   :PROPERTIES:
   :STYLE:    habit
   :REPEAT_TO_STATE: TODO
   :END:

** TODO Morning movement (5 min)                                   :HABIT:
   SCHEDULED: <2024-01-01 Mon .+1d>
   :PROPERTIES:
   :STYLE:    habit
   :REPEAT_TO_STATE: TODO
   :END:

** TODO Read (30 min)                                              :HABIT:
   SCHEDULED: <2024-01-01 Mon .+1d>
   :PROPERTIES:
   :STYLE:    habit
   :REPEAT_TO_STATE: TODO
   :END:

** TODO Process inbox → zero                                       :HABIT:
   SCHEDULED: <2024-01-01 Mon .+1d>
   :PROPERTIES:
   :STYLE:    habit
   :REPEAT_TO_STATE: TODO
   :END:

** TODO Gratitude — 3 things                                       :HABIT:
   SCHEDULED: <2024-01-01 Mon .+1d>
   :PROPERTIES:
   :STYLE:    habit
   :REPEAT_TO_STATE: TODO
   :END:

* Weekly Habits
** TODO Weekly review                                              :HABIT:
   SCHEDULED: <2024-01-01 Mon .+7d>
   :PROPERTIES:
   :STYLE:    habit
   :REPEAT_TO_STATE: TODO
   :END:

** TODO Exercise session                                           :HABIT:
   SCHEDULED: <2024-01-01 Mon .+2d>
   :PROPERTIES:
   :STYLE:    habit
   :REPEAT_TO_STATE: TODO
   :END:
")))
  (message "habits.org created at %s" my/org-habits))

;; Make sure habits.org is always in the agenda
(after! org
  (add-to-list 'org-agenda-files my/org-habits))

;;; ─────────────────────────────────────────────────────────────
;;; 7. AGENDA VIEWS
;;; ─────────────────────────────────────────────────────────────

(after! org-agenda
  (setq org-agenda-custom-commands
        '(
          ;; ── d : Daily dashboard ────────────────────────────
          ("d" "📆 Daily Dashboard"
           ((agenda ""
                    ((org-agenda-span 'day)
                     (org-agenda-start-with-log-mode t)
                     (org-agenda-log-mode-items '(clock state))
                     (org-agenda-todo-ignore-scheduled 'future)
                     (org-agenda-overriding-header
                      "══ TODAY ══════════════════════════════════════")))
            (todo "IN-PROGRESS"
                  ((org-agenda-overriding-header
                    "── In Progress ────────────────────────────────")))
            (todo "NEXT"
                  ((org-agenda-overriding-header
                    "── Next Actions ───────────────────────────────")))
            (todo "WAITING"
                  ((org-agenda-overriding-header
                    "── Waiting / Blocked ──────────────────────────"))))
           ((org-agenda-compact-blocks nil)))

          ;; ── w : Weekly review ──────────────────────────────
          ("w" "📊 Weekly Review"
           ((agenda ""
                    ((org-agenda-span 7)
                     (org-agenda-start-on-weekday 1)
                     (org-agenda-start-day "-0d")
                     (org-agenda-overriding-header
                      "══ THIS WEEK ══════════════════════════════════")))
            (tags-todo "URGENT"
                       ((org-agenda-overriding-header
                         "── Urgent ─────────────────────────────────────")))
            (todo "TODO|NEXT"
                  ((org-agenda-files (list my/org-projects))
                   (org-agenda-overriding-header
                    "── Active Projects ────────────────────────────"))))
           ((org-agenda-compact-blocks nil)))

          ;; ── p : Projects ───────────────────────────────────
          ("p" "📁 Projects"
           ((todo "TODO|NEXT|IN-PROGRESS"
                  ((org-agenda-files (list my/org-projects))
                   (org-agenda-overriding-header
                    "══ PROJECT TASKS ══════════════════════════════")))
            (todo "WAITING"
                  ((org-agenda-files (list my/org-projects))
                   (org-agenda-overriding-header
                    "── Waiting (projects) ─────────────────────────"))))
           ((org-agenda-compact-blocks nil)))

          ;; ── i : Inbox ──────────────────────────────────────
          ("i" "📥 Inbox — Process me"
           ((todo ""
                  ((org-agenda-files (list my/org-inbox))
                   (org-agenda-overriding-header
                    "══ INBOX ══════════════════════════════════════")))))

          ;; ── H : Habits ─────────────────────────────────────
          ("H" "🔁 Habits — this week"
           ((agenda ""
                    ((org-agenda-span 7)
                     (org-agenda-start-on-weekday 1)
                     (org-agenda-start-day "-0d")
                     (org-agenda-files (list my/org-habits))
                     (org-habit-show-habits t)
                     (org-agenda-overriding-header
                      "══ HABITS ═════════════════════════════════════")))))

          ;; ── c : Calendar / upcoming ────────────────────────
          ("c" "📅 Calendar — next 30 days"
           ((agenda ""
                    ((org-agenda-span 30)
                     (org-agenda-start-day "-0d")
                     (org-agenda-files (list my/org-calendar))
                     (org-agenda-overriding-header
                      "══ UPCOMING ═══════════════════════════════════"))))
           ((org-agenda-compact-blocks nil)))

          ;; ── A : GTD contexts ───────────────────────────────
          ("A" "🗂 Tasks by context"
           ((tags-todo "@work"
                       ((org-agenda-overriding-header "── @work ──────────────────────────────────────")))
            (tags-todo "@home"
                       ((org-agenda-overriding-header "── @home ──────────────────────────────────────")))
            (tags-todo "@errands"
                       ((org-agenda-overriding-header "── @errands ───────────────────────────────────")))
            (tags-todo "@computer"
                       ((org-agenda-overriding-header "── @computer ──────────────────────────────────")))
            (tags-todo "@phone"
                       ((org-agenda-overriding-header "── @phone ─────────────────────────────────────"))))
           ((org-agenda-compact-blocks nil))))))

;;; ─────────────────────────────────────────────────────────────
;;; 8. KEYBINDINGS  (Doom leader = SPC)
;;; ─────────────────────────────────────────────────────────────

(map! :leader
      (:prefix ("n" . "org")
       :desc "Capture"             "c" #'org-capture
       :desc "Agenda"              "a" #'org-agenda
       :desc "Daily dashboard"     "D" (cmd! (org-agenda nil "d"))
       :desc "Today's daily file"  "d" #'my/org-open-today
       :desc "Inbox"               "i" (cmd! (find-file my/org-inbox))
       :desc "Projects"            "p" (cmd! (find-file my/org-projects))
       :desc "Notes"               "n" (cmd! (find-file my/org-notes))
       :desc "Ideas"               "I" (cmd! (find-file my/org-ideas))
       :desc "Contacts"            "C" (cmd! (find-file my/org-contacts))
       :desc "Calendar"            "k" (cmd! (find-file my/org-calendar))
       :desc "Done / archive"      "K" (cmd! (find-file my/org-done))
       :desc "Habits"              "h" (cmd! (find-file my/org-habits))))

;;; ─────────────────────────────────────────────────────────────
;;; 9. CLOCK & AUTO-SAVE
;;; ─────────────────────────────────────────────────────────────

(after! org
  (setq org-clock-persist             'history
        org-clock-in-resume           t
        org-clock-out-remove-zero-time-clocks t
        org-clock-out-when-done       t
        org-clock-report-include-clocking-task t)
  (org-clock-persistence-insinuate)
  ;; Save all org buffers every 5 minutes when Emacs is idle
  (run-with-idle-timer 300 t #'org-save-all-org-buffers))
