#!/bin/bash

###############
#Core Functions

#Input Validation 
#CALLING : check_valid {Type} {Input}
#EX : check_valid "Oct" "4"
#       |-->> return 0  (True)
#EX : check_valid "Bin" "7"
#       |-->> return 11 (empty input) | return 12 (invalid input) ->(False)
function check_valid(){

    [[ -z "$2" ]] && whiptail --title "Error" --msgbox "Empty Input" 8 40 \
    && return 11

    case "$1" in
        "Dec") [[ "$2" =~ ^[\-0-9]+?$ ]] && return  ;;
        "Bin") [[ "$2" =~ ^[0-1]+?$ ]] && return    ;;
        "Oct") [[ "$2" =~ ^[0-7]+?$ ]] && return    ;;
        "Hex") [[ "$2" =~ ^[0-9A-Fa-f]+$ ]] && return   ;;
    esac
    whiptail --title "Error" --msgbox "Invalid Input" 8 40 \
    && return 12
    }


#Reading Input from User
#CALLING : read_input {Number Descriptor} {Operation Descriptor}
#EX : read_input "Bin" "CONVERTER"
#       |-->> whiptail --inputbox "Bin Number" 8 20\
#               --title "CONVERTER" 3>&1 1>&2 2>&3`
function read_input(){
    local num=`whiptail --inputbox "$1" 8 25 \
    --title "$2" 3>&1 1>&2 2>&3`

    echo "$num"
    }


#Standard Calculator
#CALLING : Standard_Calc {+ - * / **} {ADD SUB MUL DIV EXP}
#EX : Standard_Calc "*" "MUL"
function Standard_Calc(){

    local num1=`read_input "First Number" "$2"` && check_valid "Dec" "$num1" \
    && local num2=`read_input "Second Number" "$2"` && check_valid "Dec" "$num2" 

    [[ "$?" -ne "0" ]] && return 21

    local res=$[$num1$1$num2]\
    &&whiptail --title "Result" --msgbox " $res" 8 40

    }


#Programmer Calculator
#CALLING : Programmer_Calc {from: Bin Dec Oct Hex}
#EX : Programmer_Calc dec
#       |-->> Convert from DEC to BIN,OCT,HEX
function Programmer_Calc(){

    local num=`read_input "$1 Number" "CONVERTER"`

    check_valid "$1" "$num"
    [[ "$?" -ne "0" ]] && return 31

    local decimal_num=""
    local binary_num=""
    local hex_num=""
    local octal_num=""

    case "$1" in
        "Bin")
            decimal_num=$((2#"$num"))
            hex_num=$(echo "obase=16;$decimal_num" | bc)
            octal_num=$(echo "obase=8;$decimal_num" | bc)

            binary_num="$num"

            ;;
        "Dec")
            binary_num=$(echo "obase=2;$num" | bc)
            hex_num=$(echo "obase=16;$num" | bc)
            octal_num=$(echo "obase=8;$num" | bc)

            decimal_num="$num"

           ;;
        "Hex")
            decimal_num=$((16#"$num"))
            binary_num=$(echo "obase=2;$decimal_num" | bc)
            octal_num=$(echo "obase=8;$decimal_num" | bc)

            hex_num="$num"

            ;;
        "Oct")
            decimal_num=$((8#"$num"))
            binary_num=$(echo "obase=2;$decimal_num" | bc)
            hex_num=$(echo "obase=16;$decimal_num" | bc)

            octal_num="$num"

    esac

        whiptail --title "CONVERTION"\
        --msgbox "     BIN:$binary_num\
        DEC:$decimal_num\
        HEX:$hex_num\
        OCT:$octal_num" 8 60
    }


#Scientific Calculator
#CALLING : Scientific_Calc {Operator} {Operation Description}
#EX : Scientific_Calc "<<" "LShift" 
function Scientific_Calc(){

    case "$2" in

        "LShift" | "RShift" )

        local num1=`read_input "Number" "$2"` && check_valid "Dec" "$num1" \
        && local num2=`read_input "Shift" "$2"` && check_valid "Dec" "$num2" 

        [[ "$num2" -lt "0" ]] \
        &&whiptail --title "Error" --msgbox "Result not defined" 8 40 \
        &&return 41

        local res=$[ $num1$1$num2 ] \
        &&whiptail --title "Result" --msgbox " $res" 8 40
        ;;

        "NOT" )

        local num1=`read_input "Number" "$2"` && check_valid "Dec" "$num1"

        local res=$[~$num1] \
        &&whiptail --title "Result" --msgbox " $res" 8 40 
        ;;

        "AND" | "OR" | "XOR" )

        local num1=`read_input "First Number" "$2"` && check_valid "Dec" "$num1" \
        && local num2=`read_input "Second Number" "$2"` && check_valid "Dec" "$num2" 

        local res=$[ $num1$1$num2 ] \
        &&whiptail --title "Result" --msgbox " $res" 8 40
    
    esac
    }


