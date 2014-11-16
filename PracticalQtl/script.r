# Libraries to install:
# * testit
# * qtl
library(qtl)
library(testit)

rm(list = ls())
genotype_filename <- "genotype_data.csv"
genotype_filename_geraulti <- "generated_genotype_data_geraulti.csv"
genotype_filename_oneida <- "generated_genotype_data_oneida.csv"
phenotype_filename <- "phenotype_data.csv"
phenotype_filename_geraulti <- "generated_phenotype_data_geraulti.csv"
phenotype_filename_oneida <- "generated_phenotype_data_oneida.csv"
marker_filename <- "marker_location.csv"

`%ni%` <- Negate(`%in%`)

assert("Genotype file must exist",file.exists(genotype_filename))
assert("Phenotype file must exist",file.exists(phenotype_filename))
assert("Marker location file must exist",file.exists(marker_filename))

#Create genetic datafile for males that mated with Geraulti females
CreateGenotypeGeraulti <- function()
{
  
  g <- read.table(genotype_filename,header=TRUE,sep=",")
  p <- read.table(phenotype_filename,header=TRUE,sep=",")
  p <- subset(p,female.f2 == "G")
  indices <- p$Sample_ID
  g <- subset(g,g$Sample_ID %in% indices)
  write.csv(g,genotype_filename_geraulti,row.names=FALSE)
  rm(g)
  rm(p)
  assert("Genotype Geraulti file must exist",file.exists(genotype_filename_geraulti))
}

#Create genetic datafile for males that mated with Oneida females
CreateGenotypeOneida <- function()
{
	g <- read.table(genotype_filename,header=TRUE,sep=",")
	p <- read.table(phenotype_filename,header=TRUE,sep=",")
	p <- subset(p,female.f2 == "O")
	indices <- p$Sample_ID
	g <- subset(g,g$Sample_ID %in% indices)
	write.csv(g,genotype_filename_oneida,row.names=FALSE)
	rm(g)
	rm(p)
	assert("Genotype Oneida file must exist",file.exists(genotype_filename_oneida))
}


#Create datafile for males that mated with Geraulti females
CreatePhenotypeGeraulti <- function()
{
  temp <- read.table(phenotype_filename,header=TRUE,sep=",")
  temp <- subset(temp,female.f2 == "G")
  write.csv(temp,phenotype_filename_geraulti,row.names=FALSE)
  rm(temp)
  assert("Phenotype Geraulti file must exist",file.exists(phenotype_filename_geraulti))
}

#Create datafile for males that mated with Oneida females
CreatePhenotypeOneira <- function()
{
  temp <- read.table(phenotype_filename,header=TRUE,sep=",")
  temp <- subset(temp,female.f2 == "O")
  write.csv(temp,phenotype_filename_oneida,row.names=FALSE)
  rm(temp)
  assert("Phenotype Oneida file must exist",file.exists(phenotype_filename_oneida))
}

CreatePhenotypeGeraulti()
CreatePhenotypeOneira()

assert("Phenotype Geraulti file must exist",file.exists(phenotype_filename_geraulti))
assert("Phenotype Oneida file must exist",file.exists(phenotype_filename_oneida))

#CreateGenotypeGeraulti()
#CreateGenotypeOneida()
assert("Genotype Oneida file must exist",file.exists(genotype_filename_oneida))
assert("Genotype Geraulti file must exist",file.exists(genotype_filename_geraulti))

# Giacomo part

data_geraulti <- read.cross(
  c("csvs"),
  dir="", 
  genfile=genotype_filename_geraulti,
  phefile=phenotype_filename_geraulti,
  mapfile=marker_filename,
  na.strings="NA",
  genotypes=c("O","G"), # The markers come from either Geraulti or Oneida grandparents
  estimate.map=FALSE
)

data_oneida <- read.cross(
  c("csvs"),
  dir="", 
  genfile=genotype_filename_oneida,
  phefile=phenotype_filename_oneida,
  mapfile=marker_filename,
  na.strings="NA",
  genotypes=c("O","G"), # The markers come from either Geraulti or Oneida grandparents
  estimate.map=FALSE
)

