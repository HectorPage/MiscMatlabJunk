function summarise_inhib(speed, delay, inhib, cells, seconds, tsize)

%This script is plotting for a given target speed and given delay, what packet speed is for each strength.

steps = uint32(((seconds/tsize)/100));
E1Rates = zeros(cells(1), steps); %Loading in HD layer firing rates, in order to calculate speed from them.
favoured_view = zeros(1, cells);  %Store the favoured views of cells.
increment = 360/cells; %Calculate favoured view of cells, to calculate pvectors.

max_speed = zeros(1,numel(delay));
offset_size = zeros(1,numel(delay));

packet_speed = zeros(1,numel(inhib));
packet_speed(1,1) = 0;

for adx = 1:numel(speed)
    dirstringW = [num2str(speed(adx))];
    parentpath = ['~/video_conflict/ff_plasticity/_moving_rat/_sym_asym/parameter_search'];
    tier_1_path = [parentpath,'/',dirstringW,'_inhib'];
 
    cd(tier_1_path); 
    
    for idx = 1:numel(delay)
        dirstringS = [num2str(delay(idx))];
        tier_2_path = [tier_1_path,'/',dirstringS];
    
        cd(tier_2_path); 
        
        
         for jdx = 1:numel(inhib)
             
            
    
            dirstringL = [num2str(inhib(jdx))];
            tier_3_path = [tier_2_path, '/', dirstringL];
            cd(tier_3_path);
            
            %FOLLOWING PIECE OF CODE HERE TO EXTRACT PACKET SPEED.
            
             E1Rates = file_load(cells(1), steps, 'E1Rates.bdat');
            
             
             favoured_view = (0:cells-1)*increment;
             
             %Calculating pvector at halfway through simulation.
                         
             vector1 = sind(favoured_view) * E1Rates(:,(steps/2));
             vector2 = cosd(favoured_view) * E1Rates(:,(steps/2));
             
             if((vector1> 0) && (vector2>0))
                start_vector = atand(vector1/vector2);
             elseif (vector2< 0 )
                start_vector = (atand(vector1/vector2)) + 180;
             else
                start_vector = (atand(vector1/vector2)) + 360;
             end
             
             %Calculating pvector at next timestep.
             
             
             vector1 = sind(favoured_view) * E1Rates(:,(steps/2)+1);
             vector2 = cosd(favoured_view) * E1Rates(:,(steps/2)+1);
             
             if((vector1> 0) && (vector2>0))
                finish_vector = atand(vector1/vector2);
             elseif (vector2< 0 )
                finish_vector = (atand(vector1/vector2)) + 180;
             else
                finish_vector = (atand(vector1/vector2)) + 360;
             end
             
             
             %Now calculating the speed of packet
             
        if(abs(finish_vector - start_vector) < 0.0001)  %This condition might not be technically correct, but it works for now..........
                              
                              packet_speed(jdx) = 0;
                              
                              
                            elseif(finish_vector==start_vector)
                                
                                packet_speed(jdx) = 0; 
                              
                              
                            elseif(finish_vector < start_vector)
                                  
                                  packet_speed(jdx) = ((360 - start_vector) + finish_vector)/0.01;        
                                  
                         
                            elseif(finish_vector > start_vector)
                                     
                                   packet_speed(jdx)= abs(finish_vector-start_vector)/0.01; 
                                  
       end
             
             
            
            
            cd(tier_2_path);
            
         end
         
         
         max_speed(idx) = packet_speed(numel(inhib));
         offset_size(idx) = speed(adx)*delay(idx);
         
         
         %MAYBE DO LOG AXES?
                 
         old_filename = ['SpeedSummary', num2str(offset_size(idx)), 'deg'];
         new_filename = strrep(old_filename, '.','p');
         
         

         figure();
         %plot(strength,packet_speed);
         %loglog(strength, packet_speed);
         plot(inhib, packet_speed);
         grid on;
         hold on;
         xlabel('HD Layer Global Inhibition');
         ylabel('Packet Speed (deg/s)');
         xlim([inhib(1),inhib(numel(inhib))]);
         set(gca, 'XTick', [0.18:0.01:0.29]);
         ylim([0,2000]);
         title(['Offset size: ', num2str(offset_size(idx)), '^\circ'])
         saveas(gcf,new_filename, 'pdf');
         close(gcf);

         cd(tier_1_path);
            
      
    end
    
    cd(parentpath);
   
    figure();
    plot(offset_size,max_speed);
    grid on;
    xlabel('Offset size (deg)');
    ylabel('Max Packet Speed (deg/s)');
    title('Top speed vs. Offset Size');
    saveas(gcf, 'max_speeds_inhib','pdf');
    close(gcf);
    
    

end

end
         
function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end