###############
#Calculation Functions' Menus
function standard_calc_menu(){

    local CALC=`whiptail --title "Standard Calculator"\
    --menu "Choose an option" 25 50 15 \
    "1" "ADD"\
    "2" "SUB"\
    "3" "MUL"\
    "4" "DIV"\
    "5" "EXP"\
    3>&1 1>&2 2>&3` 

    case "$CALC" in 

        "1") Standard_Calc "+" "ADD"    ;;
        "2") Standard_Calc "-" "SUB"    ;;
        "3") Standard_Calc "*" "MUL"    ;;
        "4") Standard_Calc "/" "DIV"    ;;
        "5") Standard_Calc "**" "EXP"   ;;

    esac
    }

function programmer_calc_menu(){

    local CALC=`whiptail --title "Programmer Calculator"\
    --menu "Choose an option" 25 50 15 \
    "1" "BIN"\
    "2" "DEC"\
    "3" "HEX"\
    "4" "OCT"\
    3>&1 1>&2 2>&3` 

    case "$CALC" in 

        "1") Programmer_Calc "Bin"    ;;
        "2") Programmer_Calc "Dec"    ;;
        "3") Programmer_Calc "Hex"    ;;
        "4") Programmer_Calc "Oct"    ;;

    esac
    }

function scientific_calc_menu(){

    local CALC=`whiptail --title "Scientific Calculator"\
    --menu "Choose an option" 25 50 15 \
    "1" "LShift" \
    "2" "RShift" \
    "3" "AND" \
    "4" "OR" \
    "5" "XOR" \
    "6" "NOT" 3>&1 1>&2 2>&3`

    case "$CALC" in 

        "1") Scientific_Calc "<<" "LShift"  ;;
        "2") Scientific_Calc ">>" "RShift"  ;;
        "3") Scientific_Calc "&" "AND"  ;;
        "4") Scientific_Calc "|" "OR"   ;;
        "5") Scientific_Calc "^" "XOR"  ;;
        "6") Scientific_Calc "~" "NOT"  ;;

    esac
    }

#Calculator Menu (just menu)
function CALC_MENU(){
    local CALC=`whiptail --title "Calculator"\
    --menu "Choose an option" 25 50 15 \
    "1" "Standard"\
    "2" "Programmer"\
    "3" "Scientific" 3>&1 1>&2 2>&3` 

    case "$CALC" in 

        "1") standard_calc_menu      ;;
        "2") programmer_calc_menu    ;;
        "3") scientific_calc_menu    ;;

    esac
    }

#Documentation
function DOC(){
    whiptail --title "Example Dialog"\
    --msgbox "Test" 8 78

    }

#Main Menu
function MAIN(){

        local CALC=`whiptail --title "Calculator"\
        --menu "Choose an option" 25 50 15 \
        "1" "Calculator"\
        "2" "Documentation"\
        "3" "Exit" 3>&1 1>&2 2>&3` 

        case "$CALC" in 

            "1") CALC_MENU  ;;
            "2") programmer_calc_menu    ;;
            "3") exit       ;;

        esac
    }

MAIN