#!/bin/bash


function ctrl_c(){
  echo -e "\n\n${redColour}[!] Leaving....${endColour}\n"
  tput cnorm; exit 1
}

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Ctrl C
trap ctrl_c INT

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} User panel:${endColour}${greenColour} $0${endColour}\n"
  echo -e "\t${blueColour}-m)${endColour}${grayColour} Betting money${endColour}"
  echo -e "\t${blueColour}-t)${endCOlour}${grayColour} Techinique${endColour}"
  echo -e "\t\t${grayColour}- Martingala${endColour} "
  echo -e "\t\t${grayColour}- InverseLabrouchere${endColour}"
  echo -e "\t${blueColour}-h)${endColour}${grayColour} Help${endColour}"
  echo -e "\n\t${yellowColour}[+]${endColour}${grayColour} Use example: ./ruleta.sh -m 1000 -t martingala${endColour}"
}

function martingala(){  
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Currently money:${endColour}${greenColour} $money$ ${endColour}\n"
  echo -n -e "${yellowColour}[!]${endColour}${grayColour} How much will be your bet:${endColour}  " && read initial_bet
  echo -n -e "${yellowColour}[+]${endColour}${grayColour} What is your choose (Par/Impar)?:${endColour}  " && read par_impar

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} We are gonna bet${endColour} ${greenColour}$initial_bet${endColour} to ${greenColour}$par_impar${endColour}"
  backup_bet=$initial_bet 
  playcounter=1
  badplays="[ "
  badplays_number=0
  current=$money
  goodplays=0
  plays=0
  tput civis

  while true; do
    money=$(($money - $initial_bet))
#    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Acabas de apostar${endColour}${greenColour} $initial_bet$ ${endColour}${grayColour} y tienes${endColour}${yellowColour} $money$ ${endColour}"
#    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Ha salido numero${endColour}${greenColour} $random_number${endColour}"
    random_number="$(($RANDOM % 37))"

      if [ "$par_impar" == "par" ]; then
       if [ $(($random_number % 2 )) -eq 0 ]; then
          if [ "$random_number" -eq 0 ]; then
#            echo -e "${redColour}[!] el numero es 0, PIERDES${endColour}"
            initial_bet=$(($initial_bet * 2))
            badplays+="$random_number "
            let badplays_number+=1
            plays=""
          else
 #           echo -e "${yellowColour}[!]${endColour}${grayColour} el numero es${endColour}${blueColour} par${endColour}, ${greenColour}GANAS!${endColour}"
            reward=$(($initial_bet * 2))
 #           echo -e "${yellowColour}[+]${endColour}${grayColour} Ganas un total de${endColour}${greenColour} $reward$ ${endColour}"
            money=$(($money + $reward))
 #           echo -e "${yellowColour}[+]${endColour}${grayColour} Tu dinero total es${endColour}${yellowColour} $money$ ${endColour}"
            initial_bet=$backup_bet        
            badplays=""
            let badplays_number=0
            if [ $money -gt $current ]; then
              current=$money
            fi  
            let plays+=1
            if [ $plays -gt $goodplays ]; then
              goodplays=$plays
            fi 
          fi 
        else 
  #        echo -e "${redColour}[!] el numero es impar, PIERDES${endColour}"
  #        echo -e "${yellowColour}[+]${endColour}${grayColour} Tu dinero total es${endColour}${yellowColour} $money$ ${endColour}"
          initial_bet=$(($initial_bet * 2))
          badplays+="$random_number "
          let badplays_number+=1
          plays=""

          if [ $money -le 0 ]; then
            echo -e "\n${redColour}[!] You lost all your money${endColour}"
            echo -e "${yellowColour}[!]${endColour}${grayColour} han habido un total de${endColour}${greenColour} $playcounter${endColour}${grayColour} jugadas${endColour}"
            echo -e "\n${yellowColour}[+]${endColour}${grayColour} Malas jugadas consecutivas${endColour} ${yellowColour}$badplays_number:${endColour}\n"
            echo -e "${blueColour}$badplays ${endColour}\n"
            echo -e "${yellowColour}[+]${endColour}${grayColour} Tuviste un total de${endColour}${greenColour} $goodplays ${endColour}${grayColour}buenas jugadas consecutivas${endColour}"
            echo -e "\n${yellowColour}[+]${endColour}${grayColour} tu maximo tope ganado fue de:${endColour}${greenColour} $current ${endColour}\n\n"
            tput cnorm
            exit
          fi
        fi
      elif  [ "$par_impar" == "impar" ]; then
        if [ $(($random_number % 2 )) != 0 ]; then
 #          echo -e "${yellowColour}[!]${endColour}${grayColour} el numero es${endColour}${blueColour} impar${endColour}, ${greenColour}GANAS!${endColour}"
            reward=$(($initial_bet * 2))
 #          echo -e "${yellowColour}[+]${endColour}${grayColour} Ganas un total de${endColour}${greenColour} $reward$ ${endColour}"
            money=$(($money + $reward))
 #          echo -e "${yellowColour}[+]${endColour}${grayColour} Tu dinero total es${endColour}${yellowColour} $money$ ${endColour}"
            initial_bet=$backup_bet        
            badplays=""
            let badplays_number=0
            if [ $money > $current ]; then
              current=$money
            fi  
            let plays+=1
            if [ $plays -gt $goodplays ]; then
              goodplays=$plays   
            fi  
        else 
 #         echo -e "${redColour}[!] el numero es par, PIERDES${endColour}"
 #         echo -e "${yellowColour}[+]${endColour}${grayColour} Tu dinero total es${endColour}${yellowColour} $money$ ${endColour}"
          initial_bet=$(($initial_bet * 2))
          badplays+="$random_number "
          let badplays_number+=1
          plays=""

          if [ $money -le 0 ]; then
            echo -e "\n${redColour}[!] You lost all your money${endColour}"
            echo -e "${yellowColour}[!]${endColour}${grayColour} han habido un total de${endColour}${greenColour} $playcounter${endColour}${grayColour} jugadas${endColour}"
            echo -e "\n${yellowColour}[+]${endColour}${grayColour} Malas jugadas consecutivas${endColour} ${yellowColour}$badplays_number:${endColour}\n"
            echo -e "${blueColour}$badplays ${endColour}"
            echo -e "\n${yellowColour}[+]${endColour}${grayColour} Tuviste un total de${endColour}${greenColour} $goodplays ${endColour}${grayColour}buenas jugadas consecutivas${endColour}"
            echo -e "\n${yellowColour}[+]${endColour}${grayColour} Tu maximo tope ganado fue de:${endColour}${greenColour} $current ${endColour}\n\n"
            tput cnorm
            exit
          fi 
        fi 
      fi  
      let playcounter+=1
  done 

  tput cnorm


}


