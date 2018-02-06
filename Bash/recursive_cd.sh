#  Copy in your .bashrc
#  This command `rcd` remplace this `cd ..`
#  When you need move to two upper folder.
#  You can use `cd ..` and repeat `cd ..`
#  Or use `rcd 2`
#  `rcd` equal to `cd ..`
#  `rcd 3` equal to use `cd .. cd .. cd ..` 
rcd(){
    builtin cd ..
    NUM=${@:-1}
    if [ $NUM -gt 1 ]
    then
        COUNT=$NUM
        let "COUNT--"
        rcd $COUNT
    fi
}

alias rcd="rcd"
