;; coding: UTF-8
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; Emacs 23より前のバージョンではuser-emacs-directory変数を定義
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))
;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
			  (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos" "mode")
;; /mode/python-mode.el 読み込み
(load "python_mode")

;; backup_directory >> /tmp
(setq backup-directory-alist
	  `((".*" . ,temporary-file-directory)))
;; autosave_directory >> /tmp
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

;;
;; COLOR
;;

;; region COLOR
(set-face-background 'region "darkblue")

(when (require 'color-theme nil t)
  ;; theme read config
  (color-theme-initialize)
  ;; theme chage
  (color-theme-dark-gnus))
;;現在行の色
(defface my-hl-line-face
  `((((class color) (background dark))
     (:background "brightBlack" t))                ;;紺色
	(((class color) (background light))
     (:background "LightGoldenrodYellow" t))    ;;緑色
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)
;; 対応する括弧のハイライト
;; 強調表示
(setq show-paren-delay 0)
(show-paren-mode t)
;; style
;; (setq show-paren-style 'expression)
;; 変更
(set-face-background 'show-paren-match-face "magenta")
(set-face-underline-p 'show-paren-match-face "yellow")

;; TAB width 4
(setq-default tab-width 4)

;; emacs-lisp-mode-hook用の関数を定義
(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
	(setq eldoc-idle-delay 0.2)
	(setq eldoc-echo-area-use-multiline-p t)
	(turn-on-eldoc-mode)))
;;emacs-lisp-modeのフックをセット
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)


;; column number display
(column-number-mode t)
;; file size display
(size-indication-mode t)
;; timer display
(setq display-time-day-and-date t)
(display-time-mode t)

;;むりぽ
;;battery display
;;(display-battery-mode t)

;;titleber fullpath
(setq frame-title-format "%f")

;;行番号を常に表示
(global-linum-mode t)

;; Space, Tab display
;;(global-whitespace-mode t)

;; scroll 1
(setq scroll-conservatively 1)

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;;
;;コマンド設定
;;
  
;; C-m 改行から字下げ
(define-key global-map (kbd "C-m") 'newline-and-indent)
;; 折り返しトグルコマンド
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)
;; C-t window切り替え
(global-set-key (kbd "C-t") 'other-window)


;; auto-install config
;;(when (require 'auto-install nil t)
  ;; directory_config
;;  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; from EmacsWiki get name elisp
;;  (auto-install-update-emacswiki-package-name t)
  ;; proxy
  ;;(setq url-proxy-services '(("http" . "localhost:8339")))
  ;; enable auto-install function
;;  (auto-install-compatibility-setup))

;; multi-term config
(when (require 'multi-term nil t)
  ;;shell path
  (setq multi-term-program "/usr/bin/zsh"))
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
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "brightwhite" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(font-lock-builtin-face ((t (:foreground "brightblue"))))
 '(font-lock-string-face ((t (:foreground "brightyellow")))))
