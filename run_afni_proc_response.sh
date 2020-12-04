#!/usr/bin/env tcsh

#This script will run preprocessing using AFNI. It uses the NIFTI formatted images along with the output of FreeSurfer
#Author: Joe Shaffer
#Date: March, 2017
# created by uber_subject.py: version 0.37 (April 14, 2015)
# creation date: Fri Oct  7 15:05:42 2016

set rootdir=$1
set datadir=$2
set subject=$3
set session=$4
set run1=$5
set run2=$6
set run3=$7
set run4=$8

echo Subject:$subject
echo Session:$session

set currdir=`pwd`
#echo $currdir
#echo "$rootdir"
#echo "$subject"
    
# set data directories
set top_dir   = ${rootdir}/${datadir}
set anat_dir  = ${top_dir}/sub-${subject}/ses-${session}/anat
set epi_dir   = ${top_dir}/sub-${subject}/ses-${session}/func

#set stim_dir  = ${rootdir}/BEHAV/sub-${subject}/ses-${session}/onset
set stim_dir  = ${rootdir}/BEHAV/sub-${subject}/ses-${session}/response
echo $stim_dir

set fs_dir = ${rootdir}/derivatives/FreeSurfer/sub-${subject}_ses-${session}/SUMA

# set subject and group identifiers
set subj      = ${subject}_ses${session}
set group_id  = b

    echo $subj
   
#echo ${rootdir}
mkdir -p ${rootdir}/derivatives/TimingTask_Response
cd ${rootdir}/derivatives/TimingTask_Response

#mkdir -p ${rootdir}/derivatives/TimingTask_Onset
#cd ${rootdir}/derivatives/TimingTask_Onset

afni_proc.py -subj_id $subj                                                  \
-script proc.$subj -scr_overwrite                                     \
-blocks tshift align tlrc volreg blur mask scale regress              \
-copy_anat ${fs_dir}/T1.nii                                 \
-tcat_remove_first_trs 0                                              \
-anat_has_skull yes                                                      \
    -dsets $epi_dir/sub-${subject}_ses-${session}_task-timing_run-1_bold.nii.gz  \
	   $epi_dir/sub-${subject}_ses-${session}_task-timing_run-2_bold.nii.gz \
	   $epi_dir/sub-${subject}_ses-${session}_task-timing_run-3_bold.nii.gz \
	   $epi_dir/sub-${subject}_ses-${session}_task-timing_run-4_bold.nii.gz \
-tlrc_base MNI_avg152T1+tlrc                                          \
-volreg_align_to first                                                \
-volreg_align_e2a                                                     \
-volreg_tlrc_warp                                                     \
-blur_size 6.0                                                        \
-regress_stim_times ${stim_dir}/stim.sub-${subject}_ses-${session}-r*.1D                   \
-regress_stim_labels                                                  \
f 0 12 3                                                       \
-regress_basis 'GAM'                                                  \
-regress_censor_motion 0.3                                            \
-regress_opts_3dD                                                     \
-gltsym 'SYM: 0 -f' -glt_label 1 Imm-Fix            \
-gltsym 'SYM: 3 -f' -glt_label 2 Short-Fix          \
-gltsym 'SYM: 12 -f' -glt_label 3 Long-Fix          \
-gltsym 'SYM: 3 -0' -glt_label 4 Short-Imm         \
-gltsym 'SYM: 12 -0' -glt_label 5 Long-Imm         \
-gltsym 'SYM: 12 -3' -glt_label 6 Long-Short       \
-regress_reml_exec                                                    \
-regress_make_ideal_sum sum_ideal.1D                                  \
-regress_est_blur_epits                                               \
-regress_est_blur_errts                                               \
-regress_run_clustsim no


tcsh proc.${subj}

#-dsets $epi_dir/sub-${subject}_ses-${session}_task-timing_run-*_bold.nii.gz  \
