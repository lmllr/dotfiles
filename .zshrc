# XXX LOADING PLUGINS START XXX
# LOAD OWN PROMPT
source ~/.config/zsh/prompt/prompt.zsh

# enable syntax highlighting in the current interactive shell:
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# enable auto completion + menu
source ~/.config/zsh/completion/completion.zsh

# load zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# load '.zsh_aliases' file if exists
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# load pure prompt if exists in '.zsh/'
# [ -e $HOME/.zsh/pure ] && fpath+=$HOME/.zsh/pure

# XXX gets loaded in '.zsh/completion'
# set up git-completion
# (no extra installation of anything! git alredy built in)
#autoload -Uz compinit && compinit

# XXX get rid of `%` at the end of line without <CR> XXX
PROMPT_EOL_MARK=''

# XXX IMPORTANT XXX
# to use rbenv WITHOUT 'oh-my-zsh'
# you need to init here in '.zshrc'
#
# shell commands used: rbenv shell 2.7.3
# than restart terminal and:
# ruby -v
eval "$(rbenv init -)"

# anyway XXX IMPORTANT XXX
# LOAD NVM (FOR COC.NVIM???)
export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# This loads GPG KEY for github
export GPG_TTY=$(tty)

# LOAD FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#export FZF_DEFAULT_COMMAND='find .'

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:15,bg:0,hl:3,fg+:7,bg+:8,hl+:3
--color=info:15,prompt:6,pointer:1,marker:2,spinner:5
--color=preview-fg:7
'

fi

# XXX LOADING PLUGINS END XXX

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# XXX LSCOLOR SETTINGS for github dark START XXX
export CLICOLOR=1
# export LSCOLORS=exHxbxfxcxCxBxhbhc
# XXX LSCOLOR SETTINGS for vercel START XXX
# 1. dir 2. symlink 3. socket 4. pipe 5. exec 6. block special
# 7. char special 8. exec with setuid 9. exec with setgid 10. dir sticky
# 11. dir without sticky
export LSCOLORS=exHxxxfxgx
# XXX LSCOLOR SETTINGS END XXX

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# PURE_PROMPT_SYMBOL='⚡'
# 
# # change colors
# zstyle ':prompt:pure:prompt:success' color 15
# zstyle ':prompt:pure:prompt:error' color 1
# zstyle ':prompt:pure:git:dirty' color 5
# zstyle ':prompt:pure:git:branch' color 15
# zstyle ':prompt:pure:path' color white
# 
# # pure prompt init
# autoload -U promptinit; promptinit
# prompt pure
# PROMPT='%(?.%F{15}△.%F{red}▲)%f '


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# XXX GO PATH XXX
# Set variables in .zshrc file

# don't forget to set path correctly!

#export GOPRIVATE=github.com/lmllr
export GOPATH=$HOME/golang
#export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
#export PATH=$PATH:$GOROOT/bin

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# # Rbenv:
# # --------------------------------------------------------------------------{{{
#
# # To use rbenv without 'oh-my-zsh'
# # you need to init here
# eval "$(rbenv init -)"
#
# # --------------------------------------------------------------------------}}}
# # NVM:
# # --------------------------------------------------------------------------{{{
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# # --------------------------------------------------------------------------{{{
# export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
