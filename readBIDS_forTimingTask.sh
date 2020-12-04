#!/bin/bash

i="$1"

#Cluster Path
SHARE_DIR=/Shared/MRRCdata

#Local Path
#SHARE_DIR=/Volumes/mrrcdata

PROJECT_DIR=${SHARE_DIR}/BD_TMS_TIMING

BIDS_DIR=${SHARE_DIR}/BD_TMS_TIMING/BD_TMS_data
FREESURFER_DIR=${SHARE_DIR}/BD_TMS_TIMING/derivatives/FreeSurfer



#Find all subjects in BIDS_DIR & sessions
subjects=(${BIDS_DIR}/*/)
numsubjs=${#subjects[@]}
#echo $numsubjs


#Loop through each subject
#for i in `seq 0 $(($numsubjs-1))`
#for i in `seq 0 0`
#do

#echo ${subjects[$i]}

subject=${subjects[$i]}

#Trim / at end
subject=${subject%*/}
#Trim everything preceding -
subject=${subject#*-}

echo $subject
#echo ${subjects[$i]}

#Loop through each imaging session
sessions=(${subjects[$i]}*/)
numses=${#sessions[@]}
#echo $numses


postSes=0;





for x in `seq 0 $(($numses-1))`
do

session=${sessions[$x]}

#Trim / at end
session=${session%*/}
#Trim everything preceding -
session=${session##*-}
#echo $session
ses[$j]=$session

if [[ $session > $postSes ]]
then
    postSes=$session
fi
done

#echo ${postSes}_post



#Create variables for storing scan info for each session

T1=()
T2=()
ses=()
rest=()
task=()
#rest=("", "", "")
#task=("","","","")



for x in `seq 0 $(($numses-1))`
do

T1[$x]="x"
T2[$x]="y"
ses[$x]=0

index0=$((3*$x))
index1=$((3*$x+1))
index2=$((3*$x+2))

rest[$index0]="a"
rest[$index1]="b"
rest[$index2]="c"

index0=$((4*$x))
index1=$((4*$x+1))
index2=$((4*$x+2))
index3=$((4*$x+3))

task[$index0]=""
task[$index1]=""
task[$index2]=""
task[$index3]=""

done



for j in `seq 0 $(($numses-1))`
do


#echo ${sessions[$j]}

session=${sessions[$j]}

#Trim / at end
session=${session%*/}
#Trim everything preceding -
session=${session##*-}
#echo $session


#Set session index
sessionIndex=0;
if [[ $session = $postSes ]]
then
    #echo $session
    sessionIndex=1;
fi
#echo $sessionIndex
ses[$sessionIndex]=$session

#Find anatomical files

#echo ${sessions[$j]}

files=(${sessions[$j]}anat/*)
numfiles=${#files[@]}
#echo $numfiles


for k in `seq 0 $(($numfiles-1))`
do

filepath=${files[$k]}

file=$(basename $filepath)

#echo $file

if [[ $file == *"T1w.nii.gz" ]]; then
    ##echo $filepath
    T1[$j]=$filepath
fi

if [[ $file == *"T2w.nii.gz" ]]; then
    ##echo $filepath
    T2[$j]=$filepath
fi

done #files

#Check if functional directory is named 'func' or 'fmri'. If the latter, change to 'func'
#if [ -d ${sessions[$j]}func ];
#then

#echo ${sessions[$j]}func

if [ -d ${sessions[$j]}fmri ];
then
#echo ${sessions[$j]}fmri
#Correct error in naming by moving files from "fmri" folder to "func" folder
mv ${sessions[$j]}fmri ${sessions[$j]}func

fi




#Get list of files in the func folder
files=(${sessions[$j]}func/*)
numfiles=${#files[@]}
#echo $numfiles
#echo $files



#Loop through each functional file
for k in `seq 0 $(($numfiles-1))`
do
filepath=${files[$k]}
file=$(basename $filepath)
#echo $file

if [[ $file == *"task-timing"*"bold.nii.gz" ]];
then
#echo ${file}_task
    if [[ $file == *"run-1"*.nii.gz ]];
    then
        task[$(($sessionIndex*4))]=$file

    elif [[ $file == *"run-2"*.nii.gz ]];
    then
        task[$(($sessionIndex*4+1))]=$file

    elif [[ $file == *"run-3"*.nii.gz ]];
    then
        task[$(($sessionIndex*4+2))]=$file

    elif [[ $file == *"run-4"*.nii.gz ]];
    then
        task[$(($sessionIndex*4+3))]=$file
    fi
fi
done #Loop through each file

done #session



#Extra code for dealing with lack of T2 image in first session and T1 in second session.

t1=$(basename ${T1[0]})
t1=${t1%%.*}
##echo$t1
t2=$(basename ${T2[1]})
t2=${t2%%.*}
##echo $t2

#done

#Run Freesurfer analysis
#bash run_FreeSurfer.sh ${BIDS_DIR} ${FREESURFER_DIR} ${subject} ${ses[0]} ${ses[1]} $t1 $t2

#echo "Freesurfer Complete"

for j in `seq 0 $(($numses-1))`
do
echo ${ses[$j]}



task1=${task[$(($j*4))]}
task2=${task[$(($j*4+1))]}
task3=${task[$(($j*4+2))]}
task4=${task[$(($j*4+3))]}

echo $task1
echo $task2
echo $task3
echo $task4


## Run AFNI Processing Steps on timing task runs
#tcsh run_afni_proc_onset.sh ${PROJECT_DIR} BD_TMS_data ${subject} ${ses[$j]} $task1 $task2 $task3 $task4
tcsh run_afni_proc_response.sh ${PROJECT_DIR} BD_TMS_data ${subject} ${ses[$j]} $task1 $task2 $task3 $task4


#bash AlignFuncImages.sh $FREESURFER_DIR ${PROJECT_DIR}/derivatives/TimingTask_Preprocess ${subject} ${ses[$j]} mni_icbm152_t1_tal_nlin_asym_09c.nii


done

#done #subject
