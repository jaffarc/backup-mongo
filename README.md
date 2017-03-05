# Backup-mongo 
Creates backup files (bson) of all MongoDb databases on a given server
Default behaviour dumps the mongo database and tars the output into a file
named after the current date. ex: date.tar.gz

This structure was created for js-modules according to some standards of pattern.


    project
		|_backup 
			|mongodb-date/
		  	    |folder_nameDB/
		  	    |-mongodb-date.tar.gz
		


## Config
1. if you localhost Set server settings. 
	
        ```
        SASL=false
        HOST="localhost"
        PORT="27017" #default mongoDb port is 27017
        USERNAME=""
        PASSWORD="''"
        ```

2. if you authenticate SASL set server settings..
  
        ```
        SASL=true
        HOST="192.168.0.1" 
        PORT="27017" 
        USERNAME="user"
        PASSWORD="'1234'"
        ```

2. if you authenticate defaul set server settings..
  
        ```
        SASL=false
        HOST="192.168.0.1" 
        PORT="27017" 
        USERNAME="user"
        PASSWORD="'1234'"
        ```

##Restore

mongorestore --host $HOST -u $USERNAME -p $PASSWORD --port $PORT --drop -d namedb backup/mongodb-date/folder_nameDB/

##References: 
	url: https://docs.mongodb.com/manual/reference/connection-string/ 
	

Just have fun. Go ahead and edit the code or add new files. This was a study!