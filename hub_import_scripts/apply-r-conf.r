install.packages('remotes', repos="http://cran.us.r-project.org")
require('remotes')
args <- commandArgs(trailingOnly = TRUE)
installList <- read.csv(file=args[1], sep = "\t")

#print("Install List:")
#print(installList)

for(i in 1:nrow(installList)){
   package <- installList[i,1]
   version <- installList[i,2]
   repo <- "http://cran.us.r-project.org"
   if(ncol(installList) > 2){
     repo <- installList[i,3]
   }		      
   install_cran(package,version=version,repos=repo,quiet=TRUE)
}