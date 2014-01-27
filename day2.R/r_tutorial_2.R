
microbial_genomes = read.table("microbial_genome.txt", header=T, sep="\t")

#Split-combine-apply strategies with the plyr package

#When we want to analyze data, we often take a split-combine-apply strategy where data is split into manageable pieces which can be operated upon independently, and then combined back together (Wickham 2011).  The plyr package combines multiple functions in R to apply this strategy to a dataset.

#First let's install the package titled "plyr"

install.packages("plyr")
library(plyr)

head(microbial_genomes)
#Suppose we want to expand on our previous example of finding the average number of genes per phylum, but for all phyla in the dataset.  We would need to use a split-apply-combine strategy.

#First we would split the data independent groups based on phyla

split_phyla<-split(microbial_genomes, microbial_genomes$Phylum)
str(split_phyla)
#We now have a list of 32 data frames containing all the info from microbial_genomes divided by phylum.  If I want to see all the data related to the first Phylum, Acidobacteria, I can look specifically at that element in the list
  
split_phyla[1]

#If I wanted to get the mean value of Gene_Count for Acidobacteria, I would have to do the following

mean(split_phyla$Acidobacteria$Gene_Count)


#In our previous example we looked at the average gene count for Actinobacteria and Proteobacteria, but what if we want the mean value for all phyla?  We would need to work with each Phylum individually (Apply step), and then combine them in the same data frame (combine)

results<-matrix(nrow=0,ncol=2)

for(i in 1:length(split_phyla)){
	
	Phylum.name<-names(split_phyla[i])
	mean.gene.count<-mean(split_phyla[[i]]$Gene_Count)
	new.row<-c(Phylum.name, mean.gene.count)
	results<-rbind(results,new.row)
	
}

head(results)

#What problems could occur with this?  Are there simplier ways to do this?


#The plyr solution.  There are many functions in plyr that can be used to address this problem.  Today we will focus only on ddply.  Let's start with our data frame microbial genomes and try to end up with a dataframe full of mean gene counts for each phylum.

?ddply()  #lets discuss some of the split-apply-combine steps integrated in this function
# .data is the dataframe you begin with
# .variables are what you use to SPLIT
# .fun is the function to APPLY

#and the COMBINE step is an implicit part of the function

#lets use ddply to generate mean gene counts per phylum

mean_gene_counts<-ddply(microbial_genomes, .(Phylum), summarize,
	mean_gene_count=mean(Gene_Count)
	
	)
head(mean_gene_counts)

#we now have all of the gene counts in a data frame with the use of one function.  But what if we want more summary statistics like median, maximum, and minimum values?

gene_statistics<-ddply(microbial_genomes, .(Phylum), summarize,
	mean_gene_count=mean(Gene_Count),
	maximum_gene_count=max(Gene_Count),
	minimum_gene_count=min(Gene_Count),
	median_gene_count=median(Gene_Count)
	)

gene_statistics

###EXERCISES

# 1) Write a function to calculate standard error, and then use ddply to calculate the standard error of gene counts for each phylum.  Check the output and discuss any differences/ strange results that you may generate



###SOLUTION###
standard.error<-function(value){
	
	return(sd(value,na.rm=TRUE)/length(value))
}

gene_statistics<-ddply(microbial_genomes, .(Phylum), summarize,
	mean_gene_count=mean(Gene_Count),
	maximum_gene_count=max(Gene_Count),
	minimum_gene_count=min(Gene_Count),
	median_gene_count=median(Gene_Count),
	standard_error=standard.error(Gene_Count)
	)	
gene_statistics
#NA's will be generated due to some phyla only having 1 entry in the dataset


######


#Another important step in analysis is visualizing your data.  One package that is useful in creating publication quality graphics is ggplot2.  There are several ways to use ggplot2 and there are several tutorials online.  Visit http://ggplot2.org/ for more details and publications related to using ggplot2.

#The example we are going to show will illustrate some of the utility of ggplot2 but in no way represents everything you can do with this package.  We will present a straightforward way to display values (mean_gene_count) in relation to categorical variables (Phylum)

#Let's start with installing and loading the ggplot2 package

