#!/bin/bash

function check_valid(){

    [[ -z "$2" ]] && whiptail --title "Error" --msgbox "Empty Input" 8 40 \
    && return 1

    case $1 in
        "dec") [[ "$2" =~ ^[0-9]+?$ ]] && return 0  ;;
        "bin") [[ "$2" =~ ^[0-1]+?$ ]] && return 0  ;;
        "oct") [[ "$2" =~ ^[0-7]+?$ ]] && return 0  ;;
        "hex") [[ "$2" =~ ^[0-9A-Fa-f]+$ ]] && return 0 ;;
    esac
    whiptail --title "Error" --msgbox "Invalid Input" 8 40 \
    && return 1
    }


#CORE FUNCTIONS
###############
#Standard Calculator

# function ADD(){}
# function SUB(){}
# function MUL(){}
# function DIV(){}
# function EXP(){}

###############
#Programmer Calculator

# function BIN(){}
# function DEC(){}
# function OCT(){}
# function HEX(){}

###############
#Scientific Calculator

# function RShift(){}
# function LShift(){}
# function AND(){}
# function OR(){}
# function XOR(){}
# function NOT(){}


###############
#Calculation Functions' Menus
# function standard_calc_menu(){}
# function programmer_calc_menu(){}
# function scientific_calc_menu(){}

#Calculator Menu (just menu)
# function CALC_MENU(){}

#Documentation and Team Members
# function DOC(){}

#Main Menu
# function MAIN(){}