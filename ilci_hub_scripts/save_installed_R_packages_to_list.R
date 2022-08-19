#!/usr/local/bin/Rscript

cmdLineArgs = commandArgs(TRUE)

# cat("Number of arguments passed:", length(cmdLineArgs), "\n")

if (length(cmdLineArgs) == 0) {
   cat("ERROR:Not enough arguments given.\n")
   cat("Plase provide a file name.\n")
   quit()
}

outFile <- cmdLineArgs[1]
outTsv <- paste0(gsub(".txt", "", outFile), ".w_version.tsv")

cat("Saving installed package list to:", outFile, "\n")
cat("Saving installed package with version to:", outTsv, "\n")

basePacks = rownames(installed.packages(priority="base"))
allPacks = rownames(installed.packages())

#write.table(installed.packages()[,1], file=outFile, row.names=F, col.names=F)


keepPacks <- setdiff(allPacks, basePacks)
write.table(keepPacks, file=outFile, row.names=F, col.names=F)

keepPacks.vector <- as.vector(keepPacks)
T  <- as.data.frame(installed.packages())
S <- T[T$Package %in% keepPacks.vector,c('Package','Version')]

write.table(S, row.names=F, sep="\t", quote=F, file=outTsv)

