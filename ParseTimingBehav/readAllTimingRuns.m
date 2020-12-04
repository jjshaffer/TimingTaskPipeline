function out = readAllTimingRuns(behavPath)

subjects = dir(behavPath);

%Loop through each filename
for i = 1:length(subjects)
    %Check if filename is a subject
   if(contains(subjects(i).name, 'sub-'))
        %disp(subjects(i).name);
        
        subjPath = strcat(behavPath, '/', subjects(i).name);
        disp(subjPath);
        
        %Create list of files in directory
        sessions = dir(subjPath);
        %Loop through list of files
        for j = 1:length(sessions)
            %If file fits the format for a session, then
            if(contains(sessions(j).name, 'ses-'))
               %disp(sessions(j).name); 
                sessionPath = strcat(subjPath, '/', sessions(j).name);
                disp(sessionPath);
            
                files = dir(sessionPath);
                
                Timing=cell(4,7);
                
                for k = 1:length(files)
                    %disp(files(k).name);
                    
                    %We only want the .txt files
                    if(contains(files(k).name, '.txt'))
                        if(contains(files(k).name, 'TimingTaskRun1'))
                            %disp(files(k).name);
                            filename = strcat(sessionPath, '/', files(k).name);
                            Timing(1,:) = readTimingRun(filename, 0);
                            
                        elseif(contains(files(k).name, 'TimingTaskRun2'))
                            %disp(files(k).name);
                            filename = strcat(sessionPath, '/', files(k).name);
                            Timing(2,:) = readTimingRun(filename, 0);
                            
                        elseif(contains(files(k).name, 'TimingTaskRun3'))
                            %disp(files(k).name);
                            filename = strcat(sessionPath, '/', files(k).name);
                            Timing(3,:) = readTimingRun(filename, 0);
                            
                        elseif(contains(files(k).name, 'TimingTaskRun4'))
                            %disp(files(k).name);
                            filename = strcat(sessionPath, '/', files(k).name);
                            Timing(4,:) = readTimingRun(filename, 0);
                        end
                    end
                end
            
            %Write outputs
            
            
            %rmdir(strcat(sessionPath, '/onset'), 's');
            %rmdir(strcat(sessionPath, '/response'), 's');
            
            
            mkdir(strcat(sessionPath, '/onset'));
            mkdir(strcat(sessionPath, '/response'));
            
            %Onset 2, 4, 6
            
            z0 = sprintf('%s\n%s\n%s\n%s',Timing{1,2},Timing{2,2},Timing{3,2},Timing{4,2});
            
            filename = strcat(sessionPath, '/onset/', 'stim.', subjects(i).name, '_',sessions(j).name ,'-oi0.1D');
            fid = fopen(filename, 'w');
            fprintf(fid, '%s', z0);
            fclose(fid);
            
            z3 = sprintf('%s\n%s\n%s\n%s',Timing{1,4},Timing{2,4},Timing{3,4},Timing{4,4});
            filename = strcat(sessionPath, '/onset/', 'stim.', subjects(i).name, '_',sessions(j).name ,'-os3.1D');
            fid = fopen(filename, 'w');
            fprintf(fid, '%s', z3);
            fclose(fid);
            
            z12 = sprintf('%s\n%s\n%s\n%s',Timing{1,6},Timing{2,6},Timing{3,6},Timing{4,6});
            filename = strcat(sessionPath, '/onset/', 'stim.', subjects(i).name, '_',sessions(j).name ,'-ol12.1D');
            fid = fopen(filename, 'w');
            fprintf(fid, '%s', z12);
            fclose(fid);
            
            zf = sprintf('%s\n%s\n%s\n%s',Timing{1,1},Timing{2,1},Timing{3,1},Timing{4,1});
            filename = strcat(sessionPath, '/onset/', 'stim.', subjects(i).name, '_',sessions(j).name ,'-of.1D');
            fid = fopen(filename, 'w');
            fprintf(fid, '%s', zf);
            fclose(fid);
            
            %Button Response 3,5,7
                
            z0 = sprintf('%s\n%s\n%s\n%s',Timing{1,3},Timing{2,3},Timing{3,3},Timing{4,3});
            filename = strcat(sessionPath, '/response/', 'stim.', subjects(i).name, '_',sessions(j).name ,'-ri0.1D');
            fid = fopen(filename, 'w');
            fprintf(fid, '%s', z0);
            fclose(fid);
            
            z3 = sprintf('%s\n%s\n%s\n%s',Timing{1,5},Timing{2,5},Timing{3,5},Timing{4,5});
            filename = strcat(sessionPath, '/response/', 'stim.', subjects(i).name, '_',sessions(j).name ,'-rs3.1D');
            fid = fopen(filename, 'w');
            fprintf(fid, '%s', z3);
            fclose(fid);
            
            z12 = sprintf('%s\n%s\n%s\n%s',Timing{1,7},Timing{2,7},Timing{3,7},Timing{4,7});    
            filename = strcat(sessionPath, '/response/', 'stim.', subjects(i).name, '_',sessions(j).name ,'-rl12.1D');
            fid = fopen(filename, 'w');
            fprintf(fid, '%s', z12);
            fclose(fid);
            
            zf = sprintf('%s\n%s\n%s\n%s',Timing{1,1},Timing{2,1},Timing{3,1},Timing{4,1});
            filename = strcat(sessionPath, '/response/', 'stim.', subjects(i).name, '_',sessions(j).name ,'-rf.1D');
            fid = fopen(filename, 'w');
            fprintf(fid, '%s', zf);
            fclose(fid);
            
            %Copy fixation timing file
            copyfile('stim.000-1-of.1D', strcat(sessionPath, '/onset/', 'stim.', subjects(i).name, '_',sessions(j).name ,'-of.1D'));
            copyfile('stim.000-1-of.1D', strcat(sessionPath, '/response/','stim.', subjects(i).name, '_',sessions(j).name , '-rf.1D'));

            end
        end
        
   end
end



out = subjects;
end