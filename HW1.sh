echo "Welcome to the game"

guessed=0
missed=0
attempt=1
lastNumbers=""

RED="\e[31m"
GREEN="\e[32m"
RESET="\e[m"

while true
do

printf "\n\nYour attempt is ${attempt}\n"
read -p "Please enter number from 0 to 9 (q - quit): " input
random=${RANDOM:0:1}
case "${input}" in
    [0-9])
    ;;
    q)
        echo "Bye"
        echo "Exit..."
        break
    ;;
    *)
        echo "Not valid input"
        echo "Please repeat"
        continue
    ;;
esac

if [[ "${random}" == "${input}" ]]; then
  printf "Congrats! You guessed! It was ${GREEN}${random}${RESET}";
  ((guessed++))
  formattedString="${GREEN}${random}${RESET}"
else
    printf "Oops. My number was ${GREEN}${random}${RESET} and you said ${RED}${input}${RESET}"
    ((missed++))
    formattedString="${RED}${input}${RESET}"
fi
lastNumbers="${lastNumbers}${formattedString} "
arr=($lastNumbers)

let guessedPercent=guessed*100/attempt
let missedPercent=100-guessedPercent

printf "\n ${GREEN}${guessedPercent}%%${RESET} guessed ${RED}${missedPercent}%%${RESET} missed"

if ((attempt < 10)); then
    printf "\n ${arr[*]}"
else
    printf "\n ${arr[*]: -10}"
fi

((attempt++))
 
done