function inverseLabrouchere(){
  
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Currently money:${endColour}${greenColour} $money$ ${endColour}\n"
  echo -n -e "${yellowColour}[+]${endColour}${grayColour} What is your choose (Par/Impar)?:${endColour}  " && read par_impar

  declare -a my_sequence=(1 2 3 4)

 # echo -e "\n${yellowColour}[+]${endColour}${grayColour} Secuency start${endColour}${greenColour} ${my_sequence[@]} ${endColour}"

  bet=$((${my_sequence[0]}+${my_sequence[-1]}))
  winnings=0
  backup_money=$money
  jugadas_totales=0
  max_money=0

  while true; do
    tput civis
    random_number="$(($RANDOM % 37))"
    money=$(($money-$bet))
    let jugadas_totales+=1

    if [ $money -ge 0 ]; then

 #    echo -e "${yellowColour}[!]${endColour}${grayColour} Vas a invertir:${endColour}${greenColour} $bet$ ${endColour}"
 #    echo -e "${yellowColour}[+]${endColour}${grayColour} Nos queda:${endColour}${greenColour} $money$ ${endColour}${grayColour}dolares${endColour}"
 #    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Ha salido el numero:${endColour}${blueColour} $random_number${endColour}"

     if [ "$par_impar" == "par" ]; then

       if [ "$(($random_number % 2))" -eq 0 ]; then

            if [ "$random_number" -eq 0 ]; then
  #           echo -e "${redColour}[!] Numero 0, Pierdes${endColour}"
             unset my_sequence[0]
             unset my_sequence[-1] 2>/dev/null
             my_sequence=(${my_sequence[@]})
             if [ $winnings -gt 0 ]; then
                let winnings-=$bet
             fi   

              if [ ${#my_sequence[@]} -eq 1 ]; then
                bet=${my_sequence[@]} 
  #              echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es la siguiente:${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
              elif [ ${#my_sequence[@]} -lt 1 ]; then
  #              echo -e "${yellowColour}[+]${endColour}${grayColour} Perdiste la secuencia actual${endColour}"
  #              echo -e "${redColour}[!] Reiniciamos secuencia.... ${endColour}"
                my_sequence=(1 2 3 4)
  #              echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es la siguiente:${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
                bet=$((${my_sequence[0]}+${my_sequence[-1]}))
              else
                bet=$((${my_sequence[0]}+${my_sequence[-1]}))
  #              echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es la siguiente:${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
              fi  

            else  
   #           echo -e "${greenColour}[+] Numero par, Ganas!!${endColour}"
              reward=$(($bet * 2))
              let winnings+=$bet
              let money+=$reward
   #           echo -e "${yellowColour}[+]${endColour}${grayColour} Tu dinero actual es de:${endColour}${greenColour} $money$ ${endColour}"

              if [ $money -gt $max_money ]; then
                max_money=$money
              fi  

              if [ $winnings -ge 50 ]; then
                my_sequence=(1 2 3 4)
                winnings=0
  #              echo -e "${yellowColour}[+]${endColour}${greenColour} Ganaste mas de 50$, La secuencia se reinicia${endColour}"
              else  
                my_sequence+=($bet)
                my_sequence=(${my_sequence[@]})
              fi  
  #            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
              bet=$((${my_sequence[0]}+${my_sequence[-1]}))
            fi  
        else
  #        echo -e "${redColour}[!] Numero impar, Pierdes${endColour}"
          
          unset my_sequence[0]
          unset my_sequence[-1] 2>/dev/null

          my_sequence=(${my_sequence[@]})
          if [ $winnings -gt 0 ]; then
            let winnings-=$bet
          fi
          if [ ${#my_sequence[@]} -eq 1 ]; then
              bet=${my_sequence[@]} 
  #            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es la siguiente:${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
          elif [ ${#my_sequence[@]} -lt 1 ]; then
  #            echo -e "${yellowColour}[+]${endColour}${grayColour} Perdiste la secuencia actual${endColour}"
  #            echo -e "${redColour}[!] Reiniciamos secuencia.... ${endColour}"
              my_sequence=(1 2 3 4)  
              bet=$((${my_sequence[0]}+${my_sequence[-1]}))
  #            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es la siguiente:${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
          else
              bet=$((${my_sequence[0]}+${my_sequence[-1]}))
  #            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es la siguiente:${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
          fi
       fi  

      elif [ "$par_impar" == 'impar' ]; then

       if [ "$(($random_number % 2))" != 0 ]; then
        
   #           echo -e "${greenColour}[+] Numero impar, Ganas!!${endColour}"
              reward=$(($bet * 2))
              let winnings+=$bet
              let money+=$reward
   #           echo -e "${yellowColour}[+]${endColour}${grayColour} Tu dinero actual es de:${endColour}${greenColour} $money$ ${endColour}"

              if [ $money -gt $max_money ]; then
                  max_money=$money
              fi 


              if [ $winnings -ge 50 ]; then
                my_sequence=(1 2 3 4)
                winnings=0
   #             echo -e "${yellowColour}[+]${endColour}${greenColour} Ganaste mas de 50$, La secuencia se reinicia${endColour}"
              else  
                my_sequence+=($bet)
                my_sequence=(${my_sequence[@]})
              fi  
   #           echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
              bet=$((${my_sequence[0]}+${my_sequence[-1]}))
          
       else
      
    #        echo -e "${redColour}[!] Numero par, Pierdes${endColour}"
          
            unset my_sequence[0]
            unset my_sequence[-1] 2>/dev/null

            my_sequence=(${my_sequence[@]})
            if [ $winnings -gt 0 ]; then
              let winnings-=$bet
            fi
            if [ ${#my_sequence[@]} -eq 1 ]; then
               bet=${my_sequence[@]} 
    #            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es la siguiente:${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
            elif [ ${#my_sequence[@]} -lt 1 ]; then
    #            echo -e "${yellowColour}[+]${endColour}${grayColour} Perdiste la secuencia actual${endColour}"
    #           echo -e "${redColour}[!] Reiniciamos secuencia.... ${endColour}"
               my_sequence=(1 2 3 4)  
               bet=$((${my_sequence[0]}+${my_sequence[-1]}))
    #           echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es la siguiente:${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
            else
               bet=$((${my_sequence[0]}+${my_sequence[-1]}))
    #           echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es la siguiente:${endColour}${greenColour} ${my_sequence[@]} ${endColour}"
          fi
        fi  
      fi  
          
      

    else    
        echo -e "${redColour}\n[!] Te has quedado sin dinero${endColour}"
        echo -e "${yellowColour}\n[+]${endColour}${grayColour} Haz jugado un total de${endColour}${blueColour} $jugadas_totales ${endColour}${grayColour}jugadas.${endColour}"
        echo -e "${yellowColour}[+]${endColour}${grayColour} Tu maximo tope de dinero fue:${endColour}${greenColour} $max_money$ ${endColour}"
        tput cnorm
        exit 1
     
    fi
  done 
  tput cnorm


}


while getopts "m:t:h" arg; do 
  case $arg in
    m) money="$OPTARG";;
    t) tecnique="$OPTARG";;
    h) ;;
  esac
done

if [ "$money" ] && [ "$tecnique" ]; then
  if [ "$tecnique" == "martingala" ]; then
    martingala
  elif [ "$tecnique" == "inverseLabrouchere" ]; then
    inverseLabrouchere
  else
    echo -e "\n${redColour}[!] Technique not found!${endColour}"
    helpPanel
  fi 
else 
  helpPanel
fi  
