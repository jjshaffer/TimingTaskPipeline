
prefix = 'BD_TMSvSHAM_Timing_Long-Imm'
y = combineSlices(prefix, 61);
out = makeImages(strcat(prefix,'_results.mat'), prefix, 'names.txt', 'TimingTask_Func_NIFTI_Header_Template.nii.gz');
out = runFDRCorrection(strcat(prefix,'_GroupxSession_p.mat'), 'BDvHC_Onset_Mask_17-Aug-2020.mat', strcat(prefix,'_GroupxSession'), 'TimingTask_Func_NIFTI_Header_Template.nii.gz');


prefix = 'BD_TMSvSHAM_Timing_Long-Fix'
y = combineSlices(prefix, 61);
out = makeImages(strcat(prefix,'_results.mat'), prefix, 'names.txt', 'TimingTask_Func_NIFTI_Header_Template.nii.gz');
out = runFDRCorrection(strcat(prefix,'_GroupxSession_p.mat'), 'BDvHC_Onset_Mask_17-Aug-2020.mat', strcat(prefix,'_GroupxSession'), 'TimingTask_Func_NIFTI_Header_Template.nii.gz');



prefix = 'BD_TMSvSHAM_Timing_Long-Short'
y = combineSlices(prefix, 61);
out = makeImages(strcat(prefix,'_results.mat'), prefix, 'names.txt', 'TimingTask_Func_NIFTI_Header_Template.nii.gz');
out = runFDRCorrection(strcat(prefix,'_GroupxSession_p.mat'), 'BDvHC_Onset_Mask_17-Aug-2020.mat', strcat(prefix,'_GroupxSession'), 'TimingTask_Func_NIFTI_Header_Template.nii.gz');


prefix = 'BDvHC_Timing_Long-Imm'
y = combineSlices(prefix, 61);
out = makeImages(strcat(prefix,'_results.mat'), prefix, 'names2.txt', 'TimingTask_Func_NIFTI_Header_Template.nii.gz');
out = runFDRCorrection(strcat(prefix,'_BD_p.mat'), 'BDvHC_Onset_Mask_17-Aug-2020.mat', strcat(prefix,'_BD'), 'TimingTask_Func_NIFTI_Header_Template.nii.gz');

prefix = 'BDvHC_Timing_Long-Fix'
y = combineSlices(prefix, 61);
out = makeImages(strcat(prefix,'_results.mat'), prefix, 'names2.txt', 'TimingTask_Func_NIFTI_Header_Template.nii.gz');
out = runFDRCorrection(strcat(prefix,'_BD_p.mat'), 'BDvHC_Onset_Mask_17-Aug-2020.mat', strcat(prefix,'_BD'), 'TimingTask_Func_NIFTI_Header_Template.nii.gz');

prefix = 'BDvHC_Timing_Long-Short'
y = combineSlices(prefix, 61);
out = makeImages(strcat(prefix,'_results.mat'), prefix, 'names2.txt', 'TimingTask_Func_NIFTI_Header_Template.nii.gz');
out = runFDRCorrection(strcat(prefix,'_BD_p.mat'), 'BDvHC_Onset_Mask_17-Aug-2020.mat', strcat(prefix,'_BD'), 'TimingTask_Func_NIFTI_Header_Template.nii.gz');