f = fullfile('Logbook','logbook.txt');
fileID = fopen(f,'a+');
message='Vehicle advanced Red light at frame';

% get frames one by one
baseName='frame_';

n=6;
maxRed=0;
logTemp=0;
lastRed=0;

for i=1:n
    numPart = sprintf('%06d',i);
    fileName=strcat(baseName,numPart,'.jpg');
    reqFrame=fullfile('framesData',fileName);
    currentFrame=imread(reqFrame);
%     figure
%     imshow(currentFrame);
    proFrame=preProcess(currentFrame);   %Preprocess the current frame
    frameMax=process(proFrame);      %process the pre-processed frame
    % in case of red light moving upwards
    if frameMax>maxRed
        
        maxRed=frameMax;
        logTemp=1;
        
    end
    
    % in case of red light vanishes , next tallest red light detected.
    if frameMax<maxRed  
        lastRed=maxRed;
        maxRed=frameMax;
        
        logTemp=0;
    end
    
    %if red light vanishes at topmost part of frame. 
    if logTemp==0 && lastRed<15
        fprintf(fileID,'%35s %6d\n',message,i-1);%prints log to logbook
    end
    
end

