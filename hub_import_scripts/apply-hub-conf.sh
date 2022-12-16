#Apply a 'hubconfig' based on a hub config folder
if [ -z $1 ]
then
    echo "Applies the hub configuration to an instance, given a folder containing a hub requirements file"
   echo "Usage: " $0 " path/to/conf/folder/"
   exit 1
fi

   
#apt requirements- example hub-requirements-jupyterhub-workshop.txt   
aptgetfile=$1+"hub-requirements-*.txt"

apt-get install -qy < $aptgetfile


   
