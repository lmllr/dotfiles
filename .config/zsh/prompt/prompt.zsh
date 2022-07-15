# ℹ️  Get more Information:
#   https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
#
# ⚠️  This prompt uses NerdFont symbols in certain places
#    if you want this to work properly download nerdfonts
#
#       https://www.nerdfonts.com

# %s
# The current version control system, like git or svn.
# %r
# The name of the root directory of the repository
# %S
# The current path relative to the repository root directory
# %b
# Branch information, like master
# %m
# In case of Git, show information about stashes
# %u
# Show unstaged changes in the repository
# %c
# Show staged changes in the repository

# Mark vcs_info for autoloading
autoload -Uz vcs_info
# Mark add-zsh-hook for autoloading
autoload -U add-zsh-hook
setopt prompt_subst

# Used for debugging
# Comment it out or disable it
# Debugging is off by default.
#zstyle ':vcs_info:*+*:*' debug true

# If set to true, vcs_info goes the extra mile to figure out the revision of
# a repository’s work tree (currently for the git and hg backends,
# where this kind of information is not always vital). For git,
# the hash value of the currently checked out commit is available via
# the %i expansion. With hg,
# the local revision number and the corresponding global hash are available via %i.
zstyle ':vcs_info:*' get-revision true

# If enabled, this style causes the %c and %u format escapes to show when
# the working directory has uncommitted changes.
# The strings displayed by these escapes can be controlled via the stagedstr and
# unstagedstr styles. The only backends that currently support this option are git,
# hg, and bzr (the latter two only support unstaged).
# For this style to be evaluated with the hg backend,
# the get-revision style needs to be set and the use-simple style needs to be unset.
# The latter is the default; the former is not.
# With the bzr backend,
# lightweight checkouts only honor this style if the use-server style is set.
# Note, the actions taken if this style is enabled are potentially expensive
# (read: they may be slow, depending on how big the current repository is).
# Therefore, it is disabled by default.
zstyle ':vcs_info:*' check-for-changes true

# This style is like check-for-changes, but it never checks the worktree files,
# only the metadata in the .${vcs} dir. Therefore,
# this style initializes only the %c escape (with stagedstr) but not the %u escape.
# This style is faster than check-for-changes.
# In the git backend, this style checks for changes in the index.
# Other backends do not currently implement this style.
# This style is disabled by default.
zstyle ':vcs_info:*' check-for-staged-changes true

# This string will be used in the %u escape if there are unstaged changes in the repository.
# NOT BEING USED
# zstyle ':vcs_info:git*' unstagedstr '+'

# This string will be used in the %c escape if there are staged changes in the repository.
# zstyle ':vcs_info:git*' stagedstr '*'


# A list of formats, used when actionformats is not used (which is most of the time).
zstyle ':vcs_info:git*' formats "%F{9}(%b%c%u)%f %m" # hash & branch

# A list of formats, used if there is a special action going on
# in your current repository; like an interactive rebase or a merge conflict.
zstyle ':vcs_info:git*' actionformats "%F{9}(%b%c%u)%f %F{11}%a%f"

zstyle ':vcs_info:git*+set-message:*' hooks git-st git-stash git-dirty

### Check for git tag

### git: Show git tag name
# FIXME
# +vi-git-tag(){
#     local tag=$(git name-rev --name-only --no-undefined --always HEAD)
#     [[ -n ${tag} ]] && [[ ${tag} =~ [0-9] ]]&& hook_com[branch]+="%F{11}.%fv${tag[6, -1]}"
# }

### Check the branchnames

### git: Show branch names
### git: Color branch names
# +vi-git-branch(){
#     hook_com[branch]=$(helper_check_branch_name ${hook_com[branch]})
#     # Color branchname `main`, `master` and `develop` 9
#     if [[ ${hook_com[misc]} = *'Merge'* ]]; then
#         hook_com[branch]="%F{magenta}"$'\Ue727'"%f ${hook_com[branch]}"
#     elif [[ ${hook_com[branch]} =~ main\|master\|develop ]]; then
#         hook_com[branch]="%F{9}"$'\Ue725'"%f ${hook_com[branch]}"
#     elif [[ ${hook_com[branch]} = *'test'* ]]; then
#         hook_com[branch]="%F{yellow}"$'\Ufb67'"%f ${hook_com[branch]}"
#     else
#         hook_com[branch]="%F{green}"$'\Ue726'"%f ${hook_com[branch]}"
#     fi
#
# }
# helper_check_branch_name(){
#     if [[ -n $1 ]]; then
#         if [[ $1 =~ main\|master\|develop ]]; then
#             echo "%F{9}$1%f"
#         else
#             echo "%F{11}$1%f"
#         fi
#     fi
# }

