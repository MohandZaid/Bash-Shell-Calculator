#!/bin/bash

#Input Validation 
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

#Reading Input from User
function read_input(){
    num=`whiptail --inputbox "$1 Number" 8 20 \
    --title "$2" 3>&1 1>&2 2>&3`

    echo "$num"
    }


#Standard Calculator
#CALLING : Standard_Calc {+ - * / **} {ADD SUB MUL DIV EXP}
#EX : Standard_Calc "*" "MUL"

function Standard_Calc(){

    num1=`read_input "First" "$2"` && check_valid "dec" "$num1" \
    && num2=`read_input "Second" "$2"` && check_valid "dec" "$num2" 

    [[ "$2" -eq "DIV" || "$2" -eq "SUB" ]] && [[ "$num2" -gt "$num1" ]]\
    &&whiptail --title "$2 Error"\
    --msgbox "  Second Number Greater Than First" 8 40 \
    && return 1

    [[ "$?" -eq "0" ]] && res=$[$num1$1$num2]\
    &&whiptail --title "Result" --msgbox "$res" 8 40

    }


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