#!/bin/sh


readonly ADDRESSBOOK=./addressbook

readonly CMD_SEARCH=search
readonly CMD_ADD=add
readonly CMD_REMOVE=remove
readonly CMD_EDIT=edit
readonly CMD_EXIT=exit

readonly ERR_MISSING_FILE=1
readonly ERR_MISSING_ENTRY=2
readonly ERR_TOO_MANY_ENTRIES=3
readonly ERR_OPERATION_FAILED=4


. ./libaddrbook.sh


search() {
    entries=$(cat $ADDRESSBOOK)

    while [ $# -gt 0 ]; do
        entries=$(echo "$entries" | grep $1)

        [ -n "$entries" ] || break 

        shift
    done

    echo "$entries"
}

add() {
    new_entry=$(make_entry $@)
    
    [ $? -eq 0 ] || return $ERR_OPERATION_FAILED

    grep $new_entry $ADDRESSBOOK > /dev/null
    
    if [ $? -eq 0 ]; then
        echo "Entry '$new_entry' already exists"
        yes_no "Edit existing entry?" && edit $@
    else
        yes_no "Add '$new_entry'?" && echo "$new_entry" >> $ADDRESSBOOK
    fi 
}

remove() {
    entries=$(search $@)

    for entry in $entries; do
        yes_no "Remove '$entry'?" && remove_entry $entry $ADDRESSBOOK
    done
}

edit() {
    entries=$(search $@)

    [ -n "$entries" ] || return $ERR_MISSING_ENTRY

    entries_num=$(echo "$entries" | wc -l)

    if [ $entries_num -gt 1 ]; then
        echo "$entries"
        return $ERR_TOO_MANY_ENTRIES
    fi

    entry=$entries
    name=$(parse_name $entry)
    surname=$(parse_surname $entry)
    phone=$(parse_phone $entry)
    email=$(parse_email $entry)

    read -p "Name [$name]: " new_name
    read -p "Surname [$surname]: " new_surname
    read -p "Phone [$phone]: " new_phone
    read -p "Email [$email]: " new_email
    
    new_entry=$(make_entry \
        ${new_name:=$name} \
        ${new_surname:=$surname} \
        ${new_phone:=$phone} \
        ${new_email:=$email})

    if [ "$new_entry" = "$entry" ]; then
        echo "Entry was not changed"
        return 0
    fi

    yes_no "Change '$entry' to '$new_entry'?" \
        && remove_entry $entry $ADDRESSBOOK; echo $new_entry >> $ADDRESSBOOK
}

show_commands() {
    echo "Supported commands: \
$CMD_SEARCH, \
$CMD_ADD, \
$CMD_REMOVE, \
$CMD_EDIT, \
$CMD_EXIT"
}


[ -f $ADDRESSBOOK ] || touch $ADDRESSBOOK

while : ; do
    read -p "addressbook> " cmd args
    case $cmd in
        $CMD_SEARCH)
            search $args
            ;;
        $CMD_ADD)
            add $args
            ;;
        $CMD_REMOVE)
            remove $args
            ;;
        $CMD_EDIT)
            edit $args
            ;;
        $CMD_EXIT)
            exit 0
            ;;
        *)
            show_commands
            ;;
    esac
done
