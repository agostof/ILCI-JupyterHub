#User level configs
#-Josh L.S.
if [ -z $1 ]
then
    echo "Applies user configurations based on a configuration folder"
   echo "Usage: "$0" path/to/conf/folder/"
   exit 1
fi

   
#apt requirements- example user-requirements-jupyterhub-workshop.txt   
aptgetfile=$1+"user-requirements-*.txt"

apt-get install -qy < $aptgetfile

rfile=$1+"user-r-packages-*.w_version.tsv"

Rscript apply-r-conf.r $rfile    