### Display the existence of files not yet known to VCS

### git: Show marker (益) if git branch is dirty
### git: Show marker (U+e729) if staged files exist
# Make sure you have added staged to your 'formats':  %c
+vi-git-dirty(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
       git status --porcelain | grep -q '^?? ' 2> /dev/null ||
       [[ -n ${hook_com[staged]} ]] ||
       [[ -n ${hook_com[unstaged]} ]]; then
       # [[ -n ${hook_com[staged]} ]]; then
         # This will show the marker if there are any untracked files in repo.
         # If instead you want to show the marker only if there are untracked
         # files in $PWD, use:
         #[[ -n $(git ls-files --others --exclude-standard) ]] ; then

         # If the length of string `hook_com[staged]` is non-zero
         if [[ ${hook_com[unstaged]} = 'U' ]] && \
            [[ ${hook_com[staged]} = 'S' ]]; then
              hook_com[staged]=' *'
              hook_com[unstaged]='+'
         elif [[ ${hook_com[staged]} = 'S' ]]; then
          hook_com[staged]=' *'
         elif [[ ${hook_com[unstaged]} = 'U' ]]; then
          hook_com[unstaged]=' +'
         fi
    fi
}

### Display count of stash

### git: Show marker (≡N) if stash exists
# Make sure you have added misc to your 'formats':  %m
function +vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        stash=$(git stash list 2>/dev/null | wc -l | xargs)
        n=${stash}
        if [[ -n ${stash} ]]; then
            #stash='%F{yellow}≡%f'
            stash='≡'
        fi
        hook_com[misc]+="${stash}${n}"
    fi
}

### Compare local changes to remote changes

### git: Show ⇡N/⇣N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats':  %m
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( "%F{cyan}⇡${ahead}%f" )
    (( $behind )) && gitstatus+=( "%F{cyan}⇣${behind}%f" )

    hook_com[misc]+=${(j:%F{9}/%f:)gitstatus}
}

# Default to running vcs_info. If possible we prevent running it later for
# speed reasons. If set to a non empty value vcs_info is run.
FORCE_RUN_VCS_INFO=1

# Only run vcs_info when necessary to speed up the prompt and make using
# check-for-changes bearable in bigger repositories. This setup was
# inspired by Bart Trojanowski
# (http://jukie.net/~bart/blog/pimping-out-zsh-prompt).
#
# This setup is by no means perfect. It can only detect changes done
# through the VCS's commands run by the current shell. If you use your
# editor to commit changes to the VCS or if you run them in another shell
# this setup won't detect them. To fix this just run "cd ." which causes
# vcs_info to run and update the information. If you use aliases to run
# the VCS commands update the case check below.
zstyle ':vcs_info:*+pre-get-data:*' hooks pre-get-data
+vi-pre-get-data() {
    # Only Git and Mercurial support and need caching. Abort if any other
    # VCS is used.
    [[ "$vcs" != git && "$vcs" != hg ]] && return

    # If the shell just started up or we changed directories (or for other
    # custom reasons) we must run vcs_info.
    if [[ -n $FORCE_RUN_VCS_INFO ]]; then
        FORCE_RUN_VCS_INFO=
        return
    fi

    # If we got to this point, running vcs_info was not forced, so now we
    # default to not running it and selectively choose when we want to run
    # it (ret=0 means run it, ret=1 means don't).
    ret=1
    # If a git/hg command was run then run vcs_info as the status might
    # need to be updated.
    case "$(fc -ln $(($HISTCMD-1)))" in
        git*)
            ret=0
            ;;
        hg*)
            ret=0
            ;;
    esac
}

# Call vcs_info as precmd before every prompt.
prompt_precmd() {
    vcs_info
}
add-zsh-hook precmd prompt_precmd

# Must run vcs_info when changing directories.
prompt_chpwd() {
    FORCE_RUN_VCS_INFO=1
}
add-zsh-hook chpwd prompt_chpwd

# Display the VCS information in the right prompt.
PROMPT=$'\n''%F{blue}%~%f ${vcs_info_msg_0_}'$'\n''%(?.%F{green}%%.%F{9}%%)%f '
