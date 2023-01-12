if [ $1 == "install" ]
then
   mkdir oboz-papieski
   cp $2 oboz-papieski
   cd oboz-papieski
   unzip $2
   rm -rf $2
   artifact=$(sed -n '2p' properties.maledziewczynki)
   executable=$(sed -n '3p' properties.maledziewczynki)
   desktopfile=$(sed -n '4p' properties.maledziewczynki)
   cd ..
   mv oboz-papieski /kremowkas/$artifact
   cd ~
   echo alias $artifact=\"/kremowkas/$artifact/$executable\" >> .popenames
   cd /kremowkas/$artifact/
   mv $desktopfile ~/.local/share/applications/
   mv *.kremowka /tmp
   for i in $(seq $(ls /tmp/*.kremowka | wc -l))
   do
      ~/.pope.sh autoinstall $(find /tmp/ -maxdepth 1 -type f -name '*.kremowka'  -printf "%P\n")
   done


   
elif [ $1 == "update" ]
then
   mkdir oboz-papieski
   mv $2 oboz-papieski
   cd oboz-papieski
   unzip $2
   rm -rf $2
   artifact=$(sed -n '2p' properties.maledziewczynki)
   executable=$(sed -n '3p' properties.maledziewczynki)
   desktopfile=$(sed -n '4p' properties.maledziewczynki)
   cd ..
   mv oboz-papieski /kremowkas/$artifact -f
      
elif [ $1 == "autoinstall" ]
then
   mkdir /tmp/oboz-papieski
   mv /tmp/$2 /tmp/oboz-papieski
   cd /tmp/oboz-papieski
   unzip /tmp/oboz-papieski/$2 -d /tmp/oboz-papieski
   rm -rf /tmp/oboz-papieski/$2
   artifact=$(sed -n '2p' /tmp/oboz-papieski/properties.maledziewczynki)
   executable=$(sed -n '3p' /tmp/oboz-papieski/properties.maledziewczynki)
   desktopfile=$(sed -n '4p' /tmp/oboz-papieski/properties.maledziewczynki)
   mv /tmp/oboz-papieski /kremowkas/$artifact
   echo alias $artifact=\"/kremowkas/$artifact/$executable\" >> ~/.popenames
   mv /kremowkas/$artifact/$desktopfile ~/.local/share/applications/
   mv /kremowkas/$artifact/*.kremowka /tmp
   echo $(ls /tmp/*.kremowka | wc -l)
   ls -lR /tmp/*.kremowka | wc -l
   for i in $(seq $(ls /tmp/*.kremowka | wc -l))
   do
      ~/.pope.sh autoinstall $(find /tmp/ -maxdepth 1 -type f -name '*.kremowka'  -printf "%P\n")
   done
elif [ $1 == "uninstall" ] || [ $1 == "purge" ]
then
   artifact=$(sed -n '2p' /kremowkas/$2/properties.maledziewczynki)
   executable=$(sed -n '3p' /kremowkas/$2/properties.maledziewczynki)
   desktopfile=$(sed -n '4p' /kremowkas/$2/properties.maledziewczynki)
   sedcommand="sed -i /$artifact/d .popenames"
   $sedcommand
   
   rm -rf ~/.local/share/applications/$desktopfile
   rm -rf /kremowkas/$artifact
   
fi
