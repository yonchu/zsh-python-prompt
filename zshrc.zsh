# -----------------------------------------------------------------------------
#
# zsh-python-prompt/zshrc.sh
#
# -----------------------------------------------------------------------------
#
#  Version     : 0.0.1
#  Author      : Yonchu <yuyuchu3333@gmail.com>
#  License     : The MIT License (MIT)
#  Repository  : https://github.com/yonchu/zsh-python-prompt
#  Last Change : 02 Sep 2014.
#
#  Copyright (c) 2014 yonchu
#
# -----------------------------------------------------------------------------
# USAGE
# -----
#
# 1.Source this file.
#
#   source /path/to/zsh-python-prompt/zshrc.zsh
#
# 2.Set the environmental variable ZSH_PYTHON_PROMPT to PROMPT or RPROMPT
#
#   PROMPT+='$ZSH_PYTHON_PROMPT'
#
# 3.Enable environmental variables in PROMPT
#
#   setopt prompt_subst
#
#
# Customaize
# ----------
#
# Change pyenv symbol.
#
# zstyle ':zsh-python-prompt:pyenv:' symbol '⌘ '
#
# -----------------------------------------------------------------------------

# Initialize settings.
function(){
    local pyenv_expire_sec pyenv_symbol
    zstyle -s ':zsh-python-prompt:pyenv:' expire_sec pyenv_expire_sec
    if [[ -z $pyenv_expire_sec ]]; then
        zstyle ':zsh-python-prompt:pyenv:' expire_sec 30
    fi

    zstyle -s ':zsh-python-prompt:pyenv:' symbol pyenv_symbol
    if [[ -z $pyenv_symbol ]]; then
        zstyle ':zsh-python-prompt:pyenv:' symbol '⌘ '
    fi
}

# Add fpath
_zsh_python_prompt_dir=${0:A:h}
fpath=(${_zsh_python_prompt_dir}/functions(N-/) ${fpath})

# autoload
autoload -Uz zsh-python-prompt
autoload -Uz zsh-python-prompt-update

# Add hook function to preexec
add-zsh-hook preexec _zsh_python_prompt_preexec_hook_func
function _zsh_python_prompt_preexec_hook_func() {
    case "$2" in
        pyenv*)
            zstyle ':zsh-python-prompt:' prompt_cache ''
        ;;
    esac
}

# Add hook function to precmd
add-zsh-hook precmd _zsh_python_prompt_precmd_hook_func
function _zsh_python_prompt_precmd_hook_func() {
    zsh-python-prompt-update
    ZSH_PYTHON_PROMPT=$(zsh-python-prompt)
}

