# R Programs Portfolio

<p>This repository contains r-scripts that I have created to brush and stay current with R statistical language in the realm of Data Science and Automation for data import, extractions, cleaning, exploratory, and visualizations.</p>

<h2>1. <a href="https://github.com/absndus/R_Projects_Portfolio_Repository/blob/main/Project_1_Office_365_Email_CSV_Splitter.R">Project 1 Office 365 Security Email Quarantine Type Sorting Script</a></h2>
<br>
<br>
<a href="https://github.com/absndus/R_Projects_Portfolio_Repository/blob/main/Screenshots/Screenshot_1_Office_Email_365_Quarantine_CSV_Splitter.png">
  <img src="https://github.com/absndus/R_Projects_Portfolio_Repository/blob/main/Screenshots/Screenshot_1_Office_Email_365_Quarantine_CSV_Splitter.png" alt="Screenshot">
  </a>
<p><b>Description:</b> This program imports the raw Office 365 Security Quarantine observation rows that has been set to a range of dates (i.e. May 31,2022 to August 23, 2022) and the delivery type to, quarantined. The user would export the raw data csv file from the admin console and move the file into the working directory of the R-Studio. The R-Script program automatically sort the quarantine observations based on the types of quarantine email issues and split those into several CSV files that represents the email issues such as malware, phishing, spam, spam and phishing email types. Once completed, the script imports the cleaned CSVs back into the R-studio and split those up by email recipient and then split them up into smaller csv file that contained only the same email recipient based on threat email type.
</p>

<p><b>Noticeable Metric:</b> Saved the company several weeks of email quarantine security reporting work each month by slashing the time by 95% due to repetitive consuming nature of generating the Office 365 email reports to the DCSA (US agency). For example, on average, it took about a couple weeks to a month to sort out 2,534 various quarantine rows of items into separate proper csv files for proper security reporting. When using the R-Script by importing the raw file, it took several minutes to generate the necessary csv files needed to be zipped and provided to my security team for export to the DoD.</p>

<h2>2. <a href="https://github.com/absndus/R_Projects_Portfolio_Repository/blob/main/Project_2_Vehicles_Info_Extractor.R">Project 2 Vehicle Information Extraction Script</a></h2>
<br>
<a href="https://github.com/absndus/R_Projects_Portfolio_Repository/blob/main/Screenshots/Screenshot_2_Vehicle_Information_Extraction_Quad_Graphs.png">
  <img src="https://github.com/absndus/R_Projects_Portfolio_Repository/blob/main/Screenshots/Screenshot_2_Vehicle_Information_Extraction_Quad_Graphs.png" alt="Screenshot">
</a>
<br>
<p><b>Description:</b> This program imports the raw csv file from the UCI Machine Learning library website at <url>https://archive.ics.uci.edu/ml/datasets/Automobile</url> and converts it into a data frame to be later extracted into meaningful information about the vehicle's mileage, miles per gallon, the various classes of vehicles, and vehicles' engine types that were graphed.
</p>

<p><b>Noticeable Metric:</b> Learned how to managed raw csv files from external sources on the internet and easily create meaningful graphs to answer stakeholders' questions about vehicles and their likings of classic vehicles.</p>
