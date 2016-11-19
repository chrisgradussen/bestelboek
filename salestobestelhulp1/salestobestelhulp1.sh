hexdump -v -e '64/1 "%0.2x" "\n"' ../TRANSACT.QDX|./salestobestelhulp1|/usr/bin/isql-fb -e -user sysdba -password masterkey 10.0.0.114:bestelhulp1
