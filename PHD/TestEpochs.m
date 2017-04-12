timestep = 1;

epoch = 24;

offtime = 12;

nonofftime = 12;


for timestep = 1:(epoch*(offtime+nonofftime))
    disp(timestep-1)
    
    offcounter = 0;
    for offcounter=1:offtime
        
        disp(offcounter);
       
    end
    
    nonoffcounter = 0;
    for nonoffcounter=1:nonofftime
        
        disp(nonoffcounter);
       
      
    end
end