install.packages("ggplot2")
library(ggplot2)

##ggplot2 is based on independent components that can be added to a graph.  Let's start with plotting the mean gene counts of all phylum.

ggplot(data=gene_statistics,x=Phylum, y=mean_gene_count)

#We have the dataset (data=...) and variables that we would like to plot, but nothing is produced.  We need geometric objects to represent our data.  In this case we will use points.


ggplot(data=gene_statistics)+geom_point(aes(x=Phylum, y=mean_gene_count)) 

#Now we have added geom_point() which is a function that adds points to a plot.  We use aes() to pass information to geom_point about which variables we would like to map aesthetically (hence, aes...).  Notice that we can rearrange our code and get the same response.

ggplot(data=gene_statistics, aes(x=Phylum,y=mean_gene_count))+geom_point()

#Now these plots are hard to read due to the x-axis labels running into each other.  With coord_flip() we can rotate our plot, and make it easier to read labels
 
ggplot(data=gene_statistics)+geom_point(aes(x=Phylum, y=mean_gene_count))+coord_flip()

#Whenever we have so many points, it can be difficult to understand trends.  Suppose we wanted to arrange phyla by decreasing mean_gene_count.  We can do this by reordering (reorder()) our phyla based on mean_gene_count

ggplot(data=gene_statistics)+geom_point(aes(x=reorder(Phylum, mean_gene_count), y=mean_gene_count))+coord_flip()

#Now we can see that Tenericutes has the smallest average gene count while Planctomycetes has the highest.  We may also want to establish some sort of uncertainty around our mean value (i.e. standard error).  We can change our points to points with lines representing uncertainty (geom_pointrange())

ggplot(data=gene_statistics)+geom_pointrange(aes(x=reorder(Phylum, mean_gene_count), y=mean_gene_count, ymax=mean_gene_count+standard_error, ymin=mean_gene_count-standard_error))+coord_flip()

#Suppose this is our final plot that we would like to clean up for publication.  There are several possible options.  Here I will add informative axis labels (labs(x=...,y=...,title=...)), get rid of the grey background color and make axis labels black (theme_bw()), and make sure that the plot has a square aspect ratio (theme(aspect.ratio=1))

ggplot(data=gene_statistics)+geom_pointrange(aes(x=reorder(Phylum, mean_gene_count), y=mean_gene_count, ymax=mean_gene_count+standard_error, ymin=mean_gene_count-standard_error))+coord_flip()+labs(x="Phyla",y="Mean Gene Count", title="Number of Genes in Microbial Genomes")+theme_bw()+theme(aspect.ratio=1)

####EXERCISES

# 1) Generate a publication ready plot of average genome size across phyla with error bars using ddply and ggplot.
# 2) From the microbial_genomes dataframe, generate a publication ready scatterplot showing the correlation of genome size (x) and gene count (y) and color points based on phyla. 
		## Hint:replace phylum with genome size in ggplot and add another argument, color=..., to the aes() of geom_point() (geom_pointrange(aes(...,color=...))






###SOLUTION

solution<-ddply(microbial_genomes, .(Phylum), summarize,
	mean_gene_count=mean(Gene_Count),
	mean_genome_size=mean(Genome_Size),
	standard_error=standard.error(Genome_Size)
	)	

ggplot(data=solution)+geom_pointrange(aes(x=reorder(Phylum, mean_genome_size), y=mean_genome_size, ymax=mean_genome_size+standard_error, ymin=mean_genome_size-standard_error))+coord_flip()+labs(x="Phyla",y="Mean Genome Size", title="Genome Sizes of Microbial Phyla")+theme_bw()+theme(aspect.ratio=1)

#solution plus extra stuff
ggplot(data=microbial_genomes)+geom_point(aes(x=Genome_Size,y=Gene_Count,colour=Phylum))+guides(col=guide_legend(ncol=2))+labs(x="Genome Size",y="Gene Count", "Relationship Between Genome Size and Gene Count")+theme_bw()+scale_x_log10()+scale_y_log10()
#####Citations#######


#Wickham, H. 2011. The-Split-Apply-Combine Strategy for Data Analysis. Journal of Statistical Software. 40,1,1-29.