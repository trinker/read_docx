read_docx <- function (file, skip = 0) {
    tmp <- tempfile()
    if (!dir.create(tmp)) stop("Temporary directory could not be established.")
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