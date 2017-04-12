function recurrent_weights(seconds, tsize, total_cells, mode)

 x = [tsize:(tsize*100):seconds];
 steps = ((seconds/tsize)/100);

pvector1 = file_load(total_cells, steps, 'Input_Location1.bdat');
pvector2 = file_load(total_cells, steps, 'visring_location.bdat');

E1Rates = zeros(total_cells, steps);
E1Rates = file_load(total_cells, steps, 'E1Rates.bdat');

      
cell_value = max(pvector2(:,steps)); %returns peak of visring_location gaussian.
cell = find(pvector2(:,steps) == cell_value); % calculates which cell corresponds to that peak.


weights = zeros(total_cells, total_cells);
fid = fopen('recurrent_weights.bdat', 'rb');
weights = fread(fid, [total_cells, total_cells], 'float32')';
fclose(fid);



figure();

x = [1:total_cells];

    plot(x, weights(:,cell));
    title('Weight Overlay');
	hold on;
    plot(x, pvector1, 'r');
    plot(x, pvector2, 'g');
    plot(x, E1Rates(:,steps), '--k');
                    
    if (strcmpi(mode, 'save'))
    saveas(gcf,'weight_overlay', 'png');
	close(gcf);
	end

    
        
end



function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end
