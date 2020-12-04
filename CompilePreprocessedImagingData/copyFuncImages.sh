#!/bin/bash

dir="$1"
subj="$2"
ses="$3"

echo "DataDir:" $dir
echo "Subject:" $subj
echo "Session:" $ses

#ANAT=$dir/$subj/AFNI_Preprocess/b$subj.results/anat_final.b$subj+tlrc
#MASK=$dir/$subj/AFNI_Preprocess/b$subj.results/mask_anat.b$subj+tlrc


FUNC=${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}+tlrc
MASK=${dir}/${subj}_ses${ses}.results/mask_group+tlrc

#3dAFNItoNIFTI -prefix anat_final.b$subj+tlrc.nii.gz $ANAT[0]
#3dAFNItoNIFTI -prefix mask_anat.b$subj+tlrc.nii.gz $MASK[0]

#Convert sub-briks to NIFTI
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_F_tstat.nii.gz $FUNC[1]
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_I_tstat.nii.gz $FUNC[4]
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_L_tstat.nii.gz $FUNC[7]
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_S_tstat.nii.gz $FUNC[10]
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_I-F_tstat.nii.gz $FUNC[13]
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_S-F_tstat.nii.gz $FUNC[16]
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_L-F_tstat.nii.gz $FUNC[19]
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_S-I_tstat.nii.gz $FUNC[22]
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_L-I_tstat.nii.gz $FUNC[25]
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/stats.${subj}_ses${ses}_L-S_tstat.nii.gz $FUNC[28]

#Convert Mask to NIFTI
3dAFNItoNIFTI -prefix ${dir}/${subj}_ses${ses}.results/mask.${subj}_ses${ses}.nii.gz $MASK

