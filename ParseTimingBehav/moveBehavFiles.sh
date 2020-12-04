#!/bin/bash

#Script for sorting behavioral files into a subject directory. This will create subdirectories for the first and second scan sessions as well, but does not name them with the appropriate session #. You will need to do that manually. 

#Cluster Path
#SHARE_DIR=/Shared/MRRCdata

#Local Path
SHARE_DIR=/Volumes/mrrcdata

PROJECT_DIR=${SHARE_DIR}/SCZ_TMS_TIMING
BIDS_DIR=${SHARE_DIR}/SCZ_TMS_TIMING/SCZ_TMS_data

subjId=$1

#Generate full subject ID
subjectID=sub-CBM${subjId}
#ID for controls
#subjectID=sub-CTL${subjId}
#Workaround for subjects from Bipolar_R01
#subjectID=sub-${subjId}

echo $subjectID

#Make directory for participant's behavioral data
#mkdir -p ${PROJECT_DIR}/BEHAV/$subjectID

#Find list of sessions from data directory
sessions=(${BIDS_DIR}/${subjectID}/*/)
numses=${#sessions[@]}
#echo $numses
postSes=0;
preSes=0;

#Loop through each session
for i in `seq 0 $(($numses-1))`
do

    #echo ${sessions[$i]}

    session=${sessions[$i]}

    #Trim / at end
    session=${session%*/}
    #Trim everything preceding -
    session=${session#*-}
    session=${session#*-}

    #echo $session

    if [[ $session > $postSes ]]
    then
	postSes=$session
	if [[ $preSes = 0 ]]
	then
	    preSes=$session
	fi
    else
	preSes=$session
    fi



done

echo pre: $preSes
echo post: $postSes

mkdir -p ${PROJECT_DIR}/BEHAV/${subjectID}/ses-${preSes}
mv ${PROJECT_DIR}/BEHAV/*-${subjId}-1* ${PROJECT_DIR}/BEHAV/${subjectID}/ses-${preSes}

if [[ $numses > 1 ]]
   then
       echo "Test"
       mkdir -p ${PROJECT_DIR}/BEHAV/${subjectID}/ses-${postSes}
       mv ${PROJECT_DIR}/BEHAV/*-${subjId}-2* ${PROJECT_DIR}/BEHAV/${subjectID}/ses-${postSes}

       fi
