#!/bin/bash
set -x
users=( vm56  )
passwd="P0ssW0rd!"
E_USEREXISTS=70

# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi

# Create User, password change at first login and sudo access
for user in "${users[@]}"
do
        # Check if user already exists.
        grep -q $user /etc/passwd
        if [ $? -eq 0 ]
        then
                echo "User $user does already exist."
                echo "please chose another username."
                exit $E_USEREXISTS
        fi

        useradd -p $passwd -d /home/$user -m -g users -s /bin/bash $user
        chage -d 0 $user
        # passwd --expire $user
        # echo "$user  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
        echo "the account is setup"
done
exit 0