# Richel part
data_both <- read.cross(
	c("csvs"),
	dir="", 
  genfile=genotype_filename,
  phefile=phenotype_filename,
	mapfile=marker_filename,
	na.strings="NA",
	genotypes=c("O","G"), # The markers come from either Geraulti or Oneida grandparents
	estimate.map=FALSE
)

PlotPhenotypes <- function(data,species_name)
{
	for (i in 3: length(names(data_both$pheno)))
	{
		phenotype_name <- names(data$pheno)[i]
		phenotype_name <- gsub("\\.","", phenotype_name) #Remove dots
		my_filename <- paste("phenotype_",species_name,"_",phenotype_name,".svg",sep="")
		#sub <- subset(data, ind=!is.na(pull.pheno(data,phenotype_name)))
		#sub <- sim.geno(sub, n.draws=512, step=2, err=0.001) #RJCB: No idea what this does, except slowing us down
		#sub <- scanone(sub, method="imp") #RJCB: No idea what this does, except slowing us down
		svg(filename=my_filename)
		plot.pheno(data, i)
		dev.off()	
	}
}


PlotPhenotypes(data_geraulti,"geraulti")
PlotPhenotypes(data_oneida,"oneida")


PlotGenotypes <- function(data,species_name)
{
	for (i in 3: length(names(data$pheno)))
	{
		raw_phenotype_name <- names(data$pheno)[i]
		phenotype_name <- gsub("\\.","", raw_phenotype_name) #Remove dots
		my_filename <- paste("LOD_",species_name,"_",phenotype_name,".svg",sep="")
		sub <- subset(data, ind=!is.na(pull.pheno(data,raw_phenotype_name)))
		sub <- sim.geno(sub, n.draws=512, step=2, err=0.001) #RJCB: No idea what this does, except slowing us down
		sub <- scanone(sub, method="imp") #RJCB: No idea what this does, except slowing us down
		svg(filename=my_filename)
		plot(sub, ylab="LOD score", main=phenotype_name)
		dev.off()	
	}
}


PlotGenotypes(data_geraulti,"geraulti")
PlotGenotypes(data_oneida,"oneida")
PlotGenotypes(data_both,"both")


#pheno <- data_geraulti$pheno
#Remove cross.direction
#pheno <- subset(pheno, select=-c(cross.direction))
#pairs(jitter(as.matrix(data$pheno)),cex=0.6,las=1)


#svg(filename="Phenotype_frequencies.svg")
#plot(data)
#dev.off()

#plot(data)
#plot.missing(data)
#plot.map(data)
#plot.pheno(data, 1)
#plot.pheno(data, 2)



#DATA CHECK
par(mfrow=c(5,2))
for(i in 1:10)					#plot phenotypes
	plot.pheno(phenotype_data, pheno.col=i)

pairs((as.matrix(phenotype_data) ), cex=0.6, las=1)	#scatterplot phenotypes

ch3a$pheno[ch3a$pheno == , <wrong value>] <- NA	#eliminate strange error point	

means <- apply(ch3a$pheno, 1, mean)
plot(means)				#plot phenotypes on index (to check for measurements bias)

gt <- geno.table(ch3b)   #genotypes summary table to check for segregation distortion

 gt <- geno.table(data_genotype)
 p <- gt$P.value
 gt[ !is.na(p) & p < 0.01, ]		#check for bias in missing values

 cg <- comparegeno(ch3a)			#check for identical individual genotypes
 hist(cg, breaks=200,
+ xlab="Proportion of identical genotypes")
 rug(cg)


ch3c <- est.rf(ch3c)		#check pairwise recombinatin fraction (marker order)
#Warning message:
#In est.rf(ch3c) : Alleles potentially switched at markers
#c1m3 c1m4 c7m1 c7m2
checkAlleles(ch3c)

plot.rf(ch3c, alternate.chrid=TRUE)		#pairwise recombination fractions and LOD scores check


