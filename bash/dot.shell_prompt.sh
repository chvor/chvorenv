function __xterm_prompt {
    PS1="\\[\\033]0;\\u@\\h \\w\\007\\]$PS1"
}
PROMPT_COMMAND='__xterm_prompt;'
source "$HOME/.shell_promptline.sh"
