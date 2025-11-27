#!/bin/bash
 
# This script will process the creation of user accounts
# Usage: sh script.sh user email action
 
 
NAME=$1
ADDR=$2
TYPE=$3
 
FILE="/etc/apache2/sites-available/user_${NAME}.conf"
 
if [ ! -n "$TYPE" ]; then
	TYPE="appr"
fi
 
function createAccount {
 
	# Gen random pass
	echo -ne "Generating password ....... "
	PASS=`perl /root/new/makepass.pl`
	echo "Done"
 
	# Compute hash
	echo -ne "Creating hash ............. "
	HASH=`perl /root/new/makehash.pl $PASS`
	echo "Done"
 
	# Add group
	echo -ne "Adding group .............. "
	addgroup --force-badname $NAME >> /dev/null
	echo "Done"
 
	# Add user
	echo -ne "Adding user ............... "
	useradd -m -g $NAME -G users -s /bin/bash -p $HASH $NAME
	echo "Done"
 
	# Force password change
	echo -ne "Force password change ..... "
	chage -d 0 $NAME
	echo "Done"
 
	# Make user-www
	NAMEWWW=`echo "${NAME}-www"`
	echo -ne "Creating www user ......... "
	useradd -s /bin/false -g $NAME $NAMEWWW
	echo "Done"
 
	# Create .bash_history
	echo -ne "Creating .bash_history .... "
	touch /home/$NAME/.bash_history
	echo "Done"
 
	# Set home directory rights
	echo -ne "Setting permissions ....... "
	chown -R $NAME:$NAME /home/$NAME
	chmod -R 750 /home/$NAME
	echo "Done"
 
	# Lock .bash_history
	echo -ne "Forcing .bash_history ..... "
	chattr +a /home/$NAME/.bash_history
	echo "Done"
 
	# Add apache config
	echo -ne "Writing apache config ..... "
 
	echo "<VirtualHost *:80>" >> $FILE
	echo "	ServerName	${NAME}.insomnia247.nl" >> $FILE
	echo "	ServerAlias	www.${NAME}.insomnia247.nl" >> $FILE
	echo "" >> $FILE
	echo "	DocumentRoot	/home/${NAME}/public_html/" >> $FILE
	echo "" >> $FILE
	echo "	<Directory /home/${NAME}/public_html>" >> $FILE
	echo "		AllowOverride All" >> $FILE
	echo "		Options MultiViews Indexes SymLinksIfOwnerMatch IncludesNoExec" >> $FILE
	echo "" >> $FILE
	echo "		<Limit GET POST OPTIONS>" >> $FILE
	echo "			Order allow,deny" >> $FILE
	echo "			Allow from all" >> $FILE
	echo "		</Limit>" >> $FILE
	echo "		<LimitExcept GET POST OPTIONS>" >> $FILE
	echo "			Order deny,allow" >> $FILE
	echo "			Deny from all" >> $FILE
	echo "		</LimitExcept>" >> $FILE
	echo "	</Directory>" >> $FILE
	echo "" >> $FILE
	echo "	<Directory /home/${NAME}/public_html/cgi-bin>" >> $FILE
	echo "		AllowOverride FileInfo AuthConfig Limit Indexes" >> $FILE
	echo "		Options -MultiViews SymLinksIfOwnerMatch +ExecCGI" >> $FILE
	echo "		SetHandler cgi-script" >> $FILE
	echo "" >> $FILE
	echo "		<Limit GET POST OPTIONS>" >> $FILE
	echo "			Order allow,deny" >> $FILE
	echo "			Allow from all" >> $FILE
	echo "		</Limit>" >> $FILE
	echo "		<LimitExcept GET POST OPTIONS>" >> $FILE
	echo "			Order deny,allow" >> $FILE
	echo "			Deny from all" >> $FILE
	echo "		</LimitExcept>" >> $FILE
	echo "	</Directory>" >> $FILE
	echo "" >> $FILE
	echo "	<IfModule mpm_itk_module>" >> $FILE
	echo "		AssignUserId ${NAMEWWW} ${NAME}" >> $FILE
	echo "	</IfModule>" >> $FILE
	echo "" >> $FILE
	echo "	BandWidthModule On" >> $FILE
	echo "	ForceBandWidthModule On" >> $FILE
	echo "	BandWidth all 200000" >> $FILE
	echo "" >> $FILE
	echo "	ErrorLog        /home/${NAME}/Apache2_${NAME}_error.log" >> $FILE
	echo "	CustomLog       /home/${NAME}/Apache2_${NAME}_access.log common" >> $FILE
	echo "</VirtualHost>" >> $FILE
	echo "" >> $FILE
 
	echo "Done"
 
	# Activate user config
	echo -ne "Enabling apache config .... "
        a2ensite user_$NAME.conf >> /dev/null
	echo "Done"
 
	# Reload apache config
	echo -ne "Reloading apache config ... "
	/etc/init.d/apache2 reload >> /dev/null
	echo "Done"
 
	# Add suwww config to sudoers
	echo -ne "Adding user to suwww ...... "
	echo -ne "${NAME}\t\tALL = NOPASSWD: /bin/su ${NAMEWWW} -s /bin/bash\n" >> /etc/sudoers.d/suwww
	echo "Done"
 
	# Add user to mail config
	echo -ne "Adding postfix mappings ... "
	echo "${NAME}@insomnia247.nl ${NAME}" >> /etc/postfix/virtual
	echo "${NAME}-www@insomnia247.nl ${NAME}" >> /etc/postfix/virtual
	echo "Done"
 
	# Make postfix hashmap
	echo -ne "Generating postfix hash ... "
	/usr/sbin/postmap /etc/postfix/virtual
	echo "Done"
 
	# Reload postfix config
	echo -ne "Reloading postfix ......... "
	/etc/init.d/postfix reload >> /dev/null
	echo "Done"
 
	# Update invite database
	echo -ne "Updating database ......... "
	ruby /root/new/update_db.rb $NAME
	echo "Done"
}
 
function sendMail {
	# Send conformation mail
	echo -ne "Queuing e-mail ............ "
	mailer "smtp.ziggozakelijk.nl" "lydia@insomnia247.nl" "$ADDR" "Shell request $NAME" "`cat /root/new/newuser.mail.$TYPE && echo -ne \"\n\nYour password is ${PASS}\"`" fork
	echo "Done"
}
 
if [ "$TYPE" == "reject" ] || [ "$TYPE" == "rejectsuspended" ] || [ "$TYPE" == "rejectdouble" ] || [ "$TYPE" == "rejectuse" ] || [ "$TYPE" == "rejectupdateuse" ]; then
	sendMail
else
	createAccount
	sendMail
fi
 
echo "Finished."
 