#THRESHOLD
data(hyper)
hyper <- calc.genoprob(hyper, step=1, error.prob=0.001)
operm <- scanone(hyper, n.perm=1000, verbose=FALSE)	#PERMUTATION TEST
plot(operm)
summary(operm, alpha=c(0.20, 0.05))
strat <- (ntyped(hyper) > 100)
operms <- scanone(hyper, n.perm=1000, perm.strata=strat,
  verbose=FALSE)
summary(operms, alpha=c(0.20, 0.05))
summary(out.em, perms=operms, alpha=0.1, pvalues=TRUE)
binom.test(0, 1000)$conf.int


#MULTIPLE PHENOTYPES
data_both <- read.cross(
	c("csvs"),
	dir="", 
  genfile=genotype_filename,
  phefile=phenotype_filename,
	mapfile=marker_filename,
	na.strings="NA",
	genotypes=c("O","G"), # The markers come from either Geraulti or Oneida grandparents
	estimate.map=FALSE
)
# Remove non-numeric column
data_both$pheno <- data_both$pheno[,-5]
data_both$pheno <- data_both$pheno[,-2]

n_phenotypes <- length(names(data_both$pheno)) 


operm.all <- scanone(data_both, pheno.col=1:n_phenotypes, n.perm=1000)
operm.all

#summary(operm.all, alpha=0.05)[1]

#i <- 3
#data <- data_both
#species_name <- "both"
#thresholds <- summary(operm.all, alpha=0.05)
PlotGenotypesWithThresholds <- function(data,species_name,thresholds)
{
	for (i in 3: length(names(data$pheno)))
	{
		raw_phenotype_name <- names(data$pheno)[i]
		phenotype_name <- gsub("\\.","", raw_phenotype_name) #Remove dots
		my_filename <- paste("LOD_with_threshold_",species_name,"_",phenotype_name,".svg",sep="")
		sub <- subset(data, ind=!is.na(pull.pheno(data,raw_phenotype_name)))
		sub <- sim.geno(sub, n.draws=512, step=2, err=0.001) #RJCB: No idea what this does, except slowing us down
		sub <- scanone(sub, method="imp") #RJCB: No idea what this does, except slowing us down
		svg(filename=my_filename)
		plot(sub, ylab="LOD score", main=phenotype_name,ylim=c(0,4))
    abline(a=thresholds[i],b=0,col="red",lty=2)
		dev.off()	
	}
}

PlotGenotypesWithThresholds(data_both,"both",	summary(operm.all, alpha=0.05))
PlotGenotypesWithThresholds(data_oneida,"oneida",	summary(operm.all, alpha=0.05))
PlotGenotypesWithThresholds(data_geraulti,"geraulti",	summary(operm.all, alpha=0.05))

# summary(out.all, format="allpeaks", perms=operm.all,alpha=0.05, pvalues=TRUE)
# summary(out.all, format="allpheno", perms=operm.all,alpha=0.05, pvalues=TRUE)
# 
# 
# sub <- subset(data_both, ind=!is.na(pull.pheno(data_both,"male_pheromone_level")))
# sub <- sim.geno(sub, n.draws=512, step=2, err=0.001) #RJCB: No idea what this does, except slowing us down
# View(data_both$pheno)
# out.all <- scanone(sub, pheno.col=3:n_phenotypes)
# warnings()
# summary(out.all, threshold=3, lodcolumn=n_phenotypes)
# summary(out.all, threshold=3, format="allpheno")
# summary(out.all, threshold=3, format="allpeaks")
# summary(out.all, format="allpeaks", perms=operm.all,
#   alpha=0.05, pvalues=TRUE)
# plot(out.all, lodcolumn=1:2, col=c("blue", "red"),
#   chr=c(2, 7, 8, 9, 16), ylim=c(0,12.7), ylab="LOD score")
# plot(out.all, lodcolumn=3:4, col=c("blue", "red"), lty=2,
#   chr=c(2, 7, 8, 9, 16), add=TRUE)
# 
