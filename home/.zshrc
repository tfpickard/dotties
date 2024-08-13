# command -v python || command -v python3 && ln -s $(dirname python3)/python3 $(dirname python3)/python
[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap
source ~/Repos/znap/znap.zsh

export PATH=/opt/homebrew/bin:$PATH
# # `znap prompt` makes your prompt visible in just 15-40ms!
# znap prompt sindresorhus/pure

# # `znap source` starts plugins.
# znap source marlonrichert/zsh-autocomplete



# The same goes for any other kind of custom prompt:
znap eval starship 'starship init zsh --print-full-init'
znap prompt

# NOTE that `znap prompt` does not work with Powerlevel10k.
# With that theme, you should use its "instant prompt" feature instead.


##
# Load your plugins with `znap source`.
#
znap source marlonrichert/zsh-autocomplete
znap source marlonrichert/zsh-edit

# `znap install` adds new commands and completions.
znap install aureliojargas/clitest \
    zsh-users/zsh-syntax-highlighting \
    zsh-users/zsh-completions \
    zsh-users/zsh-history-substring-search \
    Freed-Wu/fzf-tab-source \
    Aloxaf/fzf-tab \
    hlissner/zsh-autopair \
    MichaelAquilina/zsh-autoswitch-virtualenv 
    
# `znap eval` makes evaluating generated command output up to 10 times faster.

znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# You can also choose to load one or more files specifically:
znap source sorin-ionescu/prezto modules/{environment,history}

znap source ohmyzsh/ohmyzsh lib/{cli,git,theme-and-appearance,directories,functions,grep,history,termsupport}
znap source ohmyzsh/ohmyzsh \
    plugins/git
    # 'lib/(*~(git|theme-and-appearance).zsh)' plugins/{git,brew,macos,nmap,sudo,tmux,vi-mode}
    
ZSH_TMUX_AUTOSTART=${ZSH_TMUX_AUTOSTART:-true}
ZSH_TMUX_AUTOSTART=${ZSH_TMUX_AUTOCONNECT:-true}
ts=$(date +"%m-%d-%yT%H:%M:%S")
ZSH_TMUX_DEFAULT_SESSION_NAME=${ZSH_TMUX_DEFAULT_SESSION_NAME:-"tmux-$ts"}
ZSH_TMUX_UNICODE=true
znap source ohmyzsh/ohmyzsh \
    plugins/tmux

znap source ohmyzsh/ohmyzsh \
    plugins/{git,brew,macos,nmap,sudo,vi-mode}

# No special syntax is needed to configure plugins. Just use normal Zsh
# statements:

znap source marlonrichert/zsh-hist
bindkey '^[q' push-line-or-edit
bindkey -r '^Q' '^[Q'

ZSH_AUTOSUGGEST_STRATEGY=(  completion)
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
znap source zsh-users/zsh-autosuggestions

ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets pattern cursor )
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-history-substring-search

znap source    Freed-Wu/fzf-tab-source
znap source    Aloxaf/fzf-tab
znap source    hlissner/zsh-autopair
znap source    MichaelAquilina/zsh-autoswitch-virtualenv

##
# Cache the output of slow commands with `znap eval`.
#

# If the first arg is a repo, then the command will run inside it. Plus,
# whenever you update a repo with `znap pull`, its eval cache gets regenerated
# automatically.
znap eval trapd00r/LS_COLORS "$( whence -a dircolors gdircolors ) -b LS_COLORS"

# The cache gets regenerated, too, when the eval command has changed. For
# example, here we include a variable. So, the cache gets invalidated whenever
# this variable has changed.
znap source marlonrichert/zcolors
znap eval   marlonrichert/zcolors "zcolors ${(q)LS_COLORS}"

# Combine `znap eval` with `curl` or `wget` to download, cache and source
# individual files:
# znap eval omz-git 'curl -fsSL \
#     https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh'


##
# Defer initilization code with lazily loaded functions created by
# `znap function`.
#

# For each of the examples below, the `eval` statement on the right is not
# executed until you try to execute the associated command or try to use
# completion on it.

znap function _pyenv pyenv              'eval "$( pyenv init - --no-rehash )"'
compctl -K    _pyenv pyenv

znap function _pip_completion pip       'eval "$( pip completion --zsh )"'
compctl -K    _pip_completion pip

znap function _python_argcomplete pipx  'eval "$( register-python-argcomplete pipx  )"'
complete -o nospace -o default -o bashdefault \
           -F _python_argcomplete pipx

znap function _pipenv pipenv            'eval "$( pipenv --completion )"'
compdef       _pipenv pipenv
