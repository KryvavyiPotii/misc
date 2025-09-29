readonly DELIM=:
readonly ERR_WRONG_ARGUMENTS=64


make_entry() {
    [ $# -eq 4 ] || return $ERR_WRONG_ARGUMENTS
    
    echo "$1$DELIM$2$DELIM$3$DELIM$4"
}

remove_entry() {
    [ $# -eq 2 ] || return $ERR_WRONG_ARGUMENTS

    sed -i "/$1/d" "$2" 
}

parse_name() {
    [ $# -eq 1 ] || return $ERR_WRONG_ARGUMENTS

    echo $1 | cut -d "$DELIM" -f 1
}

parse_surname() {
    [ $# -eq 1 ] || return $ERR_WRONG_ARGUMENTS

    echo $1 | cut -d "$DELIM" -f 2
}

parse_phone() {
    [ $# -eq 1 ] || return $ERR_WRONG_ARGUMENTS

    echo $1 | cut -d "$DELIM" -f 3
}

parse_email() {
    [ $# -eq 1 ] || return $ERR_WRONG_ARGUMENTS

    echo $1 | cut -d "$DELIM" -f 4
}

# $1 - prompt message without "(y/N)"
yes_no() {
    [ $# -eq 1 ] || return $ERR_WRONG_ARGUMENTS
    
    read -p "$1 (y/N): " answer

    [ "$answer" = "Y" ] || [ "$answer" = "y" ]
}
