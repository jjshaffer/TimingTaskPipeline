#!/bin/bash

#Script for combining separate statistical images into a "BUCKET" file to allow for thresholding with AFNI

CONTRAST='_Timing_Onset_Long-Imm'
#CONTRAST='_Timing_Onset_Long-Fix'
#CONTRAST='_Timing_Response_Long-Imm'
#CONTRAST='_Timing_Response_Long-Fix'

PREFIX='BD_TMSvSHAM'${CONTRAST}

3dbucket -prefix ${PREFIX}_BUCKET_FDR.nii.gz \
${PREFIX}_SessionxTMS_t.nii.gz \
${PREFIX}_SessionxTMS_p.nii.gz \
${PREFIX}_SessionxTMS_1-p.nii.gz \
${PREFIX}_SessionxTMS_pImage_FDR.nii.gz \
${PREFIX}_SessionxTMS_1-pImage_FDR.nii.gz \
${PREFIX}_Group_t.nii.gz \
${PREFIX}_Group_p.nii.gz \
${PREFIX}_Group_1-p.nii.gz \
${PREFIX}_Session_t.nii.gz \
${PREFIX}_Session_p.nii.gz \
${PREFIX}_Session_1-p.nii.gz \
${PREFIX}_Age_t.nii.gz \
${PREFIX}_Age_p.nii.gz \
${PREFIX}_Age_1-p.nii.gz \
${PREFIX}_Sex_t.nii.gz \
${PREFIX}_Sex_p.nii.gz \
${PREFIX}_Sex_1-p.nii.gz \
${PREFIX}_Omnibus_t.nii.gz \
${PREFIX}_Omnibus_p.nii.gz \
${PREFIX}_Omnibus_1-p.nii.gz


3drefit -relabel_all 'labels1.txt' ${PREFIX}_BUCKET_FDR.nii.gz

3drefit -space MNI -xorigin 90 -yorigin 126 -zorigin 72 ${PREFIX}_BUCKET_FDR.nii.gz
3drefit -xdel 3 -ydel 3 -zdel 3 ${PREFIX}_BUCKET_FDR.nii.gz


### Do Group vs HC comparison next
PREFIX='BDvHC'${CONTRAST}

3dbucket -prefix ${PREFIX}_BUCKET_FDR.nii.gz \
${PREFIX}_Group_t.nii.gz \
${PREFIX}_Group_p.nii.gz \
${PREFIX}_Group_1-p.nii.gz \
${PREFIX}_Group_pImage_FDR.nii.gz \
${PREFIX}_Group_1-pImage_FDR.nii.gz \
${PREFIX}_Group2_t.nii.gz \
${PREFIX}_Group2_p.nii.gz \
${PREFIX}_Group2_1-p.nii.gz \
${PREFIX}_Session_t.nii.gz \
${PREFIX}_Session_p.nii.gz \
${PREFIX}_Session_1-p.nii.gz \
${PREFIX}_Age_t.nii.gz \
${PREFIX}_Age_p.nii.gz \
${PREFIX}_Age_1-p.nii.gz \
${PREFIX}_Sex_t.nii.gz \
${PREFIX}_Sex_p.nii.gz \
${PREFIX}_Sex_1-p.nii.gz \
${PREFIX}_Omnibus_t.nii.gz \
${PREFIX}_Omnibus_p.nii.gz \
${PREFIX}_Omnibus_1-p.nii.gz


3drefit -relabel_all 'labels2.txt' ${PREFIX}_BUCKET_FDR.nii.gz

3drefit -space MNI -xorigin 90 -yorigin 126 -zorigin 72 ${PREFIX}_BUCKET_FDR.nii.gz
3drefit -xdel 3 -ydel 3 -zdel 3 ${PREFIX}_BUCKET_FDR.nii.gz
