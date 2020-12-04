#!/bin/bash


#3dAllineate -base anatomical2_MNI.nii.gz \
#-input anatomical2.nii.gz -float \
#-prefix anatomical_MNI.nii.gz \
#-1Dmatrix_save MNI_Transform.1D

#CONTRAST=SCZ_TMSvSHAM_Timing_Long-Short
#CONTRAST=SCZ_TMSvSHAM_Timing_Long-Imm
CONTRAST=SCZ_TMSvSHAM_Timing_Long-Fix

#prefix1=${CONTRAST}_${CONTRAST}_t
#echo $prefix1

#3dAllineate -base anatomical2_MNI.nii.gz \
#-input ${prefix1}.nii.gz -float \
#-prefix ${prefix1}_MNI.nii.gz \
#-1Dmatrix_apply MNI_Transform.1D

3dbucket -prefix ${CONTRAST}_BUCKET_FDR.nii.gz \
${CONTRAST}_GroupxSession_t.nii.gz \
${CONTRAST}_GroupxSession_1-p.nii.gz \
${CONTRAST}_GroupxSession_1-pImage_FDR.nii.gz \
${CONTRAST}_Group_t.nii.gz \
${CONTRAST}_Group_p.nii.gz \
${CONTRAST}_Group_1-p.nii.gz \
${CONTRAST}_Session_t.nii.gz \
${CONTRAST}_Session_p.nii.gz \
${CONTRAST}_Session_1-p.nii.gz \
${CONTRAST}_Age_t.nii.gz \
${CONTRAST}_Age_p.nii.gz \
${CONTRAST}_Age_1-p.nii.gz \
${CONTRAST}_Sex_t.nii.gz \
${CONTRAST}_Sex_p.nii.gz \
${CONTRAST}_Sex_1-p.nii.gz \
${CONTRAST}_Omnibus_t.nii.gz \
${CONTRAST}_Omnibus_p.nii.gz \
${CONTRAST}_Omnibus_1-p.nii.gz


3drefit -relabel_all 'labels1.txt'  ${CONTRAST}_BUCKET_FDR.nii.gz

3drefit -space MNI -xdel 3 -ydel 3 -zdel 3 -xorigin 90 -yorigin 126 -zorigin 72 ${CONTRAST}_BUCKET_FDR.nii.gz

#Group Contrast

#CONTRAST=SCZvHC_Timing_Long-Short
#CONTRAST=SCZvHC_Timing_Long-Imm
CONTRAST=SCZvHC_Timing_Long-Fix

3dbucket -prefix ${CONTRAST}_BUCKET_FDR.nii.gz \
${CONTRAST}_SCZ_t.nii.gz \
${CONTRAST}_SCZ_1-p.nii.gz \
${CONTRAST}_SCZ_1-pImage_FDR.nii.gz \
${CONTRAST}_Group_t.nii.gz \
${CONTRAST}_Group_p.nii.gz \
${CONTRAST}_Group_1-p.nii.gz \
${CONTRAST}_Session_t.nii.gz \
${CONTRAST}_Session_p.nii.gz \
${CONTRAST}_Session_1-p.nii.gz \
${CONTRAST}_Age_t.nii.gz \
${CONTRAST}_Age_p.nii.gz \
${CONTRAST}_Age_1-p.nii.gz \
${CONTRAST}_Sex_t.nii.gz \
${CONTRAST}_Sex_p.nii.gz \
${CONTRAST}_Sex_1-p.nii.gz \
${CONTRAST}_Omnibus_t.nii.gz \
${CONTRAST}_Omnibus_p.nii.gz \
${CONTRAST}_Omnibus_1-p.nii.gz


3drefit -relabel_all 'labels2.txt'  ${CONTRAST}_BUCKET_FDR.nii.gz

3drefit -space MNI -xdel 3 -ydel 3 -zdel 3 -xorigin 90 -yorigin 126 -zorigin 72 ${CONTRAST}_BUCKET_FDR.nii.gz
