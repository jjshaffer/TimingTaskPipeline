function x = readTimingRun(filename, flag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Read task output text file from ePrime into variable txt, then close the
%file
[f,msg]=fopen(filename,'r','n','Unicode');
txt=fscanf(f,'%c');
fclose(f);

%Split the file into sections separated by asterisks
[C, matches] = strsplit(txt, '*');


%Store header from file in variable
Header = C{3};

%Get Scanner Trigger Time
triggerEventIndex = length(matches)-1;

%temp = C{triggerEventIndex};
A = strsplit(C{triggerEventIndex}, '\n');
[a b] = size(A);

triggerTime=0;

for i = 1:b
    B = strsplit(A{i}, ':');
    temp = strtrim(B{1});
     if (strcmp(temp, 'Instructions.OnsetTime'))
         triggerTime = str2num(strtrim(B{2}));
     end
end


%disp(num2str(triggerTime));


%Determine how many trials occurred
count = ceil((length(matches) - 12)/4);




%Create variables for storing information about each trial
Response = zeros(count, 5);
Z = cell(1, count);
Timing = cell(1,7);
firstTrialTime = 0;



%onset12 = '';
%response12 = '';
%onset3 = '';
%response3 = '';
%onset0 = '';
%response0 = '';
%onsetFix = '';

%Loop through each trial
for i=1:count
    
   %Store each event text in Z 
   Z{i} = C{(i-1)*4+7};
   
   %Split entry at each line, determine number of lines in the event
   A = strsplit(Z{i}, '\n');
   [a b] = size(A);
   
   %Loop through each line in the event
   for j = 1:b
   
       %Divide into key:value pairs
       B = strsplit(A{j}, ':');
       
       %Set temp = to the key
       temp = strtrim(B{1});
       
       %Check if the key is "Stimulus" to determine which type of event
       if (strcmp(temp, 'Stimulus'))
           %set stim = to the value
           stim = cellstr(strtrim(B{2}));
           
           %Set response variable based on value of the key, store in first
           %column of Response
           if strcmp(stim, '+')
               Response(i,1) = 1;
                      
           elseif strcmp(stim, '0')
               Response(i,1) = 0;
               
           elseif strcmp(stim, '3')
               Response(i,1) = 3;
                             
           elseif strcmp(stim, '12')
               Response(i,1) = 12;
              
           end
       %If the key is the onset time, store the event onset time
       elseif (regexp(temp, 'Stimulus.*\.OnsetTime'))
           
           %If this is the first event, store the onset time
           if(i==1)
              firstTrialTime = str2num(strtrim(B{2}));
           end
           
           %Store the relative onset time in the second column of Response
           %Response(i,2) = str2num(strtrim(B{2}))-firstTrialTime;
           Response(i,2) = str2num(strtrim(B{2})) - triggerTime;
           %disp(Response(i,2));
      
       %If the key is the response time, store the response time    
       elseif (regexp(temp, 'Stimulus.*.RTTime'))
           %Response(i,3) = str2num(strtrim(B{2}))-firstTrialTime;
           
           rt = str2num(strtrim(B{2}));
           
           if(rt==0)
               Response(i,3) = 0; 
           else
               Response(i,3) = str2num(strtrim(B{2})) - triggerTime; 
           end
           
           
       end
       
   end
              
   %If the event was a trial and the participant responded, 
   if(Response(i,1)~=1 && Response(i,3)>0)
      %Store the response delay difference & Note that the trial was completed 
      Response(i,4) = Response(i,3) - Response(i,2);
      Response(i,5) = 1;
      
      %Generate output strings for AFNI analysis
      if(Response(i,1)==0)
           Timing{2} = sprintf('%s %.02f',Timing{2}, Response(i,2)/1000);
           Timing{3} = sprintf('%s %.02f',Timing{3}, Response(i,3)/1000);
      elseif(Response(i,1)==3)
           Timing{4} = sprintf('%s %.02f',Timing{4}, Response(i,2)/1000);
           Timing{5} = sprintf('%s %.02f',Timing{5}, Response(i,3)/1000);
      elseif(Response(i,1)==12)
          Timing{6} = sprintf('%s %.02f',Timing{6}, Response(i,2)/1000);
          Timing{7} = sprintf('%s %.02f',Timing{7}, Response(i,3)/1000);
      end
      
   elseif(Response(i,1)==1)
       Response(i,5) = 1;
       Response(i,3) = 0;
       Timing{1} = sprintf('%s %.02f',Timing{1}, Response(i,2)/10000);

   end
   
end

for k = 1:7
   Timing{k} = Timing{k}(2:end);
end

%x = Z;
if flag ==1
    x = Response;
else
    x = Timing;
end


end

