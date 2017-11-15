# Set up the prompt
# 環境変数
export LANG=ja_JP.UTF-8
fpath=(~/projects/dotfiles/.zsh-completions $fpath)

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

#色を使用出来るようにする
autoload -Uz colors
colors

# cd省略、ディレクトリ名の時
setopt auto_cd

# cd後、自動でpushdする
setopt auto_pushd

# pushd重複削除 nasa
# setopt auto_ignore_pushd

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

#重複したディレクトリを追加しない
setopt pushd_ignore_dups

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# ヒストリーに重複を表示しない
setopt histignorealldups

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
# 例： <Space>echo hello と入力
setopt hist_ignore_space

# ターミナル間でヒストリー共有
setopt sharehistory

# Use modern completion system
autoload -Uz compinit
compinit

# 日本語ファイル名を表示可能に
setopt print_eight_bit

# '#'以降をコメント
setopt interactive_comments

# プロンプト
# １行目表示
# PROMPT="%~ %# "
# ２行表示
PROMT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

#zstyle

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin /usr/local/git/bin



#alias

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

#sudoの後のコマンドでエイリアスを有効
alias sudo='sudo '

#global alias
alias -g L='| less'
alias -g G='| grep'

#emacs
alias em='emacs -nw'

#MeCab
alias mecab-ipadic='mecab -d /var/lib/mecab/dic/ipadic'
alias mecab-unidic='mecab -d /var/lib/mecab/dic/unidic'

#ssh
alias ssh_nlp='ssh -oProxyCommand="ssh -W %h:%p nlp"'
alias sshfs_nlp='sshfs -oProxyCommand="ssh -W %h:%p nlp"'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi


# 単語の一部として扱われる文字のセットを指定する
# ここではデフォルトのセットから / を抜いたものとする
# こうすると、 Ctrl-W でカーソル前の1単語を削除したとき、 / までで削除が止まる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

export PATH="/usr/local/sh:/path/to/mteval/build/bin:$PATH"
# export XDG_DATA_DIRS="/home/aki-home/.linuxbrew/share:$XDG_DATA_DIRS"

export PYENV_ROOT="$HOME/.pyenv"
export PASH="$PYENV_ROOT/bin:$PASH"
eval "$(pyenv init -)"

#export HTTP_PROXY='http://proxy.nagaokaut.ac.jp:8080'
#export HTTPS_PROXY='http://proxy.nagaokaut.ac.jp:8080'
#export FTP_PROXY='http://proxy.nagaokaut.ac.jp:8080'
#export NO_PROXY='localhost,.nagaokaut.ac.jp'
