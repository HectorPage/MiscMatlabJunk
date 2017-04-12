function toy_weights_plots(cell_array, total_plots, rows, columns, total_cells, speed, delay)

total_sample_cells = rows*columns;

final_weights = zeros(total_sample_cells, total_cells);
initial_weights = zeros(total_sample_cells, total_cells);

offset = ((speed*delay)/(360.0/total_cells));

for plot_number = [1:total_plots]
    
    cell = cell_array(plot_number);
    
    fid = fopen('final_RCweights.bdat', 'rb');

    final_weights = fread(fid, [total_cells, total_cells], 'float32')';

    fclose(fid);

    %Plotting final weights first, so overlays in correct manner
    figure();

    x = [1:total_cells];

     numerator_final = 0;
     denominator_final = 0;
     numerator_initial = 0;
     denominator_initial = 0;
    
    plot(x, final_weights(:, cell), 'b', 'LineWidth',3);
    set(gca, 'FontSize',32);
    xlabel('Postsynaptic HD Cell', 'FontSize', 40);
    ylabel('Weight', 'FontSize', 40);
    %ylim([0,0.1]);
    %set(gca,'YTick',[0:0.025:0.1]);
    xlim([200,300]);
    set(gca, 'FontSize',40);
    set(gca, 'FontSize',40);
    title(['Presynaptic HD Cell: ', int2str(cell)], 'FontSize', 40);
     
    
    %Overlaying initial weights
   

    fid = fopen('initial_RCweights.bdat', 'rb');
    initial_weights = fread(fid, [total_cells, total_cells], 'float32')';
    fclose(fid);

    hold on;
    plot(x, initial_weights(:, cell), '--k','LineWidth',3);
    
    
    if exist ('middle_RCweights.bdat', 'file') == 2       %Overlaying weights after training, pre symmetrical overlay (if they exist)
    
    fid = fopen('middle_RCweights.bdat', 'rb');
    initial_weights = fread(fid, [total_cells, total_cells], 'float32')';
    fclose(fid);

    hold on;
    plot(x, initial_weights(:, cell), '--r','LineWidth',3);

    end
    
    %Putting on line at cell number to see if offset, and line at offset
    %expected to see where the center is
    
    hold on;
    
    
    
    a = [cell,cell]; %Cell location (symmetrical connectivity)
    b = [0, 0.25];
    %c = [cell+offset, cell+offset]; %Offset location from cell (asymmetrical connectivity)
    
    plot(a,b, '--k','LineWidth', 3);
    %plot(c,b, '--r', 'LineWidth', 3);
   
   
    set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
    set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
 

    filename = ['RC_weights_cell_', int2str(cell)];

    saveas(gcf,[filename],'epsc');
    close(gcf);


end



%Working out offsets - still not quite right.....

observed_offset = zeros(1,total_cells);
expected_offset = zeros(1,total_cells);

weights = zeros(1, total_cells);
fid = fopen('final_weight_vectors.bdat', 'rb');

final_vectors = zeros(1,total_cells);
final_vectors(:) = fread(fid, [total_cells], 'float32');
fclose(fid);

increment = 360/total_cells;




for (cell_index = 1:total_cells)


            distance1 = abs(final_vectors(cell_index) - ((cell_index-1) * (360/total_cells)));	%Not sure if it's this
			
            
            distance2 = abs(360.0 - distance1);
			
			if(distance1<=distance2)
				distance = distance1;
			else
			
				distance = distance2;
            end



observed_offset(1,cell_index) = distance;


end

expected_offset(1, :) = speed * delay;



if exist ('middle_RCweights.bdat', 'file') == 2 
    pre_gaussian_offset = zeros(1,total_cells);

    fid = fopen('intermediate_weight_vectors.bdat','rb');
    
    intermediate_vectors = zeros(1,total_cells);
    intermediate_vectors(:) = fread(fid, [total_cells], 'float32');
    fclose(fid);
    
    for (cell_index=1:total_cells)
      
        distance1 = abs(intermediate_vectors(cell_index) - ((cell_index-1)* (360/total_cells)));			
		distance2 = abs(360.0 - distance1);
			
			if(distance1<=distance2)
				distance = distance1;
			else
			
				distance = distance2;
            end


    pre_gaussian_offset(1,cell_index) = distance; 
    
    end

    
fid = fopen('offset.dat', 'w');

for(cell_index=1:total_cells)
    
fprintf(fid, 'observed offset = %f\n',observed_offset(cell_index));  

end

figure();
plot(observed_offset, 'b', 'LineWidth', 2.0);


fclose(fid);

else
fid = fopen('offset.dat', 'w');

for(cell_index=1:total_cells) %Do it to total_cells to see all cells values
fprintf(fid, 'observed offset = %f\n', observed_offset(cell_index));

end


figure();
plot(observed_offset, 'b', 'LineWidth', 2.0);
fclose(fid);

end




end    

