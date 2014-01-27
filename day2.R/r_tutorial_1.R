###1. R basics
####Getting Help with R

#There is a help function in R, and also a web-based help interface that allows easier searching and other functionality. 

#The function `help.start()` opens a web-based interface that is a good place to start for general help.

#If you need help understanding how to use a particular function, for example `median()`, use the following commands:
  
help(median)    # help about function median
?median         # help about function median
example(median) # example of function median

####Packages

#Functions and datasets in R are often provided as part of a <i><b>package</b></i>. For example,
#the `stats` package contains functions for commonly used statistical procedures; the
#`cluster` package contains functions for cluster analysis; and the `affy` package contains
#functions for analysis of Affymetrix microarrays. Some packages are included in the
#default R distribution and are loaded into any R session by default (for example, the
#stats package), while others must be installed and loaded by the user.

#The library() command (with no arguments) lists the packages that are installed.
#Of these, some may be loaded for use, and others may not. The search() command
#lists those packages that are loaded. Output of these commands will vary depending
#on the installation.

library() # lists packages that are installed
search() # lists the packages that are loaded

#To install a package, use the `install.packages()` function (this will likely ask you for a CRAN mirror the first time downloading, just pick one):
  
install.packages("vegan")
search()
library("vegan")
search()
  
###2. Data Structures and Basic Use
  
#Throughout the tutorial today, we will be using a metadata of microbial  genomes
#from the [Integrated Microbial Genomes (IMG)](http://img.jgi.doe.gov/) database. We will start of a small subset of this data, including the phylum, genome size, and gene count shown below:
  
  
#   | IMG_ID    | Phylum              | Genome_Size | Gene_Count |
#   |-----------|---------------------|-------------:|------------:|
#   | 637000001 | Acidobacteria       | 5650368     | 4837       |
#   | 637000031 | Actinobacteria      | 2260266     | 1805       |
#   | 637000082 | Actinobacteria      | 2488635     | 2395       |
#   | 637000085 | Actinobacteria      | 2476822     | 2186       |
#   | 637000010 | Aquificae           | 1590791     | 1613       |
#   | 637000024 | Bacteroidetes       | 5241700     | 4403       |
#   | 637000087 | Bacteroidetes       | 4433218     | 3843       |
#   | 637000059 | Chlamydiae          | 2414465     | 2079       |
#   | 637000071 | Chlamydiae          | 1225935     | 1157       |
#   | 637000072 | Chlorobi            | 2572079     | 2100       |
#   | 637000073 | Chlorobi            | 2154946     | 2317       |
#   | 637000089 | Chloroflexi         | 1469720     | 1647       |
#   | 637000090 | Chloroflexi         | 1395502     | 1517       |
#   | 637000020 | Firmicutes          | 4202352     | 4239       |
#   | 637000023 | Firmicutes          | 5314794     | 5452       |
#   | 637000060 | Firmicutes          | 2401520     | 2738       |
#   | 637000008 | Proteobacteria      | 1197687     | 1006       |
#   | 637000009 | Proteobacteria      | 1471282     | 1335       |
#   | 637000012 | Proteobacteria      | 4727255     | 4686       |
#   | 637000036 | Spirochaetes        | 1519856     | 1690       |
#   | 637000011 | Tenericutes         | 723970      | 734        |
  
  
####Overview of Data Structures
  
#####Data vectors
  
#A vector can be thought of as a way to store the values of one variable. For example, we can create a <b>vector</b>
#of all of the genome sizes:
  
Genome_Size = c(5650368, 2260266, 2488635, 2476822, 1590791, 5241700, 4433218, 2414465, 1225935, 2572079,2154946, 1469720, 1395502, 3284156, 4202352, 5314794, 2401520, 1197687, 1471282, 4727255,1519856, 723970)
Genome_Size

#Notice a few things:
  
#  1. The name `Genome_Size` is the name of the vector containing genome sizes. 

#  2. The R function `c()` is used to <i>concatenate</i> several data values into one vector. 

#  3. To see what is in an object like `Genome_Size`, just type the name. 

#  4. When R displays the values of an object like `Genome_Size`,it indicated in square brackets the position of the first data value displayed on a line. For example, `[14]` next to the data value `3284156` indicates that this is the fourtenth value in the `Genome_Size` data vector. 

#It is important to note that objects in R are case sensitive:
  
Genome_size
genome_size
genome_Size

