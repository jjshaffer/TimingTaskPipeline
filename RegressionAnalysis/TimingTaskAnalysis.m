function x = TimingTaskAnalysis(i)

DATA_DIR ='/Shared/MRRCdata/SCZ_TMS_TIMING/scripts/FuncPipeline/RegressionAnalysis/';
%DATA_DIR ='/Volumes/mrrcdata/SCZ_TMS_TIMING/scripts/FuncPipeline/RegressionAnalysis/';



covars = 'SCZ_TMS_SessionList-03-Dec-2020.txt';
mask = 'SCZ_TMS_Mask_03-Dec-2020.mat';

data = strcat(DATA_DIR, 'SCZ_TMS_Onset-L-F_03-Dec-2020.mat');
batchTimingTaskContrast(i, covars, data, mask, 'SCZ_TMSvSHAM_Timing_Onset_Long-Fix', 'BOLD~TMS+Session+Age+Sex+(1|Subject)', 'BOLD~TMS*Session+Age+Sex+(1|Subject)', 'Session:TMS');

data = strcat(DATA_DIR, 'SCZ_TMS_Onset-L-I_03-Dec-2020.mat');
batchTimingTaskContrast(i, covars, data, mask, 'SCZ_TMSvSHAM_Timing_Onset_Long-Imm', 'BOLD~TMS+Session+Age+Sex+(1|Subject)', 'BOLD~TMS*Session+Age+Sex+(1|Subject)', 'Session:TMS');

data = strcat(DATA_DIR, 'SCZ_TMS_Response-L-F_03-Dec-2020.mat');
batchTimingTaskContrast(i, covars, data, mask, 'SCZ_TMSvSHAM_Timing_Response_Long-Fix', 'BOLD~TMS+Session+Age+Sex+(1|Subject)', 'BOLD~TMS*Session+Age+Sex+(1|Subject)', 'Session:TMS');

data = strcat(DATA_DIR, 'SCZ_TMS_Response-L-I_03-Dec-2020.mat');
batchTimingTaskContrast(i, covars, data, mask, 'SCZ_TMSvSHAM_Timing_Response_Long-Imm', 'BOLD~TMS+Session+Age+Sex+(1|Subject)', 'BOLD~TMS*Session+Age+Sex+(1|Subject)', 'Session:TMS');


%data = strcat(DATA_DIR, 'SCZ_TMS_Onset-L-S_03-Dec-2020.mat');
%batchTimingTaskContrast(i, covars, data, mask, 'SCZ_TMSvSHAM_Timing_Long-Short', 'BOLD~Group+Session+Age+Sex+(1|Subject)', 'BOLD~Group*Session+Age+Sex+(1|Subject)', 'Group:Session');


%SCZ vs HC

covars = 'SCZvHC_SessionList-03-Dec-2020.txt';
mask = 'SCZvHC_Mask_03-Dec-2020.mat';

data = strcat(DATA_DIR, 'SCZvHC_Onset-L-F_03-Dec-2020.mat');
batchTimingTaskContrast(i, covars, data, mask, 'SCZvHC_Timing_Onset_Long-Fix', 'BOLD~Age+Sex+(1|Subject)', 'BOLD~Group+Age+Sex+(1|Subject)', 'Group');

data = strcat(DATA_DIR, 'SCZvHC_Onset-L-I_03-Dec-2020.mat');
batchTimingTaskContrast(i, covars, data, mask, 'SCZvHC_Timing_Onset_Long-Imm', 'BOLD~Age+Sex+(1|Subject)', 'BOLD~Group+Age+Sex+(1|Subject)', 'Group');

data = strcat(DATA_DIR, 'SCZvHC_Response-L-F_03-Dec-2020.mat');
batchTimingTaskContrast(i, covars, data, mask, 'SCZvHC_Timing_Response_Long-Fix', 'BOLD~Age+Sex+(1|Subject)', 'BOLD~Group+Age+Sex+(1|Subject)', 'Group');

data = strcat(DATA_DIR, 'SCZvHC_Response-L-I_03-Dec-2020.mat');
batchTimingTaskContrast(i, covars, data, mask, 'SCZvHC_Timing_Response_Long-Imm', 'BOLD~Age+Sex+(1|Subject)', 'BOLD~Group+Age+Sex+(1|Subject)', 'Group');

%data = strcat(DATA_DIR, 'SCZvHC_Onset-L-S_03-Dec-2020.mat');
%batchTimingTaskContrast(i, covars, data, mask, 'SCZvHC_Timing_Long-Short', 'BOLD~Age+Sex+(1|Subject)', 'BOLD~Group+Age+Sex+(1|Subject)', 'Group');


x = 0;
end