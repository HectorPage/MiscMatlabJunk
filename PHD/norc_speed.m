function norc_speed(seconds, tsize, cells)

    

   
%SETTING UP INFO NEEDED TO LOAD
    steps = uint32(((seconds/tsize)/100));
    
   
         
%LOADING CELL FIRING RATES%             
E1Rates = zeros(cells, steps);
E1Rates = file_load(cells, steps, 'HDRates.bdat');

                
%NOW LOADING THE LAST 4 SECONDS (TEST PHASE) OF SIMULATIONS, FOR EASIER
%HANDLING OF DATA


HD_testphase_rates = zeros(cells, uint32(((4.0/tsize)/100)));
HD_testphase_rates = E1Rates(:,(end-uint32(((4.0/tsize)/100)):end-1));


%CALCULATING HD PVECTOR%


increment = 360/cells;
favoured_view = zeros(1,cells);
                    

one_second = uint32(((1.0/tsize)/100));


%Set up favoured view vector format
                    
favoured_view = (0:cells-1)*increment;


%Firstly doing pvector_HD(1), which is the beginning of rotation phase

for idx = 1
                        
    vector1_HD = 0;
    vector2_HD = 0;
                        
                        
    for jdx = 1:cells
        vector1_HD = vector1_HD + (HD_testphase_rates(jdx,idx) * sind(favoured_view(jdx)));
        vector2_HD = vector2_HD + (HD_testphase_rates(jdx,idx) * cosd(favoured_view(jdx)));
                            
    end
    
    
    if((vector1_HD > 0) && (vector2_HD >0))
        start_point = atand(vector1_HD/vector2_HD);
    elseif (vector2_HD < 0 )
        start_point = (atand(vector1_HD/vector2_HD)) + 180;
    else
        start_point = (atand(vector1_HD/vector2_HD)) + 360;
    end

end



for idx = one_second*3
                        
    vector1_HD = 0;
    vector2_HD = 0;
                        
                        
    for jdx = 1:cells
        vector1_HD = vector1_HD + (HD_testphase_rates(jdx,idx) * sind(favoured_view(jdx)));
        vector2_HD = vector2_HD + (HD_testphase_rates(jdx,idx) * cosd(favoured_view(jdx)));
                            
    end
    
    
    if((vector1_HD > 0) && (vector2_HD >0))
        end_point = atand(vector1_HD/vector2_HD);
    elseif (vector2_HD < 0 )
        end_point = (atand(vector1_HD/vector2_HD)) + 180;
    else
        end_point = (atand(vector1_HD/vector2_HD)) + 360;
    end

end



if(start_point > end_point)
   speed = ((360.0 - start_point) + end_point)/2.0 
else
    speed = (end_point - start_point)/2.0  
end
                    
                   
                   

                
end

function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end
