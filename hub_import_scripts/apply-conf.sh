
echo "Fix TODO (Installing conda requirements, switching to user conda environment) in script before using"
exit 1

#Apply a 'hubconfig' based on a hub config folder
if [ -z $1 ]
then
    echo "Applies hub and user requirements to an environment given a requirements folder"
   echo "Usage: "$0" path/to/conf/folder/"
   exit 1
fi

#apt requirements- example hub-requirements-jupyterhub-workshop.txt   
apply-hub-conf.sh $1
#TODO - conda

#TODO - go into user land here
apply-user-conf.sh $1


   
