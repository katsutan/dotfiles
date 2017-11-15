;; coding: UTF-8
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; スタート時のメッセージ表示オフ
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

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
(set-face-attribute 'default nil
		    :family "VL ゴシック"
		    :height 100)

;; ;;日本語フォント設定 ;;
;;(set-fontset-font 
;; nil 
;; 'japanese-jisx0208 
;;(font-spec :family "メイリオ" :size 13))

		    
;;
;; COLOR
;;

;; region COLOR
(set-face-background 'region "darkblue")

(when (require 'color-theme nil t)
  ;; theme read config
  (color-theme-initialize)
  ;; theme chage
  (color-theme-charcoal-black))
;;現在行の色
(defface my-hl-line-face
  `((((class color) (background dark))
     (:background "#383838" t))                ;;紺色
	(((class color) (background light))
     (:background "LightGoldenrodYellow" t))    ;;緑色
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;;行番号を常に表示
;; (global-linum-mode t)

;; (defvar my-linum-min-width 4)
;; (setq linum-format
;; 	  (lambda (line)
;; 		(let ((fmt (format
;; 			    "%%%dd|"
;; 			    (max
;; 			     my-linum-min-width
;; 			     (length (number-to-string 
;; 				      (count-lines (point-min) (point-max))))))))
;; 		  (propertize (format fmt line) 'face 'linum))))
;; (set-face-attribute 'linum nil
;; 		    :foreground "white"
;; 		    :background "#303030"
;; 		    :height 0.9)




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


;;;; scroll 1
;;(setq scroll-conservatively 35
;;			scroll-margin 0
;;			scroll-step 1)
;;(global-set-key [M-up] (lambda () (interactive) (scroll-up 1)))
(global-set-key "\M-p" (lambda () (interactive) (scroll-up 1)))
;;(global-set-key [M-down] (lambda () (interactive) (scroll-down 1)))
(global-set-key "\M-n" (lambda () (interactive) (scroll-down 1)))

;;
(defun scroll-up-small () ; scroll-up-small という関数を宣言。引数なし
  "Small scroll up just 10 lines like other editors." ; 説明。日本語OK
  (interactive) ; !重要! コマンドとして呼び出せる、ということ。これがないと、ただの関数になり、バインドしたりできない
  (scroll-up 10) ; 10行スクロール!
  (forward-line 10)) ; カーソルを10行下に
(defun scroll-down-small ()
  "Small scroll down just 5 lines like other editors."
  (interactive)
  (scroll-down 10)
  (forward-line -10));; `next-line' is not recommended.
(global-set-key "\C-v" 'scroll-up-small) ; バインド。 <C-v>に。 global というのはモード関係なく、ということ
(global-set-key "\M-v" 'scroll-down-small)

 ;;
 (defun sane-newline (arg)
   "Put newline\(s\) by ARG with scrolling sanely if needed."
   (interactive "p")
   (let ((newpt (save-excursion (newline arg) (indent-according-to-mode) (point))))
     (while (null (pos-visible-in-window-p newpt)) (scroll-up 1))
     (goto-char newpt)
     (setq this-command 'newline)
     ()))

(global-set-key "\C-m" 'sane-newline)

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

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
 '(default ((t (:inherit nil :stipple nil :background "Grey15" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(font-lock-builtin-face ((t (:foreground "color-50"))))
 '(font-lock-comment-face ((t (:foreground "brightgreen"))))
 '(font-lock-keyword-face ((t (:foreground "color-45" :weight bold))))
 '(font-lock-string-face ((t (:foreground "color-220")))))


;=======================================================================
; Misc
;=======================================================================
(mouse-wheel-mode)						;;ホイールマウス
(global-font-lock-mode t)					;;文字の色つけ
(auto-compression-mode t)					;;日本語infoの文字化け防止
(set-scroll-bar-mode 'right)					;;スクロールバーを右に表示
(global-set-key "\C-z" 'undo)					;;UNDO
;
(setq-default transient-mark-mode t) ; リージョンをハイライト
(setq search-highlight t) ; 検索結果をハイライト
(setq query-replace-highlight t) ; 置換対象をハイライト
(setq highlight-nonselected-windows t) ; バッファを変えてもハイライトしたままにする
(setq truncate-lines t) ; 右端で折り返さない
(setq truncate-partial-width-windows t) ; 分割したウィンドウでも右端で折り返さない
(show-paren-mode t) ; 対応括弧を強調
(setq show-paren-ring-bell-on-mismatch t) ; 対応する括弧が画面内になければ、括弧内を強調表示
(setq show-paren-style 'mixed) ; 括弧と括弧内に色を付ける
(setq visible-bell nil) ; ファイル末尾で画面をフラッシュさせない
(blink-cursor-mode nil) ; カーソルを点滅させない
(setq cursor-in-non-selected-windows nil) ; アクティブでないウィンドウのカーソルを非表示
(line-number-mode t) ; 行番号を表示
(column-number-mode t) ; 列番号を表示
(setq resize-mini-windows nil)
(setq tooltip-use-echo-area t) ; ツールチップはエコーエリアを使う
(delete-selection-mode 1) ; リージョンを削除して文字を挿入
(setq kill-whole-line t) ; 行頭の(kill-line)で行全体を削除
(setq completion-ignore-case t) ; ファイル名補完で大文字小文字を区別させない
;(partial-completion-mode t) ; 強力な補完機能を使う
; 検索
(setq case-replace t) ; 大文字・小文字を区別しないで置換
(setq case-fold-search t) ; 大文字・小文字を区別しないで検索
; その他
(fset 'yes-or-no-p 'y-or-n-p) ; yesやnoではなくy,nで答える
(setq tags-case-fold-search nil) ; etags でのみ大文字, 小文字を区別する
(setq imenu-case-fold-search nil) ; imenuで大文字, 小文字を区別する

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
;; Space, Tab display
;;(global-whitespace-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; キーバインド
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 移動
(global-set-key "\C-a" 'beginning-of-line)
(global-set-key "\C-e" 'end-of-line)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)
(global-set-key [mouse-4] 'scroll-down)
(global-set-key [mouse-5] 'scroll-up)
(global-set-key "\M-g" 'goto-line)
(windmove-default-keybindings 'meta) ; Alt+カーソルでウィンドウ移動

; 編集
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-cq" 'comment-region)
(global-set-key "\M-i" 'indent-region)
; 検索 / 置換
(global-set-key "\M-r" 'query-replace)
(global-set-key "\C-\M-r" 'query-replace-regexp)
(global-set-key "\C-cg" 'grep)
; その他
(global-set-key "\C-\\" 'toggle-input-method)
(global-set-key "\C-x\?" 'describe-key)
(global-set-key [f1] 'help-for-help)
; クリップボードと同期
(setq x-select-enable-clipboard t)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key [S-delete] 'kill-region)
(global-set-key [C-insert] 'kill-ring-save)
(global-set-key [S-insert] 'clipboard-yank)
(global-set-key [S-mouse-3] 'yank)

(global-set-key [zenkaku-hankaku] 'anthy-mode)
(global-set-key [kanji] 'anthy-mode)
(setq anthy-wide-space " ")

;; C-m 改行から字下げ
;;(define-key global-map (kbd "C-m") 'newline-and-indent)
;; 折り返しトグルコマンド
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)
;; C-t window切り替え
;;(global-set-key (kbd "C-t") 'other-window)

;YaTeX
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;(setq tex-command "latexmk")
(setq tex-command "latexmk -pdfdvi")
;(setq dviprint-command-format "dvipdfmx %s")
(setq dvi2-command "evince")
;;;   1=Shift JIS
;;;   2=JIS
;;;   3=EUC
;;;   4=UTF-8
(setq YaTeX-kanji-code 2)
(setq YaTeX-latex-message-code 'utf-8)
(add-hook 'yatex-mode-hook 'turn-on-reftex)

(global-set-key "\C-ct" 'YaTeX-typeset-menu)
;;(global-set-key "\C-t" '(lambda () (interactive) (YaTeX-typeset-menu nil ?j)))

;;(require 'un-define)
