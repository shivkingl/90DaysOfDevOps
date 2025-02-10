#!/bin/bash
#Account Deletion
function User_Mangement {
if [[ $1 == '-d' || $1 == '--userdelete' ]];then

read -p "Enter the username for account delete :" username

sameuser=$(cat /etc/passwd |grep $username |wc -l)

if [ $sameuser -eq 1 ]; then
         sudo userdel $username
         echo "User delete successfully "
 else
         echo "User does not exists"
fi



elif [[ $1 == '-l' || $1 == '--list' ]]; then
    (echo -e "Username\tUser ID\tHome Directory"; awk -F ':' '{print $1, $3, $6}' /etc/passwd) | column -t

    elif [[ $1 == '-r' || $1 == '--reset' ]]; then
read -p "Enter the chnage password username : " username
check_user=$(cat /etc/passwd | grep $username| wc -l)
if [ $check_user==1 ];then
        read -sp "Enter new password : " password
        echo -e "$password\n$password" | sudo passwd  $username
else
        echo "User don't exists"
fi
elif [[ $1 == '-c' || $1 == '--create' ]]; then
read -p "Enter the Username :" username
read -sp "Enter new password :" password
sameuserhere=$(cat /etc/passwd |grep $username | wc -l)
if [ $sameuserhere == 1 ];
then
        echo "Username already exists"
exit
else
        sudo useradd -m $username
        echo -e "$password\n$password" | sudo passwd $username
        echo "New user successfully created"
fi

elif [[ $1 == '-h' || $1 == '--help' ]]; then
        echo "User Account Management Script"
        echo "This script allows you to create, delete, list users, and reset user passwords."
        echo "Usage:"
        echo "  -c, --create    Create a new user account."
        echo "  -d, --delete    Delete an existing user account."
        echo "  -r, --reset     Reset the password of an existing user."
        echo "  -l, --list      List all available user accounts."
        echo " -h, --help      Display this help message."
else
        echo "Invalid option : Please enter -h for help for your guidence  "
fi


 }

User_Mangement $1