# Let's make another data vector for `Gene_Count`:

Gene_Count = c(4837,1805,2395,2186,1613,4403,3843,2079,1157,2100,2317,1647,1517,3249,4239,5452,2738,1006,1335,4686,1690,734)
Gene_Count

#The `Genome_Size` vector contains all numbers, or numericals. Data vectors can also contain character data or logical data. For example, if we wanted a vector containing the phyla for each of the genomes we are interested in:

Phyla = c("Acidobacteria","Actinobacteria","Actinobacteria","Actinobacteria","Aquificae","Bacteroidetes","Bacteroidetes", "Chlamydiae","Chlamydiae","Chlorobi","Chlorobi","Chloroflexi","Chloroflexi","Deinococcus-Thermus", "Firmicutes","Firmicutes","Firmicutes","Proteobacteria","Proteobacteria","Proteobacteria","Spirochaetes","Tenericutes")
Phyla

#Note that the values are specified in quotes, telling R that these are <b>character</b> values.

#Importantly, data vectors can only hold <i>one</i> type of data value. For example, we can have a vector that holds both numeric values and character values. For example, suppose we tried to concatenate the two data vectors `Phyla` and `Genome_Size` into a vector called `Combined_Data`:

Combined_Data = c(Phyla, Genome_Size)
Combined_Data

# If vectors of different types are combined as in the example above, R will change them all to one type (known as <i>value coercion</i>). We can see here that R forced all of the numeric values for Genome_Size to character values, indicated by the quotes. The output type is determined from the highest type of the components in the hierarchy: `raw < logical < integer < double < complex < character < list`.

#You can always tell what data type is by using the ```class``` function:

class(Phyla)
class(Genome_Size)
class(Gene_Count)
class(Combined_Data)

#####Matrices
#So far, we have created three vector objects, `Phyla`, `Genome_Size`, and `Gene_Count`. It would be nice to have a data structure that could hold more than one variable. <b>Matrices</b> are one such structure. The R functions `matrix()`, `rbind()`, and `cbind()`, are all useful for creating matrices. 

#First, we will use the ```matrix()``` function to create a matrix with four rows and three columns containing the integers from 1 through 12. (Rather than typing the 12 numbers explicitly, we will use <i>series</i> notation `1:12`, which returns all twelve numbers - more on this later.)

mat1 = matrix(data = 1:12, nrow = 4, ncol = 3)
mat1

#Note that we specied the values to be entered in the matrix via the `data` argument,
#the number of rows via the `nrow` argument, and the number of columns via the `ncol`
#argument. 

#In `mat1` the matrix was filled "by column," i.e., the first column was filled with thefirst four numbers, the second column was filled with the next four numbers, etc. We
#can change this behavior by using the by row argument:

mat2 = matrix(data = 1:12, nrow = 4, ncol = 3, byrow = T)
mat2

#Now, let's make a matrix with the genome size and gene count data that we have currently in vector form. To do this we will use a combination of the `matrix()` and `c()` functions:
  
Genome_Numbers = matrix(data = c(Genome_Size, Gene_Count), nrow = 22)
Genome_Numbers

#This syntax can be a little tricky, because what is is first doing is <i>concatinating</i> the `Genome_Size` and `Gene_Count` vectors into one long vector of length 44 and <i>then</i> it is filling a matrix <i>by column</i> up to 22 rows. 

#The `rbind()` and `cbind()` function provide a somewhat easier and more intuitive way to join together several equal length vectors into a matrix:
  
Genome_Numers2 = cbind(Genome_Size, Gene_Count)
Genome_Numers2
Genome_Size Gene_Count

Genome_Numers3 = rbind(Genome_Size, Gene_Count)
Genome_Numers3

#Note one difference here: the column names or the row names are now the names of the original vectors.

#Again, it is important to note that all elements of matrices are requred to be the same type (just as vectors):
  
Genomes = cbind(Phyla,Genome_Size, Gene_Count)
Genomes

#####Data Frames

#Data frames are the most common way to organize several variables in a data set. Unlike matrices and vectors, the variables don't have to all be of the same type. Let's make a data frame containing all of the genome data:
  
Genomes.data = data.frame(Phyla, Genome_Size, Gene_Count)
Genomes.data

#Note that here `Phyla` has been converted from `character` to `factor`. We can see this by looking at the structure of the object using `str()`:

str(Genomes.data)

help(str) # What does this do again??

