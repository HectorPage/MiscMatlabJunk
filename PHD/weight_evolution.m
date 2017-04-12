function weight_evolution(cell, cells, seconds, tsize, epoch, type)

steps = seconds/tsize;

weights = zeros(steps, cells);

if(cell==125)
    
    weights = file_load(cells, steps, 'weights125.bdat', epoch);
    
elseif(cell==400)
        
    weights = file_load(cells, steps, 'weights400.bdat', epoch);
    
end

if strcmpi(type, 'movie')
    
    figure();
    
    x = linspace(1, cells, cells);
    
    for step = 1 : steps
        
        plot(x, weights(step, :));
        xlim([1, cells]);
        ylim([0, 1]);
        title(['Epoch: ', int2str(epoch),' Timestep: ', int2str(step)]);
        pause(0.01);
        
    end
    
elseif strcmpi(type, 'surf')
    
    figure();
    
    x = linspace(1, cells, cells);
    y = linspace(1, steps, steps);
    
    [X, Y] = meshgrid(x, y);
    
    h = surf(X, Y, weights);
    set(h, 'LineStyle', 'none');
    colormap(1-gray);
    view(45, 45);
    
end 
    
end

function weights = file_load(cells, steps, fname, epoch)

       weights = zeros(steps, cells);
       
       fid = fopen(fname, 'rb');
       
       fseek(fid, (cells*steps*4*(epoch-1)), 'bof');
       
       weights = fread(fid, [cells, steps], 'float32')';
       
       fclose(fid);
       
end
