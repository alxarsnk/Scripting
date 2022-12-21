attemps=1

drawGrid(){
    clear
    echo "Current attemp is: ${attemps}"
    D="-----------------"
    S="%s\n|%3s|%3s|%3s|%3s|\n"
    printf $S $D ${M[0]:-"."} ${M[1]:-"."} ${M[2]:-"."} ${M[3]:-"."}
    printf $S $D ${M[4]:-"."} ${M[5]:-"."} ${M[6]:-"."} ${M[7]:-"."}
    printf $S $D ${M[8]:-"."} ${M[9]:-"."} ${M[10]:-"."} ${M[11]:-"."}
    printf $S $D ${M[12]:-"."} ${M[13]:-"."} ${M[14]:-"."} ${M[15]:-"."}
    echo $D
}

initGame(){
    M=()
    EMPTY=
    RANDOM=$RANDOM
    for i in {1..15}
    do
        j=$(( RANDOM % 16 ))
        while [[ ${M[j]} != "" ]]
        do
            j=$(( RANDOM % 16 ))
        done
        M[j]=$i
    done
    for i in {0..15}
    do
        [[ ${M[i]} == "" ]] && EMPTY=$i
    done
    drawGrid
}

swap(){
    M[$EMPTY]=${M[$1]}
    M[$1]=""
    EMPTY=$1
}

isFinished(){
    for i in {0..14}
    do
        if [ "${M[i]}" != "$(( $i + 1 ))" ]
        then
            return
        fi
    done
    echo "You winished game with ${attemps} attemps"
    drawGrid
}

startGame(){
while :
do
    echo "Use w (up) ,a (left),s (down),d (right) to move, q for quit"
    read -n 1 -s
    case $REPLY in
        w)
            if [ $EMPTY -lt 12 ]
             then
                [ $EMPTY -lt 12 ] && swap $(( $EMPTY + 4 ))
                ((attemps++))
                drawGrid
            else
                drawGrid
                echo "Wrong move, mate"
            fi
        ;;
        a)
            COL=$(( $EMPTY % 4 ))
            if [ $COL -lt 3 ]
            then
                [ $COL -lt 3 ] && swap $(( $EMPTY + 1 ))
                ((attemps++))
                drawGrid
            else
                drawGrid
                echo "Wrong move, mate"
            fi
        ;;
        s)
            if [ $EMPTY -gt 3 ]
            then
                [ $EMPTY -gt 3 ] && swap $(( $EMPTY - 4 ))
                ((attemps++))
                drawGrid
            else
                drawGrid
                echo "Wrong move, mate"
            fi
        ;;
        d)
            COL=$(( $EMPTY % 4 ))
            if [ $COL -gt 0 ]
            then
                [ $COL -gt 0 ] && swap $(( $EMPTY - 1 ))
                ((attemps++))
                drawGrid
            else
                drawGrid
                echo "Wrong move, mate"
            fi
        ;;
        q)
            exit
        ;;
        *)
            drawGrid
            echo "Wrong move, mate"
        ;;
    esac
    isFinished
done
}

initGame
startGame
