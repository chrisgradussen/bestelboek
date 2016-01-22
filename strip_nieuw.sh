# $1   #input file
#!/usr/bin/bash

export LANG=C;
workfile=$(mktemp);

xxd -g 64 $1|sed 's/.........//'|sed 's/..................$//'|tr -d '\n'|sed 's/5453484d0000............................................................................................................//g'|xxd -r -p|sed 's/[\x00-\x1F,,\x7F-\xFF]/ /g'>$workfile
#sed 's/[\x00-\x1F,\x7F-\xFF]/ /g' 

/usr/bin/awk ' BEGIN {FS="|"}
/Mutaties Artikel dagelijks/ {   
    POSITIE = match($0,"Mutaties Artikel dagelijks");
    datum = "'\''"substr($0,POSITIE+33,2)"."substr($0,POSITIE+31,2)"."substr($0,POSITIE + 29,2)"'\''";
	ARTIKELAANTAL = substr($0,POSITIE+56,8)+0
	for (i = 1; i < ARTIKELAANTAL;i++)
	{
		getline
		if ($3 >= 220000 && $3<230000 )
		{  $3 = $3*10000000;}
        if ($3 >= 2300000 && $3<2400000 )
        {  $3 = $3*1000000;}
	    BESTELINHOUD=$58+0
		LEVERANCIER=$89+0
	    SUBGROEP=$62+0
	    INKOOPPRIJS=$25+0
	    VERKOOPPRIJS=$24+0
	    INHOUD=$132+0
	    OMSCHRIJVING=$7
	    gsub(/'\''/,"'\'''\''",OMSCHRIJVING);
	    KASSAOMSCHRIJVING=$9
	    gsub(/'\''/,"'\'''\''",KASSAOMSCHRIJVING);
	    print "EXECUTE PROCEDURE ARTIKEL_UPDATE('\''"$3"'\'','\''"LEVERANCIER"'\'','\''"SUBGROEP"'\'','\'''\'','\''"OMSCHRIJVING"'\'','\''"KASSAOMSCHRIJVING"'\'','\''0'\'','\''"INKOOPPRIJS"'\'','\''"VERKOOPPRIJS"'\'','\''"INHOUD"'\'','\''ST'\'','\''"BESTELINHOUD"'\'','\''ST'\'','\''"$86 + 0"'\''",","datum","datum");"

	}
}
END {print "COMMIT;"}' $workfile





/usr/bin/awk ' BEGIN {FS="|"}
/Promoties Artikel dagelijks/ {   
    POSITIE = match($0,"Promoties Artikel dagelijks");
    datum = "'\''"substr($0,POSITIE+34,2)"."substr($0,POSITIE+32,2)"."substr($0,POSITIE + 30,2)"'\''";
	ARTIKELAANTAL = substr($0,POSITIE+57,8)+0
	for (i = 1; i < ARTIKELAANTAL;i++)
	{
		getline
		if ($3 >= 220000 && $3<230000 )
		{  $3 = $3*10000000;}
        if ($3 >= 2300000 && $3<2400000 )
        {  $3 = $3*1000000;}
	    BESTELINHOUD=$58+0
		LEVERANCIER=$89+0
	    SUBGROEP=$62+0
	    INKOOPPRIJS=$25+0
	    VERKOOPPRIJS=$24+0
	    INHOUD=$132+0
	    OMSCHRIJVING=$7
	    gsub(/'\''/,"'\'''\''",OMSCHRIJVING);
	    KASSAOMSCHRIJVING=$9
	    gsub(/'\''/,"'\'''\''",KASSAOMSCHRIJVING);
	    print "EXECUTE PROCEDURE ARTIKEL_UPDATE('\''"$3"'\'','\''"LEVERANCIER"'\'','\''"SUBGROEP"'\'','\'''\'','\''"OMSCHRIJVING"'\'','\''"KASSAOMSCHRIJVING"'\'','\''0'\'','\''"INKOOPPRIJS"'\'','\''"VERKOOPPRIJS"'\'','\''"INHOUD"'\'','\''ST'\'','\''"BESTELINHOUD"'\'','\''ST'\'','\''"$86 + 0"'\''",","datum","datum");"

	}
}
END {print "COMMIT;"}' $workfile

