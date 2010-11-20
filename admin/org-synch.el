(defun org-synch ()
  (let* ((date (shell-command-to-string "/bin/date '+%Y%m%d'"))
	 (dir (expand-file-name "/home/elpa/packages-new"))
	 (archive-file (expand-file-name "archive-contents" dir))
	 (package-name 'org)
	 package-file contents entry)
    (setq date (substring date 0 (- (length date) 1))
	  package-file (concat (symbol-name package-name) "-" date ".tar"))
    (unless (file-exists-p (expand-file-name package-file dir))
      (error "No package file found"))
    (find-file archive-file)
    (setq contents (read (current-buffer))
	  entry (assq package-name contents))
    (unless entry
      (error "No entry for %s in archive-contents" package-name))
    (aset (cdr entry) 0 (version-to-list date))
    (erase-buffer)
    (insert (pp-to-string contents) "\n")
    (save-buffer 0)))
