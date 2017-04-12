function touretzky_weight_evo(total_cells, cell, steps, speed)


weights = zeros(steps, total_cells);


    weights = file_load(total_cells, cell, steps, 'weight_dump.bdat');
  

    
    figure();
    
    x = linspace(1, total_cells, total_cells);
    
    for step = 1 : steps
        
        plot(x, weights(step, :));
        xlim([1, total_cells]);
        ylim([0, 1]);
        title([' Timestep: ', int2str(step)]);
        pause(speed);
        
    end
    

    
end

function weights = file_load(cells, cell, steps, fname)

       weights = zeros(steps, cells);
       
       fid = fopen(fname, 'rb');
       
       for step = 1 : steps
       
        if(step==1)
           
            fseek(fid, (cells*4*(cell-1)), 'bof');
            
        else
            
            fseek(fid, ((cells*4*(cell-1))+(cells*cells*4*(step-1))), 'bof');
            
        end
       
            weights(step, :) = fread(fid, cells, 'float32')';
        
       end
       
       fclose(fid);
       
end