/usr/bin/awk '
/^257/ {
	 ID= substr($0,60,14);
	 ID=ID*1;
	 TYPE=substr($0,74,1);   #single = 2 group = 3
	 STARTJAAR=substr($0,119,1)+2010;
	 STARTMAAND=substr($0,120,2);
	 STARTDAG=substr($0,122,2);
     STOPJAAR=substr($0,76,1)+2010;
	 STOPMAAND=substr($0,77,2);
	 STOPDAG=substr($0,79,2);
	 OMSCHRIJVING=substr($0,81,20);
	# print $0;
	# print "OMSCHRIJVING :  " OMSCHRIJVING;
	  gsub(/'\''/,"'\'''\''",OMSCHRIJVING);
 
	  #print substr($0,91,10);
	 #print substr($0,101,10);
	 #print substr($0,111,10);
	 ACTION=substr($0,4,3); # add/modify item = 6, delete item = 8
	 SUBTYPE=substr($0,101,2); # 01 = , 2 = percentage, 8 = nieuwe prijs per set, 21 =  nieuwe prijs per artikel
	# print SUBTYPE;
	  day = STARTDAG+0
	  mon = STARTMAAND+0
	  year = STARTJAAR+0
	  if (ACTION*1==6)	
if (day == 31 && (mon == 4 ||  mon == 6 || mon == 9 || mon == 11))
	{
      print "KO: "$0 # "*/" 30 days months
	  ACTION=0
	}
   else if (day >= 30 && mon == 2)
	   {   print "/*KO: "$0 "/*" # Febrary never 30 o 31
		   ACTION=0
	   }	   
   else if (mon == 2 && day == 29 && ! (  year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)))
	   { ACTION=0
      print "/*KO: " $0 "*/"# Febrary  29 leap year
  }
   else  if (day <1 || day > 31)
	   {       # print "dag : " day " " OMSCHRIJVING
	          print "/*KO INVALID DAY: "$0 "*/"# INVALID DAY
              ACTION=0
		}
	else
		{
     # print "Correct date !:" $0

  }

	 if (ACTION*1 == 6) 
	 {  
	    print "UPDATE OR INSERT INTO RECLAME_JUMBO (ID,SUBTYPE,TYPE,STARTDATUM,EINDDATUM,OMSCHRIJVING,VOORDEEL) values('\''"ID"'\'','\''"SUBTYPE"'\'','\''"TYPE"'\'','\''"STARTDAG"."STARTMAAND"."STARTJAAR"'\'','\''"STOPDAG"."STOPMAAND"."STOPJAAR"'\'','\''"OMSCHRIJVING"'\'','\''"VOORDEEL"'\'') MATCHING (ID);";
	 #print "COMMIT;";
      }
	  if (ACTION*1 == 8)
	  {   
	
		  print "DELETE FROM RECLAME_JUMBO WHERE ID = '\''"ID"'\'';";
		 # print "COMMIT;";
	  }
	 }
/^258/ { 
	 ID= substr($0,60,14);
	 ID=ID*1;
	 VOORDEEL=substr($0,77,12);
	 VOORDEEL=VOORDEEL*1/100
	 ACTION=substr($0,4,3);
	 if (ACTION*1 ==6)
     {
	    print "UPDATE RECLAME_JUMBO SET VOORDEEL = '\''" VOORDEEL "'\'' where ID = '\''" ID"'\'';";
		#print "COMMIT;";
	 }
#	 print $0;
	# print ID " " SUBTYPE " " VOORDEEL " " OMSCHRIJVING
#	 print "EMPTY LINE"
	 }
	 
/^259/ {   
    #print $0
    id = substr($0,60,14)+0
	aantal = substr($0,111,10) +0
	#print "id : " substr($0,60,14) " aantal : " substr($0,111,10) " groepnummer : " substr($0,101,10);
	
	print "UPDATE RECLAME_JUMBO SET AANTAL = " aantal " where ID = " id ";"
 }
#/^259008/ {   
#    print $0
#    id = substr($0,60,14)+0
#	aantal = substr($0,111,10) +0
#	print "id : " id " aantal : " aantal " groepnummer : " substr($0,101,10);
#	
#	print "UPDATE RECLAME_JUMBO SET AANTAL = " aantal " where ID = " id ";"
# }	 
	 
 
	 
	 END{print "COMMIT;"}
	 
 ' $workfile;

/usr/bin/awk '
/^101/ {
		  ID= substr($0,60,14);
          ACTION=substr($0,4,3);

		  ID=ID*1;
          PLUCODE = substr($0,76,14);
		  PLUCODE = PLUCODE*1;
	      if (PLUCODE >= 220000 && PLUCODE<230000 )
             { PLUCODE = PLUCODE*10000000};
          if (PLUCODE >= 2300000 && PLUCODE<2400000 )
             { PLUCODE = PLUCODE*1000000};
 # print "ACTION : " ACTION
	#	 print PLUCODE 
	#	 print " PLUCODE : " PLUCODE
	#	 print " ID      : " ID;
	 if (ACTION*1 == 6) 
	 {  
	    print "UPDATE OR INSERT INTO RECLAME_JUMBO_PLU (RECLAME_JUMBO_ID,EAN) values('\''"ID"'\'','\''"PLUCODE"'\'') MATCHING (RECLAME_JUMBO_ID,EAN);";
	 #print "COMMIT;";
      }
	  if (ACTION*1 == 8)
	  {   
	
		  print "DELETE FROM RECLAME_JUMBO_ID WHERE RECLAME_JUMBO_ID = '\''"ID"'\'' AND EAN = '\''"PLUCODE"'\'';";
		  #print "COMMIT;";
	  }


	 }END{print "COMMIT;"}'  $workfile;

	 rm $workfile;


