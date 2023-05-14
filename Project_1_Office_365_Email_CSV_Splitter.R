#File: 11-20-2022 R-Studio Program Office 365 Email CSV Extractor.r
#Author: Albert Schultz
#Date: 11/20/2022
#Descriptions: This program imports, runs the extractions of the Office 365 Report Quarantine Raw csv files, and split them into individual csv files with proper naming convention for the DoD to review. 

#Import any library modules. 
library(dplyr)
library(readr)
library(tidyverse)
library(fs)

#Set current working directory to Downloads of user profile, absnd.
setwd("C:/Users/admin/Downloads")
getwd()

###################################Perform Data Imports########################################
#Create variables and import the raw csv file. 
Office_365_Report_CSV = read.csv("C:/Users/admin/Downloads/<files goes here>", header=TRUE, sep=",")

###################################Perform Data Cleaning and Pruning###########################
#Split the Office 365 items Based on threat types. 
Office_365_Threat_Phishing_Data = subset(Office_365_Report_CSV, Office_365_Report_CSV$Threats == "Phish")
Office_365_Threat_Phishing_and_Spam_Data = subset(Office_365_Report_CSV, Office_365_Report_CSV$Threats == "Phish, Spam")
Office_365_Threat_Malware_Data = subset(Office_365_Report_CSV, Office_365_Report_CSV$Threats == "Malware")

#Write to files in current directory of the split items from above.
write.csv(Office_365_Threat_Phishing_and_Spam_Data, file = "phishing_spam.csv",row.names = FALSE)
write.csv(Office_365_Threat_Phishing_Data, file = "phishing.csv",row.names = FALSE)
write.csv(Office_365_Threat_Malware_Data, file = "malware.csv",row.names = FALSE)

#Read the split CSV files by threat type back into the R-Studio as data frames. 
dfs_p = read.csv("phishing_spam.csv", header=TRUE)
dfm = read.csv("malware.csv", header=TRUE)
dfp = read.csv("phishing.csv", header=TRUE)

#Split the imported singled out CSV files based on threat types. 
split_dfs_p = split(dfs_p, dfs_p$Subject)
split_dfm = split(dfm, dfm$Subject)
split_dfp = split(dfp, dfp$Subject)

###################################Perform Data Outputs and Presentation Files###################
#Run individual objects for malware emails. 
for(i in 1:length(split_dfm))
{
  filename <- paste0("2023-01-30 Malware ", i, ".csv")
  write.csv(split_dfm[[i]], filename)
}

#Run individual objects for phishing emails. 
for(i in 1:length(split_dfp))
{
  filename <- paste0("2023-01-30 Phish ", i, ".csv")
  write.csv(split_dfp[[i]], filename)
}

#Run individual objects for phishing and spamming emails. 
for(i in 1:length(split_dfs_p))
{
  filename <- paste0("2023-01-30 Phish and Spam ", i, ".csv")
  write.csv(split_dfs_p[[i]], filename)
}

print("Program has ended.")