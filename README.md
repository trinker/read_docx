A function develope by [Bryan Goodrich](https://www.linkedin.com/in/bryangoodrich) for reading .docx files into R:

**The Code**


```r
read_docx <- function (file, skip = 0) {
    tmp <- tempfile()
    if (!dir.create(tmp)) 
        stop("Temporary directory could not be established.")
    unzip(file, exdir = tmp)
    xmlfile <- file.path(tmp, "word", "document.xml")
    doc <- XML::xmlTreeParse(xmlfile, useInternalNodes = TRUE)
    unlink(tmp, recursive = TRUE)
    nodeSet <- XML::getNodeSet(doc, "//w:p")
    pvalues <- sapply(nodeSet, XML::xmlValue)
    pvalues <- pvalues[pvalues != ""]
    if (skip > 0) pvalues <- pvalues[-seq(skip)]
    pvalues
}
```

**In Action...**


```r
library(qdapRegex); library(qdap)
input <- rm_non_ascii(read_docx("LRA2014AdvocacyProposal.docx"))
rm_citation(unbag(input), extract=TRUE)
```

```
## [[1]]
##  [1] "Delpit, 1992"                                   
##  [2] "Kretovic, 1985"                                 
##  [3] "Lankshear & Knobel, 1998"                       
##  [4] "Smagorinsky, 2001"                              
##  [5] "Street, 1984"                                   
##  [6] "Baumgartner & Jones, 1993"                      
##  [7] "Hill, 2001"                                     
##  [8] "Coleman, 1990"                                  
##  [9] "Leana & Pil, 2006"                              
## [10] "Pil & Leana, 2009"                              
## [11] "Scherff, 2012"                                  
## [12] "Schmidt & Whitmore, 2010"                       
## [13] "Simon, Campano, Yee, Ghiso, Snchez, & Low, 2012"
## [14] "Broderick, & Pantoja, 2012"
```
