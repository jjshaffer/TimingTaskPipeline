
root_path = '/Volumes/mrrcdata/SCZ_TMS_TIMING/BEHAV';

Subject = {'CBM0001', 'CBM0001','CBM0011', 'CBM0011','CBM0021','CBM0021', 'CBM0031', 'CBM0031', 'CBM0061', 'CBM0061', 'CBM0071', 'CBM0071', 'CBM0111', 'CBM0111'};
Session = {'20171128', '20171208', '20180118', '20180126', '20180129', '20180209', '20180216', '20180223', '20180822', '20180831', '20181004', '20181012', '20191113', '20191122'};
SubjID = {'0001-1', '0001-2', '0002-1', '0002-2', '002-1', '002-2', '003-1', '003-2', '0061-1', '0061-2', '0071-1', '0071-2', '0111-1', '0111-2'};

Subject = {'CBM0051', 'CBM0081', 'CBM0091', 'CBM0101'};
Session = {'20180709', '20190402', '20190515', '20190923'};
SubjID = {'0051-1', '0081-1', '0091-1', '0101-1'};

Subject = {'CTL9001', 'CTL9011', 'CTL9021', 'CTL9041'};
Session = {'20190807', '20191003', '20191009', '20191107'};
SubjID = {'9001-1', '9011-1', '9021-1', '9041-1'};

Subject = {'CTL9051', 'CTL9061', 'CTL9071', 'CTL9081'};
Session = {'20200305', '20200309', '20200313', '20200626'};
SubjID = {'9051-1', '9061-1', '9071-1', '9081-1'};

Subject = {'CBM0121'};
Session = {'20200212'};
SubjID = {'0121-1'};

%CBM0131, 20201008, 0131-1 is missing Run2

Subject = {'CBM0131', 'CBM0131', 'CBM0141', 'CBM0141', 'CTL9091', 'CTL9101', 'CTL9111', '23517559','23517560','23517562','23517563','23517564','23517565','23517566','23517567', '23517557', '23517558'};
Session = {'20201008', '20201016', '20201015', '20201023', '20200824', '20200826', '20201027', '2020101609453T','2020102914503T','202011123T','202011133T','202011163T','202011203T','202011233T','202011243T', '2020100610153T', '202010143T'};
SubjID = {'0131-1', '0131-2', '0141-1', '0141-2', '9091-1', '9101-1', '9111-1', '23517559-1','23517560-1','23517562-1','23517563-1','23517564-1','23517565-1','23517566-1','23517567-1', '23517557-1', '23517558-1'};


conditions = {'of', 'o0', 'r0', 'o3', 'r3', 'o12', 'r12'};

%%%SET THISE FOR LOOP TO MATCH ARRAY LENGTH ABOVE %%%
for j = 16:17
    
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
%Out = parseBehav(File1, File1, File3, File4);

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