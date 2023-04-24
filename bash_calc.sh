#!/bin/bash

#Input Validation 
#CALLING : check_valid {Type} {Input}
#EX : check_valid "Oct" "4"
#       |-->> return 0  (True)
#EX : check_valid "Bin" "7"
#       |-->> return 1  (False)
function check_valid(){

    [[ -z "$2" ]] && whiptail --title "Error" --msgbox "Empty Input" 8 40 \
    && return 1

    case "$1" in
        "Dec") [[ "$2" =~ ^[0-9]+?$ ]] && return 0  ;;
        "Bin") [[ "$2" =~ ^[0-1]+?$ ]] && return 0  ;;
        "Oct") [[ "$2" =~ ^[0-7]+?$ ]] && return 0  ;;
        "Hex") [[ "$2" =~ ^[0-9A-Fa-f]+$ ]] && return 0 ;;
    esac
    whiptail --title "Error" --msgbox "Invalid Input" 8 40 \
    && return 1
    }


#Reading Input from User
#CALLING : read_input {Number Descriptor} {Operation Descriptor}
#EX : read_input "Bin" "CONVERTER"
#       |-->> whiptail --inputbox "Bin Number" 8 20\
#               --title "CONVERTER" 3>&1 1>&2 2>&3`
function read_input(){
    local num=`whiptail --inputbox "$1 Number" 8 25 \
    --title "$2" 3>&1 1>&2 2>&3`

    echo "$num"
    }


#Standard Calculator
#CALLING : Standard_Calc {+ - * / **} {ADD SUB MUL DIV EXP}
#EX : Standard_Calc "*" "MUL"
function Standard_Calc(){

    local num1=`read_input "First" "$2"` && check_valid "Dec" "$num1" \
    && local num2=`read_input "Second" "$2"` && check_valid "Dec" "$num2" 

    [[ "$2" -eq "DIV" || "$2" -eq "SUB" ]] && [[ "$num2" -gt "$num1" ]]\
    &&whiptail --title "$2 Error"\
    --msgbox "  Second Number Greater Than First" 8 40 \
    && return 1

    [[ "$?" -eq "0" ]] && local res=$[$num1$1$num2]\
    &&whiptail --title "Result" --msgbox "$res" 8 40

    }


#Programmer Calculator
#CALLING : Programmer_Calc {from: Bin Dec Oct Hex}
#EX : Programmer_Calc dec
#       |-->> Convert from DEC to BIN,OCT,HEX
function Programmer_Calc(){

    local num=`read_input "$1" "CONVERTER"`

    check_valid "$1" "$num"
    [[ $? -ne "0" ]] && return 1

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