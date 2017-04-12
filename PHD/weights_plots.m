function weights_plots(cell, rows, columns, total_cells)

total_sample_cells = rows*columns;

weights = zeros(total_sample_cells, total_cells);

fid = fopen('final_RCweights.bdat', 'rb');

fseek(fid, total_cells*4*(cell-1), 'bof');

weights = fread(fid, [total_cells, total_sample_cells], 'float32')';

fclose(fid);

figure();

x = [1:total_cells];
cell_counter = cell;


increment = 360/total_cells;
favoured_view = (0:total_cells-1)*increment;

for(idx=1:total_sample_cells)
    
%     
%     vector1 = 0;
%     vector2 = 0;
%        
%     for jdx = 1:total_cells
%          vector1 = vector1 + (weights(idx,jdx) * sind(favoured_view(jdx)));
%          vector2 = vector2 + (weights(idx,jdx) * cosd(favoured_view(jdx)));
%     end
%     
%     
%     
%    if((vector1 > 0) && (vector2 >0)) 
%        pvector = atand(vector1/vector2);
%    elseif (vector2 < 0 )
%        pvector = (atand(vector1/vector2)) + 180;
%    else
%        pvector = (atand(vector1/vector2)) + 360;
%    end
%    
    
   [~,weight_max]= max(weights(1,:));
   
    
    
    
    subplot(rows, columns, idx)
    
    plot(x, weights(idx, :));
    xlabel('Presynaptic E1 Cell');
    ylabel('Weight');
    title(['Postynaptic E1 Cell: ', int2str(cell_counter)]);
	hold on;
	plot([cell_counter, cell_counter], [0,1], 'k');
    plot([weight_max, weight_max], [0,1], 'b');
	cell_counter = cell_counter+1;
        
end


end



