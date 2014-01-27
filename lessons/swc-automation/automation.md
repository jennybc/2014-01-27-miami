---
layout: lesson
root: ../..
title: Miami Bootcamp Group Exercise Tutorial
---

# Automation

##How to write and execute an R script on the command line

An R script can be written in any text editor.  For example, here is a simple R script that you can write and save as test.R.

    #!/usr/bin/Rscript

    cat("Hello world", sep="\n")

To run this script on the command line, you could type:

    Rscript test.R

And you should see the output as:

    Hello world

Sometimes you want to be able to pass values to an R script that are manipulated by your program.  To do this, we could use the following and save it in a script called test-args.R:

    #!/bin/usr/Rscript

    args <- commandArgs(TRUE) #tells R your going to be passing arguments
    cat(args[1], sep="\n")
    cat(args[2], sep="\n")
    cat(args[3], sep="\n")

Then when we execute this script with arguments passed, like so:

    Rscript test-args.R one two three

Or...

    Rscript test-args.R 1 2 3

It will return as an output the first three arguments.

## How to execute multiple commands in a bash script.
 
If you have multiple commands that you want to execute in a file, you can put them in a script file like so, saving it as "test.sh"...

    #!/bin/usr/bash

    echo "Hello World!"
    echo "Hello Universe!"
    echo "Hello Galaxy!"

To execute this file:

    bash test.sh

## For loops in the shell
 
Here's an example of how to do a for loop in the shell.

    for x in 1 2 3; do echo $x; done

The output will be as follows:
    
    1
    2
    3

Note that the "x" defines the variable which is then referred to in the subsequent loop as "$x".  After the initiation of the for loop, you must have  "do" prior to any commands on this variable.  In this example, the command is simply "echo".  The "done" indicates that the for loop is complete.  This looks similar to for loops in R, right?


##Challenge Exercise (integrating two days of bootcamping)
 
###  Obtain a version controlled dataset

I have placed a dataset on my github repo in a specific branch called R-Workshop.  You need to obtain this data, you can see it here:  https://github.com/adina/2014-01-08-iastate/tree/R-workshop/day2.automation.  Note:  You might already have this cloned, just update the repo if that is the case.
 
###  Explore this data.  

Using shell commands, take a look at any of these data files.  They contain the year, country, and number of gold, silver, and bronze medals earned.  For medals_2000.txt results file, use shell commands to identify the largest number of gold medals earned and by which country.
 
###  Write a script to do data analysis.  

Write a function in R to calculate the average number of gold medals earned for the year 2000.  Now, place this function in a script where the input is the file name and the output is the average gold medal result.  Execute this script on the command line for at least 3 files.
 
###  Using a for loop, create a bash file with all the commands to execute this program for all medal files.  Hint:  You can incorporate shell commands into your for loop.  
    
     for x in medals_*.txt; do echo $x; done >> test.txt
###  Execute the bash file.
 
Save the results to a new file called "summary.txt".  Find the maximum average gold medals during this time.

Look!  You've used version control, shell, R, and automation if you've successfully done this.  Hopefully this helps you do your work more efficiently when you have a lot of files with similar analysis.  It also helps you document your work when you have a bash file you can look back to as to what you did.  



