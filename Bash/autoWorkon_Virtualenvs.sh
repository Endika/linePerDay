#  Copy in your .bashrc
#  When you use the `cd` command,
#  look for the corresponding virtualenvs and auto workon
export WORKON_HOME=$HOME/.virtualenvs

cd_venv(){
   builtin cd "$@"
   if [ -e .venv ]; then
    . .venv
   else
    SEARCHING_VENV=$(basename "$PWD")
    DEST_VENV=$WORKON_HOME/$SEARCHING_VENV
    if [ -e "$DEST_VENV" ]; then
         workon "$SEARCHING_VENV"
    fi
   fi
}
alias cd="cd_venv"
