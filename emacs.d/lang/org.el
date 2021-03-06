(require 'org)
(require 'org-habit)

(add-hook 'org-mode-hook '(lambda () (auto-fill-mode t)))
(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'detect-language-per-paragraph)

(setq org-src-fontify-natively t)
(setq org-hide-leading-stars t)

(setq org-latex-listings 'minted)

(setq org-latex-packages-alist ; (options package-name required-for-previews)
      '(("" "minted" nil) ;; syntax highlighting
        ("" "mhchem" t)   ;; typesetting chemistry
        ("" "tikz" nil)   ;; Graphs (breaks previews)
        ("european" "circuitikz" nil)
        ("" "pgfplots" nil)
        ("" "amsmath" t)  ;; Some math symbols
        ("" "mathtools" t)
        ("" "relsize" t)
        ("" "systeme" t)))

(let ((use-default (if on-osx "open %s" "xdg-open %s")))
  (setq org-file-apps
        `(("\\.pdf\\'" . ,use-default)
          ("\\.png\\'" . ,use-default)
          ("\\.gif\\'" . ,use-default)
          ("\\.jpeg\\'" . ,use-default)
          ("\\.jpg\\'" . ,use-default)
          ("\\.bmp\\'" . ,use-default)
          (auto-mode . emacs)
          ("\\.mm\\'" . default)
          ("\\.x?html?\\'" . ,use-default))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (gnuplot . t)
   (plantuml . t)))

(setq org-plantuml-jar-path (expand-file-name "/opt/plantuml/plantuml.jar"))

(setq org-latex-minted-langs
      '((emacs-lisp "common-lisp")
        (lisp "common-lisp")
        (cc "c++")
        (cperl "perl")
        (shell-script "bash")
        (caml "ocaml")))

(setq org-html-postamble nil)

(setq org-format-latex-options
      '(:foreground default
        :background default
        :scale 2.0
        :html-foreground "Black"
        :html-background "Transparent"
        :html-scale 1.0
        :matchers
        ("begin" "$1" "$" "$$" "\\(" "\\[")))

(setq org-refile-use-outline-path t)
(setq org-refile-targets '((nil . (:maxlevel . 3))))

(setq org-directory "~/doc")
(setq org-default-notes-file (concat org-directory "/notes.org"))

(require 'org-contacts)
(setq org-contacts-files '("~/doc/contacts.org"))

(require 'org-capture)
(add-to-list 'org-capture-templates
             '("c" "Contacts" entry (file "~/doc/contacts.org")
               "* %(org-contacts-template-name)
   :PROPERTIES:
   :EMAIL: %(org-contacts-template-email)
   :END:"))

(require 'ox-latex)

(setq memoir-header-code
               "\\documentclass[11pt]{memoir}
\\nouppercaseheads
\\pagestyle{Ruled}
")

(add-to-list 'org-latex-classes
             `("memoir" ,memoir-header-code

               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))

(add-to-list 'org-latex-classes
             `("memoir-with-part" ,memoir-header-code

               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