#We haven't talked about `factors` yet, but they are useful for handling nominal and ordered <i>categorical</i> data.  To avoid this you can set the `stringsAsFactors` argument to `FALSE`:

Genomes.data = data.frame(Phyla, Genome_Size, Gene_Count, stringsAsFactors=FALSE)
Genomes.data

str(Genomes.data)

# At this point you may wonder why R has matrices, since a data frame seems a lot like
# a matrix, but allows different types of variables. But R has powerful matrix functions
# that operate on matrices with numerical entries, that are of great use in statistical
# analysis. Examples include matrix algebra functions such as matrix multiplication,
# transpose, etc., computing eigenvalues, and much more (which we won't be able to get into
# today).

####Subscripting

#Data analysis often requires selecting and possibly altering specific variables, or specific cases. For example, it may be necessary to correct an error in the height of the third subject. Or it may be desired to select the first and third vairable for all subjects who are male. Or data may need conversion from degrees Celsius to degrees Fahrenheit. R has powerful subscripting capability for this purpose.

#Selecting specific elements of vectors and matrices is simple. Let's use the vector `Genome_Size` as example:

Genome_Size

#We can select an individual element from the vector:

Genome_Size[2]

#We can select the last element or the second to last element from the vector:

length(Genome_Size)  # returns the length of the vector
Genome_Size[length(Genome_Size)]

Genome_Size[length(Genome_Size)-1]

# We can select the entire vector, removing certain elements:

Genome_Size[-1]

#We can select multiple elements from the vector:

Genome_Size[1:5]

#Or remove multiple elements from the vector:

Genome_Size[-c(1:5)]

#Next, let's look at subscripting using a matrix as an example:
  
Genome_Numbers

#Selecting a single element in matrices always uses the notation `matrix[row,column]`:
  
Genome_Numbers[1,2] # Returns the gene count of the first genome

#We can return series of numbers, just as in vectors:
  
Genome_Numbers[1:5,2] # Returns the gene counts of the first five genomes

#We can select an indivudal row or column (note that this returns a vector):
  
Genome_Numbers[1,] # Return information on first Genome

Genome_Numbers[,1] # Return all genome sizes

#We can also select using the '-' notation like before:
  
Genome_Numbers[1,-2]

#Subscripting on `data frames` works the exact same way, except you can also select an element referring to the columns or rows by name. For example:
  
Genomes.data

Genomes.data["Phyla"]

Genomes.data[1:5,"Phyla"]

Genomes.data[1:5,c("Phyla","Gene_Count")]

#Data frames also can use the "dollar sign operator" to extract entire vectors:

Genomes.data$Phyla

Genomes.data$Phyla[1:5]

####R Workspace and Working Directory

#Before we go any further, let's talk about the <i>R workspace</i>. During an R session, objects are create and stored by name. The collections of objects currently stored is refered to as the <i>workspace</i>. To display all of the objects currently in the workspace use the function `ls()`:

ls()

#You can remove objects from your workspace using the ```rm()``` function:

rm(mat1,mat2)

ls()

#All of the objects in workspace can be stored permanently in a file for use in future R sessions in a `.RData` file. You can do this using the `save.image()` function. In a future R session, you can then load the workspace using the `load()` function:

save.image("img_genomes.RData")
load("img_genomes.RData")

#It is important to note that when saving your workspace using the `save.image()` function, if you don't use a full path, it will save it to your current <i>working directory</i>. This is just the path where R thinks you are working. You can check where your current working directory is using `getwd()`:
  
getwd()

#and you can set your working directory using `setwd()`:
  
setwd("/Users/mgibson/Documents/swcarpentry/2014-01-08-iastate/lessons/swc-r/data/")
getwd()

####Data I/O

#Up until now, we have been importing data into R using the command line interface. We can also read data in directly from a spreadsheet using the function `read.table()` and export data from R using the `write.table()` function.

#The `read.table()` funciton is the workhorse for reading data into R. At its simplest, the user need only specify the name of the file containing the data. Note that the file may be specified, for example, via a URL. The function `read.table()` always creates a data frame.

#For example, we had been working with a small subset of the genome metadata from IMG. If we wanted to load the entire table to work with, we could do so using the `read.table()` function:
  
microbial_genomes = read.table("microbial_genome.txt", header=T, sep="\t")
microbial_genomes[1:5,1:5]

