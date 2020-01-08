
#FIRST PARSE ONLY#
finalworkbook<-NULL
###SPS Document Parser###
library(readtext)
library(XML)
library(qdap)
library(pdftools)
library(readxl)
#IF NA#
na<-c("NA","NA","NA","NA","NA","NA","NA","NA","NA","NA")
finalworkbook<-rbind(finalworkbook,na)
Report <- read_excel("C:/Users/Prachi/Documents/Brazil SPS data.xlsx", sheet="Sheet2",col_names = FALSE)
#Parsing document data#
for(i in 1580:1643){
z1<-as.character(Report[i,])
doc.text<-readtext(unlist(z1))$text
doc.parts <- strsplit(doc.text, "\n")[[1]]
##Parsing Character Locations##
country.loc<-grep("Notifying Member:",doc.parts)[1]
agency.loc<-grep("Agency",doc.parts)[1]
products.loc<-grep("Products covered", doc.parts)[1]
affected.loc<-grep("Regions or countries",doc.parts)[1]
title.loc<-grep("Title",doc.parts)[1]
#description.loc<-grep("Descripción",doc.parts)[1]
description.loc<-grep("Description of content:",doc.parts)[1]
nature.loc<-grep("Nature of the urgent",doc.parts)[1]
obj.loc<-grep("Objective and rationale:",doc.parts)[1]
standard.loc<-grep("international standard",doc.parts)[1]
relevant.loc<-grep("Relevant documents", doc.parts)[1]
#Pasting Data into txt with respect to Location Entries#
#country.text<-paste(doc.parts[country.loc:(agency.loc-1)], collapse=" ")
agency.text<-paste(doc.parts[agency.loc:(products.loc-1)], collapse=" ")
products.text<-paste(doc.parts[products.loc:(title.loc-1)]  , collapse=" ")#change title to affected#
#affected.text<-paste(doc.parts[affected.loc:(title.loc-1)], collapse=" ")
title.text<-paste(doc.parts[title.loc:(description.loc-1)], collapse=" ")
description.text <- paste(doc.parts[description.loc:(obj.loc-1)], collapse=" ")
obj.text<-paste(doc.parts[obj.loc:(standard.loc-1)], collapse=" ")
standards.text<-paste(doc.parts[standard.loc:(relevant.loc-1)],collapse=" ")
#Printing into final workbook#
result<-cbind(country.text,agency.text,products.text,affected.text,title.text,description.text,obj.text,standards.text)
#END HERE ON FIRST PARSE##
finalworkbook<-rbind(finalworkbook,result)
}
#Creating Output
write.csv(finalworkbook,file="brazilspsoutput.csv")

