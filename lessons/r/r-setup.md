R and RStudio Set Up
========================================================

## R and RStudio

  * Download and install [R, a free software environment for statistical computing and graphics](http://www.r-project.org) from [CRAN](http://cran.rstudio.com), the Comprehensive R Archive Network. It is __highly recommended__ to install a precompiled binary distribution for your operating system -- use the links up at the top of the CRAN page linked to above!

  * Install RStudio's IDE (stands for _integrated development environment_), a powerful user interface for R: <http://www.rstudio.com/ide/download/>

    - RStudio includes a __text editor__, so you do not have to install another stand-alone editor.
    - RStudio includes __an interface to Git and GitHub__. You will still need to install Git (covered elsewhere) but RStudio provides a basic GUI for interacting with Git(Hub).

## Testing testing

  * Do whatever is appropriate for your OS to launch RStudio. You should get a window similar to the screenshot you see [here](http://www.rstudio.com/ide/), but yours will be more boring because you haven't written any code or made any figures yet!

  * Put your cursor in the pane labelled Console, which is where you interact with the live R process. Create a simple object with code like `x <- 2 * 4` (followed by enter or return). Then inspect the `x` object by typing `x` followed by enter or return. Obviously you should see the value 8 print to screen. If yes, you are good to go.
  
  * *Write a test of whether RStudio and Git are talking to each other?*

## Add-on packages

R is an extensible system and many people share useful code they have developed as a _package_ via CRAN and github. To install a package from CRAN, for example the [`plyr`](http://plyr.had.co.nz)  package for data aggregation, here is one way to do it in the R console (there are others).

```
  install.packages("plyr", dependencies = TRUE)
```
By including `dependencies = TRUE`, we are being explicit and extra-careful to install any additional packages the target package, `plyr` in the example above, needs to have around.

Use the above method to install the following packages:

  * `plyr`, [package webpage](http://plyr.had.co.nz) 
  * `knitr` [package webpage](http://yihui.name/knitr/)

## Further resources

The above will get your basic setup ready but here are some links if you are interested in reading a bit further.

* How to Use RStudio:
    - <http://www.rstudio.com/ide/docs/>
* More RStudio Support:
  - <https://support.rstudio.com/hc/en-us>
* R Installation and Administration
    - <http://cran.r-project.org/doc/manuals/R-admin.html>
* R FAQ:
    - <http://cran.r-project.org/doc/FAQ/R-FAQ.html>
* More about add-on packages in the R Installation and Administration Manual
     - <http://cran.r-project.org/doc/manuals/R-admin.html#Add_002don-packages>
