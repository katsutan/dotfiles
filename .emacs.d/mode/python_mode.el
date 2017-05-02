(require 'package)
(setq package-archives
      (append '(("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa" . "http://melpa.milkbox.net/packages/"))
              package-archives))
(package-initialize)

(add-hook 'python-mode-hook
	  (lambda ()
 	    (define-key python-mode-map (kbd "\C-m") 'newline-and-indent)
            (define-key python-mode-map (kbd "RET") 'newline-and-indent)))

(yas-global-mode t)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

(require 'auto-complete-config)
(ac-config-default)

(require 'tramp-cmds)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
					; Make sure it's not a remote buffer or flymake wouid not work
    (when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
      (let* ((temp-file (flymake-init-create-temp-inplace))
	     (local-file (file-relative-name
			  temp-file
			  (file-name-directory buffer-file-name))))
	(list "pyflakes" (list local-file)))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'python-mode-hook
	  (lambda ()
	    (flymake-mode t)))

(cond (window-system
       (setq x-select-enable-clipboard t)
       ))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "magenta"))))
 '(font-lock-string-face ((t (:foreground "brightyellow")))))
