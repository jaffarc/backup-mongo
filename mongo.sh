#!/bin/bash
#
# jaffar cardoso 
# <jaffar.cardoso@gmail.com>


### Set server settings
SASL=false
HOST="localhost"
PORT="27017" # default mongoDb port is 27017
USERNAME=""
PASSWORD="''"

PROJECT="NAME_Project"

BACKUP_PATH="./$PROJECT/backup" 
FILE_NAME=`date +%H_%M` 

DIR=`date +%y-%m-%d:%H:%M:%S`
DEST=db_backups/$DIR
mkdir $DEST



MONGO_DUMP_BIN_PATH="$(which mongodump)"
TAR_BIN_PATH="$(which tar)"

TODAYS_DATE=`date +%Y-%m-%d`

BACKUP_PATH="$BACKUP_PATH/$TODAYS_DATE"

[ ! -d $BACKUP_PATH ] && mkdir -p $BACKUP_PATH || :

# Ensure directory exists before dumping to it
if [ -d "$BACKUP_PATH" ]; then

	cd $BACKUP_PATH
	
	TMP_BACKUP_DIR="mongodb-$FILE_NAME"
	
	echo; echo "=> Backing up Mongo Server: $HOST:$PORT"; echo -n '   ';
	
	# run dump on mongoDB
	if [ "$SASL" = true   -a "$PASSWORD" != "" ]; then 
		$MONGO_DUMP_BIN_PATH -h $HOST --port $PORT -d namedb -u $USERNAME -p $PASSWORD  -o $TMP_BACKUP_DIR >> /dev/null
	else	

		$MONGO_DUMP_BIN_PATH --host $HOST:$PORT -u $USERNAME -p $PASSWORD --out $TMP_BACKUP_DIR >> /dev/null
	fi

	if [ "$SASL" = false -a "$PASSWORD" != "" ]; then
		$MONGO_DUMP_BIN_PATH --host $HOST:$PORT --out $TMP_BACKUP_DIR >> /dev/null
	fi

	if [ -d "$TMP_BACKUP_DIR" ]; then
	
		# replace DATE with todays date in the filename
		FILE_NAME="mongodb-$FILE_NAME"
		echo `cd $FILE_NAME/`
		echo "=> Create tar.gz: `tar czf $FILE_NAME.tar.gz *`"; 
	
		if [ -f "$FILE_NAME.tar.gz" ]; then
			echo "=> Success: `du -sh $FILE_NAME.tar.gz`"; echo;
			if [ -d "$BACKUP_PATH/$TMP_BACKUP_DIR" ]; then
				rm -rf "$BACKUP_PATH/$TMP_BACKUP_DIR"
			fi
		else
		echo "$BACKUP_PATH"
			 echo "!!!=> Failed to create backup file: $BACKUP_PATH/$FILE_NAME.tar.gz"; echo;
		fi
	else 
		echo; echo "!!!=> Failed to backup mongoDB"; echo;	
	fi
else
	echo "!!!=> Failed to create backup path: $BACKUP_PATH"
fi
