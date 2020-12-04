function out = read_all_FuncStats(index, prefix)

DATA_DIR='/Volumes/mrrcdata/BD_TMS_TIMING/derivatives/TimingTask_Preprocess';

%Image Index Reference
%0 Full_Fstat 
%1: fixed_Coef 2: fixed_Tstat 3: fixed_Fstat 
%4: immed Coef 5:immed Tstat 6: immed Fstat 
%7: long Coef 8: long Tstat 9: long Fstat 
%10:short Coef 11: short Tstat 12: short Fstat
%13: Imm-Fix Coef 14: Imm-Fix Tstat 15: Imm-Fix Fstat
%16: Short-Fix Coef 17: Short-Fix Tstat 18: Short-Fix Fstat
%19: Long-Fix Coef 20: Long-Fix Tstat 21: Long-Fix Fstat
%22: Short-Imm Coef 23: Short-Imm Tstat 24: Short-Imm Fstat
%25: Long-Imm Coef 26: Long-Imm Tstat 27: Long-Imm Fstat
%28 Long-Short Coef 29: Long-Short Tstat 30: Long-Short Fstat


matx = 193;
maty = 229;
matz = 193;
numStats=20;

SCANS = {'cbm0411', '20180620';
'cbm0411', '20180629';
'cbm0421', '20180725';
'cbm0421', '20180803';
'cbm0431', '20180809';
'cbm0431', '20180817';
'cbm0441', '20180919';
'cbm0441', '20180928';
'cbm0451', '20180927';
'cbm0451', '20181005';
'cbm0461', '20181025';
'cbm0461', '20181102';
'cbm0471', '20181106';
'cbm0471', '20181116';
'cbm0481', '20190114';
'cbm0481', '20190125';
'cbm0491', '20181213';
'cbm0491', '20181221';
'CBM0501', '20190131';
'CBM0501', '20190208';
'CBM0511', '20190206';
'CBM0511', '20190215';
'CBM0531', '20190307';
'CBM0531', '20190315';
'CBM0541', '20190318';
'CBM0541', '20190329';
'CBM0551', '20190425';
'CBM0551', '20190503';
'CBM0561', '20190619';
'CBM0561', '20190628';
'CBM0571', '20190725';
'CBM0571', '20190802';
'CBM0581', '20190823';
'CBM0581', '20190830';
'CBM0591', '20191001';
'CBM0591', '20191011';
'CBM0601', '20191105';
'CBM0601', '20191115'};

temp = length(SCANS);

imgData=zeros(matx, maty, matz, temp);
mask=zeros(matx, maty, matz);

for i = 1:temp
    dirname = strcat(DATA_DIR,'/',SCANS(i,1), '_ses', SCANS(i,2),'.results/sub-', SCANS(i,1), '_ses-', SCANS(i,2), '_MNIaligned_Stats.nii.gz');
    disp(dirname);
    
    dirname=char(dirname);
    data=load_nii(dirname);
    
    %size(data.img)
    
    %Save 3d image into structure with all subject images
    imgData(:,:,:,i) = data.img(:,:,:,index);
    
    %Add to count in mask for all non-zero voxels in image
    for x = 1:matx
        for y = 1:maty
            for z = 1:matz
                
                if(data.img(x,y,z) > 0)
                    mask(x,y,z) = mask(x,y,z) + 1;
                    
                end
                
            end
        end
    end
end


    for x = 1:matx
        for y = 1:maty
            for z = 1:matz
               
                val = mask(x,y,z)/temp;
                if(val > 0.95)
                    mask(x,y,z) = 1;
                else
                    mask(x,y,z) = 0;
                end
                
            end
        end
    end

    outname = strcat(DATA_DIR, '/BD_TMS_Data-', date, '-0.95Mask.mat');
    save(outname, 'mask', '-v7.3');

    outname = strcat(DATA_DIR, '/BD_TMS_Data-', date, '-0.95Mask.nii.gz');
    nif = make_nii(mask);
    nif.hdr.hist = data.hdr.hist;
    save_nii(nif, outname);



outname = strcat(DATA_DIR,'/BD_TMS_Data_',prefix,'_', date, '.mat');
disp(outname);
save(outname,'imgData', '-v7.3');

outname = strcat(DATA_DIR,'/BD_TMS_Data_',prefix,'_', date, '.nii.gz');
nif = make_nii(imgData);
nif.hdr.hist = data.hdr.hist;
save_nii(nif, outname);

outname = strcat(DATA_DIR,'/BD_TMS_SessionList-', date, '.xls');
disp(outname);

T = array2table(SCANS, 'VariableNames', {'Subject', 'Session'});
writetable(T, outname);

out = imgData;
%out = 1;
end