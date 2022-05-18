#!/usr/bin/bash

sym=('-' '\' '|' '/')
spinner() {

    while true;do
        for c in "${sym[@]}";do
            echo -en "\r $c "
            sleep .5
            clear
        done
        break
    done
}

encrypter() {
    
     echo""
     echo "Enter the File's Name"
     read -r file
     if [ -f $file ];then
         gpg -e $file
     else
         echo "$file Doesn't exist"
         echo "Do you want to continue"
         read -r ans 
         if [ $ans == 'y' ];then
              main
         else
              exit 1
         fi

     fi
}

decrypter() {
      echo ""
      echo "Enter the File's Name"
      read -r file
      if [ -f $file ];then
           gpg -d $file
      else
           echo "$file Doesn't exist"

           echo "Do you want to continue"
           read -r ans
           if [ $ans == 'y' ];then
                main
           else
               exit 1
           fi
      fi   
}


main(){

cat << EOF

What would you like to do King *Mani*?

1.Generate Keys
2.Encrypt File
3.Decrypt File
4.Your Pub Key
5.Your Private Key
6.Quite

EOF

read -r sel

spinner
echo ""
echo ""

if [ $sel == 1 ];
then
cat << EOF
1.Enter the 1 as default type
2.skip choosing lenght of the key (optional)
3.Days of key expire
4.Enter your identity and passphrase
5.getting revocation certificate (for the case that private key is known by other)


EOF
gpg --full-generate-key

elif [ $sel == 2 ];then
echo""
encrypter

elif [ $sel == 3 ];then
echo""
decrypter       


elif [ $sel == 4 ];then
echo""
gpg --list-keys

elif [ $sel == 5 ];then
    if [ $UID != 0 ];then
        echo "You are not sudo"
        main
        echo ""
    else
        echo""
        gpg --list-secret-keys
    fi

elif [ $sel == 6 ];then
    echo "Good Luck"
    exit 1

else
    echo "Unsuall Input"
    main

fi
}

main
