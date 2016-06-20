#This shell gets the hospital files, unzips them, and for key files takes off the header row, renames them, and puts them into hdfs

#make the ex1 directory
mkdir -p /home/w205/hosp_temp

#get the file, renamed and in the temp directory
wget -O /home/w205/hosp_temp/hosp_dl.zip https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip 

#unzip the file
unzip /home/w205/hosp_temp/hosp_dl.zip  -d /home/w205/hosp_temp/

#strip heads and get ready to put into hdfs
mkdir -p /home/w205/hosp_temp/no_head
tail -n +2 /home/w205/hosp_temp/'Hospital General Information.csv' > /home/w205/hosp_temp/no_head/hospitals.csv 
tail -n +2 /home/w205/hosp_temp/'Timely and Effective Care - Hospital.csv' > /home/w205/hosp_temp/no_head/effective_care.csv 
tail -n +2 /home/w205/hosp_temp/'Readmissions and Deaths - Hospital.csv' > /home/w205/hosp_temp/no_head/readmissions.csv 
tail -n +2 /home/w205/hosp_temp/'Measure Dates.csv' > /home/w205/hosp_temp/no_head/Measures.csv 
tail -n +2 /home/w205/hosp_temp/'hvbp_hcahps_05_28_2015.csv' > /home/w205/hosp_temp/no_head/surveys_responses.csv

#make the hospital_compare directory
hdfs dfs -mkdir -p /user/w205/hospital_compare

#load raw (headerless) files into hdfs
hdfs dfs -put /home/w205/hosp_temp/no_head/* /user/w205/hospital_compare

#to check that they're there run 
#hdfs dfs -ls /user/w205/hospital_compare