#The first argument specifies the location of the file, in this case it is a URL pointing to a file on a web server. The second argument, `header=T` tells R that the first line of the file contains variable names. The third argument tells R what character separates fields for an observation. The default for this is any blank space. This can also be useful if you want to read in `.csv` files as you can set `sep=","`. 

#Again, by default `read.table()` converts character variables into factors. Usually this doesn't present problems, but sometimes users do not want this behavior, so you can set `stringsAsFactors = F`, just as we did with `data.frame()` above.

#The funciton `write.table()` is the export counterpart to `read.table()`. For example, if we wanted to then write the data frame we just imported to a file, we could do:

write.table(microbial_genomes, "microbial_genomes.txt", sep="\t", row.names = F)

#This will write the data frame `img_genomes` to the files `img_genomes.txt` and fields will be separated by `"\t"`. The last argument is important if the rows for your data frame are not named, the default for `rows.names = T`.

### 3. Control Structures and Functions ###

####Control Structures

#R has all of the same control structures as most programming languages, including `for` loops, `while` loops, and `if-else` statements. We will first introduce these as an understanding of them is important to understanding basic programming practices as well as common functions and practices commonly employed using R. R has additional function for implicit looping such as `tapply`, `apply`, and `lapply` that we will talk about in the next section. 

#####Iteration and Looping

#The `for` loop can be used to do something <i>for</i> all items in a vector or list:

#for (item in a_vector){
     # operate on item
#}

#The `while` loop can be used for doing something <i>while</i> a logical statement is TRUE:

#while (condition){
  # do something
  # update condition
#}

#####Branching and Conditional Statements
#Conditional statments allow us to execute a branch of code <i>if</i> a certain condition is satisfied. They also may include an <i>else</i> branch to be executed if the condition is not satisfied. 

#This is done with an `if` statement and in R it looks like this:

#if (condition) {
   #...
#}
#else {
   #...
#}

#The `ifelse` statement can operate on objects of variable length:

#ifelse(test, true_value, false_value)

#The condition is what we want to test if is TRUE and that is often done using locginal comparisons:

# | Operator  | Meaning      | 
# | --------- | -------------|
# | == | equality |
# | < | less than |
# | > | greater than |
# | <= | less than or equal to |
# | >= | greater than or equal to |
# 
# and binary operators:
# 
# | Operator  | Meaning      | 
# | --------- | -------------|
# | && | AND 
# | \|\| | OR 
# | ! | NOT 


#####An Example

#Using the `microbial_genomes` data frame that we imported using `read.table()`, let's calculate the average number of genes per genome for Proteobacteria and Actinobacteria genomes. 

#One way we could do this is looping through all of the rows in the data frame and acting on each one of them independently:
  
proteo_counts <- vector()
actino_counts <- vector()

for (entry_num in 1:length(microbial_genomes[,1])){
  if (microbial_genomes[entry_num, "Phylum"] == "Proteobacteria"){
    proteo_counts <- c(proteo_counts, microbial_genomes[entry_num, "Gene_Count"])
  }
  if (microbial_genomes[entry_num, "Phylum"] == "Actinobacteria"){
    actino_counts <- c(actino_counts, microbial_genomes[entry_num, "Gene_Count"])
  }
}

mean(proteo_counts)
mean(actino_counts)

####Functions
#Functions are blocks of code that allows R to be modular and facilitate code reuse. An R programmer can define their own function as follows:
  
#function_name <- function([arg1], [arg2],…){
  # function code body
#}

#Function arguments are the variables passed to the function, used by the function's code to perform clculations. 

#Note, that the function arguments are optional. For example, `ls()` is a function with no arguments. If we use `ls` without the parenthesis, it is no longer calling the function and has a different behavior. 

#A function can also return any object using the `return(object)` statement. 

#For example, let's wrap the piece of code that we wrote above into a function, so that we can calculate the average gene count for any phylum:
  
average_gene_count <- function(microbial_genomes, phyla){
  counts <- vector()
  for (entry_num in 1:length(microbial_genomes[,1])){
    if (microbial_genomes[entry_num, "Phylum"] == phyla){
      counts <- c(counts, microbial_genomes[entry_num, "Gene_Count"])
    }
  }
  return(mean(counts))
}

#We can now use this piece of code over and over again by just calling the funciton `average_gene_count()` and passing it the microbial_genomes dataset and the phyla we are interested in:
  
average_gene_count(microbial_genomes, phyla="Proteobacteria")
