Reading Data into R
================
Mwangi George
2022-10-14

-   <a href="#1-reading-r-data-files" id="toc-1-reading-r-data-files">1.
    Reading R Data Files</a>
-   <a href="#2-reading-delimited-data-files"
    id="toc-2-reading-delimited-data-files">2. Reading Delimited Data
    Files</a>
-   <a href="#3-reading-excel-data-files-xlsx-or-xls"
    id="toc-3-reading-excel-data-files-xlsx-or-xls">3. Reading Excel Data
    Files (XLSX or XLS)</a>

### 1. Reading R Data Files

(i). RData Files

Function: load()

`load("survey.rdata")`

Or

`load("survey.rda")`

(ii). RDS Files

Function: readRDS()

`dataRDS <- readRDS("survey.rds")`

### 2. Reading Delimited Data Files

(i). Space-Delimited

Function: read.table()

`read.table("C:/mydata/survey.dat", header=TRUE, sep= " ")`

(ii). Tab-Delimited

Functions: read.table()

`read.table("survey.dat", header=TRUE, sep= "\t")`

(iii). Comma-Delimited

Function: read.csv()

`read.csv("survey.csv", header=TRUE)`

or Using readr package:

`read_csv("survey.csv")`

(iv). Fixed-Width Formats

Function: read.fwf()

`read.fwf("survey.txt", header=TRUE)`

### 3. Reading Excel Data Files (XLSX or XLS)

1.  EXCEL

Function: read_excel()

`read_excel(“survey.xlsx”, sheet = “sheetname”)`

`read.xlsx(”file path”, detectDates =T)`
