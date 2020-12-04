function x = combine_Functional_Images(contrast, outprefix)

%DATA_DIR='/Shared/MRRCdata/SCZ_TMS_TIMING/derivatives/TimingTask_Onset/';
DATA_DIR='/Volumes/mrrcdata/SCZ_TMS_TIMING/derivatives/TimingTask_Onset/';
%DATA_DIR='/Volumes/mrrcdata/SCZ_TMS_TIMING/derivatives/TimingTask_Response/';


x_size = 61
y_size = 73
z_size = 61

%List of Scans for Group comparison
SCANS = {
'CBM0001',	'20171128';
'CBM0011',	'20180118';
'CBM0021',	'20180129';
'CBM0031',	'20180216';
'CBM0051',	'20180709';
'CBM0061',	'20180822';
'CBM0071',	'20181004';
'CBM0081',	'20190402';
'CBM0091',	'20190515';
'CBM0101',	'20190923';
'CBM0111',	'20191113';
'CBM0131',	'20201008';
'CBM0141',	'20201015';
'23517557',	'2020100610153T';
'23517558',	'202010143T';
'23517559',	'2020101609453T';
'23517560',	'2020102914503T';
'23517562',	'202011123T';
'23517563',	'202011133T';
'23517564',	'202011163T';
'23517565',	'202011203T';
'23517566',	'202011233T';
'23517567',	'202011243T';
'CTL9001',	'20190807';
'CTL9011',	'20191003';
'CTL9021',	'20191009';
'CTL9041',	'20191107';
'CTL9051',	'20200305';
'CTL9061',	'20200309';
'CTL9071',	'20200313';
'CTL9081',	'20200626';
'CTL9091',	'20200824';
'CTL9101',	'20200826';
'CTL9111',	'20201027'};

%'CBM0041','20180426'; Missing data

%List of Scans for TMS comparison
%SCANS = {
%'CBM0001',	'20171128';
%'CBM0001',	'20171208';
%'CBM0011',	'20180118';
%'CBM0011',	'20180126';
%'CBM0021',	'20180129';
%'CBM0021',	'20180209';
%'CBM0031',	'20180216';
%'CBM0031',	'20180223';
%'CBM0061',	'20180822';
%'CBM0061',	'20180831';
%'CBM0071',	'20181004';
%'CBM0071',	'20181012';
%'CBM0131',	'20201008';
%'CBM0131',	'20201016';
%'CBM0141',	'20201015';
%'CBM0141',	'20201023'};

temp = length(SCANS);

imgData=zeros(x_size, y_size, z_size, temp);
mask = zeros(x_size, y_size, z_size);

for i = 1:temp
    dirname = strcat(DATA_DIR,SCANS(i,1), '_ses', SCANS(i,2), '.results/');
    disp(dirname);
    filename = strcat(dirname,'stats.', SCANS(i,1), '_ses', SCANS(i,2), '_', contrast, '_tstat.nii.gz');
    disp(filename);
    
    data = load_nii(char(filename));
    imgData(:,:,:,i) = data.img;
    
    maskname = strcat(dirname, 'mask.', SCANS(i,1), '_ses', SCANS(i,2), '.nii.gz');
    maskData = load_nii(char(maskname));
    
    for x = 1:x_size
        for y = 1:y_size
            for z = 1:z_size
                mask(x,y,z) = mask(x,y,z) + maskData.img(x,y,z);
            end
        end
    end
    
end

%imgData=matrix;
%outname = strcat(DATA_DIR,'BD_TMS_Data',num2str(index),'-', date, '.mat');
outname = strcat(DATA_DIR,outprefix,'-',contrast, '_', date, '.mat');
disp(outname);
save(outname, 'imgData');

%outname = strcat(DATA_DIR,'outprefix',num2str(index),'-', date, '.csv');
%writematrix(imgData, outname);

%outname = strcat(DATA_DIR,'BD_TMS_SessionList',num2str(index),'-', date, '.xls');
outname = strcat(DATA_DIR, outprefix,'_SessionList','-',contrast, '_', date, '.xls');
disp(outname);

T = array2table(SCANS, 'VariableNames', {'Subject', 'Session'});
writetable(T, outname);

thresh = floor(temp*0.95);

mask = 1.*(mask>thresh);

maskoutname = strcat(DATA_DIR, outprefix, '_Mask_', date, '.mat');
save(maskoutname, 'mask');

x = imgData;
end
