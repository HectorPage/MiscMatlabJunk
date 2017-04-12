function timeslice (seconds, tsize, cells, start_timestep, total_timsteps, increment, speed, phase)
%Displays firing rates of all excitatory cells in simulation phase 'phase' across time period defined
%by 'start_timestep', with number of images 'total_timesteps', all
%'increment' milliseconds apart. Images are displayed 'speed' seconds
%apart.

%Requires total number of seconds in simulation: 'seconds', size of
%timestep in seconds: 'timestep', and number of excitatory cells: 'cells'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Original Author: HJI Page & D Walters                       %
%                   Date: 7/12/11                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



         steps = seconds/tsize;
         
         E1Rates = zeros(cells, steps);
           
         E1Rates = file_load(cells, steps, ['E1Rates',phase,'.bdat']);
         
         figure();
         
         counter = start_timestep;
		        
         for(idx = 1:total_timsteps)
         
            plot(E1Rates(:,counter));
            title(['E1 Firing Rates at Timestep ',int2str(counter)]);
            xlabel('E1 Cells');
            xlim([1 cells]);
            ylabel('Firing Rate');
            ylim([0 1]);
            
           pause(speed);
           
           counter = counter+increment;
            
         end
         
         close(gcf); 
            
 function rates = file_load(cells, steps, fname)           
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);

        
    end



end

