(push "/usr/local/bin" exec-path)

(when (file-exists-p "/usr/texbin") ;; MacTex
    (push "/usr/texbin" exec-path)
    (setenv "PATH" (concat "/usr/texbin" path-separator
                           (getenv "PATH"))))

(setenv "LC_CTYPE" "en_US.UTF-8")
