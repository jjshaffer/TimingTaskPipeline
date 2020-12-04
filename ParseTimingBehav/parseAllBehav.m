
root_path = '/Volumes/mrrcdata/BD_TMS_TIMING/BEHAV';

Subject = {'cbm0411','cbm0411','cbm0421','cbm0421','cbm0431','cbm0431','cbm0441','cbm0441','cbm0451','cbm0451','cbm0461','cbm0461','cbm0471','cbm0471','cbm0481','cbm0481','cbm0491','cbm0491','CBM0501','CBM0501','CBM0511','CBM0511','CBM0531','CBM0531','CBM0541','CBM0541','CBM0551','CBM0551','CBM0561','CBM0561','CBM0571','CBM0571','CBM0581','CBM0581','CBM0591','CBM0591','CBM0601','CBM0601','CBM0611','CBM0611','CBM0621','CBM0621'};
Session = {'20180620','20180629','20180725','20180803','20180809','20180817','20180919','20180928','20180927','20181005','20181025','20181102','20181106','20181116','20190114','20190125','20181213','20181221','20190131','20190208','20190206','20190215','20190307','20190315','20190318','20190329','20190425','20190503','20190619','20190628','20190725','20190802','20190823','20190830','20191001','20191011','20191105','20191115','20200205','20200214','20200722','20200731'};
SubjID = {'0411-1','0411-2','0421-1','0421-2','0431-1','0431-2','0441-1','0441-2','0451-1','0451-2','0461-1','0461-2','0471-1','0471-2','0481-1','0481-2','0491-1','0491-2','0501-1','0501-2','0511-1','0511-2','0531-1','0531-2','0541-1','0541-2','0551-1','0551-2','0561-1','0561-2','0571-1','0571-2','0581-1','0581-2','0591-1','0591-2','0601-1','0601-2','0611-1','0611-2','0621-1','0621-2'};

Subject = {'CBM0631','CBM0641','CBM0641','CBM0651','CBM0651','CBM0661','CBM0661','CBM0671','CBM0671'};
Session = {'20200811','20200828','20200904','20200918','20200925','20201104','20201113','20201112','20201120'};
SubjID = {'0631-1','0641-1','0641-2','0651-1','0651-2','0661-1','0661-2','0671-1','0671-2'};


conditions = {'of', 'o0', 'r0', 'o3', 'r3', 'o12', 'r12'};
for j = 1:9
    
path = strcat(root_path, '/sub-', Subject(j), '/ses-', Session(j), '/');     
disp(path);

path=char(path);
%cd(path);    

File1 = strcat(path, 'TimingTaskRun1-', SubjID(j), '.txt');
File2 = strcat(path, 'TimingTaskRun2-', SubjID(j), '.txt');
File3 = strcat(path, 'TimingTaskRun3-', SubjID(j), '.txt');
File4 = strcat(path, 'TimingTaskRun4-', SubjID(j), '.txt');

%disp(File1);
File1=char(File1);
File2=char(File2);
File3=char(File3);
File4=char(File4);

%disp(File1);
Out = parseBehav(File1, File2, File3, File4);

%rmdir(strcat(path, 'onset'), 's');
%rmdir(strcat(path, 'response'), 's');

%Create output directories. 
mkdir(strcat(path, 'onset'));
mkdir(strcat(path, 'response'));

for i = 1:7
    
    if(strncmpi(conditions{i}, 'o', 1))
        outFile = strcat(path,'/onset/','stim.sub-', Subject(j), '_ses-', Session(j), '-', conditions{i}, '.1D');
        outFile = char(outFile);
        fileID = fopen(outFile,'w');
        fprintf(fileID,'%s',Out{i});
        fclose(fileID);
    
        if(strcmp(conditions{i}, 'of'))
            outFile = strcat(path,'/response/','stim.sub-', Subject(j), '_ses-', Session(j), '-rf', '.1D');
            outFile = char(outFile);
            fileID = fopen(outFile,'w');
            fprintf(fileID,'%s',Out{i});
            fclose(fileID);
    
        end
    else
        outFile = strcat(path,'/response/','stim.sub-', Subject(j), '_ses-', Session(j), '-', conditions{i}, '.1D');
        outFile = char(outFile);
        fileID = fopen(outFile,'w');
        fprintf(fileID,'%s',Out{i});
        fclose(fileID);
    end
    
    end

end