# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# ZSH Plugins to load from $ZSH/plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# Exports ---------------------------------------------------------
## For git commit signing
export GREP_OPTIONS="--colour-auto"
export GREP_COLOR="1;32"
export MANPAGER="less -X"
export LSCOLORS="Gxfxcxdxbxegedabagacad"
## Set config home directory
export XDG_CONFIG_HOME="$HOME/.config"
## Allow JDK's to be picked up in non cask install location
## look at setting again if JDK's aren't shimmed correctly by asdf
## export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
export PATH="$(go env GOPATH)/bin:/opt/homebrew/bin:$PATH"
## Add Homebrew to path etc
eval "$(/opt/homebrew/bin/brew shellenv)"


# Options ----------------------------------------------------------
## Changing Directories
setopt auto_cd
setopt cdablevarS
setopt pushd_ignore_dups

## Basic
setopt no_beep

## History
setopt append_history # Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history # save timestamp of command and duration
setopt inc_append_history # Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # Do not write events to history that are duplicates of previous events
setopt hist_ignore_space # remove command line from history list when first character on the line is space
setopt hist_find_no_dups # When searching history don't display results already cycled through twice
setopt hist_reduce_blanks # Remove extra blanks from each command line being added to history
setopt hist_verify # don't execute, just expand history
setopt share_history # imports new commands and appends typed commands to history

## Completion
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of theword
setopt auto_menu # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # Allow completion from within a word/phrase
unsetopt menu_complete # do not autoselect the first completion entry
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/opt/homebrew/bin/aws_completer' aws

## Correction
setopt correct # spelling correction for commands
setopt correctall # spelling correction for arguments

## Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
## Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'


# Aliases ---------------------------------------------------------
alias vi=nvim
alias vim=nvim
alias c='clear; ls -al'
alias sz='source ~/.zshrc'
alias setu='git push --set-upstream origin $(git name-rev --name-only --no-undefined --always HEAD)'
alias grep=ggrep


# PGP configuration -----------------------------------------------
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent


# Prompt Configuration --------------------------------------------
PROMPT='${PWD/#$HOME/~} $(git_prompt_string)$ '


# ASDF Configuration ----------------------------------------------
. $(brew --prefix asdf)/libexec/asdf.sh
. ~/.asdf/plugins/java/set-java-home.zsh


# Rust Configuration ----------------------------------------------
. "$HOME/.cargo/env"

# Git Configuration -----------------------------------------------
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_colour%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# setopt promptsubst
autoload -U colors && colors # Enable colors in prompt

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"
GIT_PROMPT_PREFIX="%{$fg[green]%} [%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}u%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}m%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}s%{$reset_color%}"
# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
	(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}
# If inside a Git repository, print its branch and state
function git_prompt_string() {
	local git_where="$(parse_git_branch)"
	[ -n "$git_where" ] && echo "on %{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$(parse_git_state)%{$reset_color%}"
}
# Show different symbols as appropriate for various Git repository states
function parse_git_state() {
	# Compose this value via multiple conditional appends.
	local GIT_STATE=""
	local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
	if [ "$NUM_AHEAD" -gt 0 ]; then
		GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
	fi
	local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
	if [ "$NUM_BEHIND" -gt 0 ]; then
		GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
	fi
	local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
	if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
		GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
	fi 
	if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
		GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
	fi
	if ! git diff --quiet 2> /dev/null; then
		GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
	fi
	if ! git diff --cached --quiet 2> /dev/null; then
		GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
	fi
	if [[ -n $GIT_STATE ]]; then
		echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
	fi
}
function prompt_char {
	git branch >/dev/null 2>/dev/null && echo '±' && return
	hg root >/dev/null 2>/dev/null && echo '☿' && return
	echo '○'
}
function box_name {
	[ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}
function virtualenv_info {
	[ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}
function current_pwd {
	echo $(pwd | sed -e "s,^$HOME,~,")
}
