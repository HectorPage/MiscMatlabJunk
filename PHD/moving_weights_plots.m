function moving_weights_plots(cell_array, total_plots, rows, columns, total_cells)

total_sample_cells = rows*columns;

final_weights = zeros(total_sample_cells, total_cells);
intermediate_weights = zeros(total_sample_cells, total_cells);
initial_weights = zeros(total_sample_cells, total_cells);


for plot_number = [1:total_plots]
    
    cell = cell_array(plot_number);
    
    fid = fopen('final_ffweights.bdat', 'rb');

fseek(fid, total_cells*4*(cell-1), 'bof');

final_weights = fread(fid, [total_cells, total_sample_cells], 'float32')';

fclose(fid);

%Plotting final weights first, so overlays in correct manner
figure();

x = [1:total_cells];

     numerator_final = 0;
     denominator_final = 0;
     numerator_initial = 0;
     denominator_initial = 0;
     
for(idx=1:total_sample_cells)
    subplot(rows, columns, idx)
    
    plot(x, final_weights(idx, :), 'b', 'LineWidth',3);
    set(gca, 'FontSize',32);
    xlabel('Presynaptic Visual Cell', 'FontSize', 40);
    ylabel('Weight', 'FontSize', 40);
    ylim([0,0.25]);
    set(gca,'YTick',[0:0.05:0.25]);
    set(gca, 'FontSize',40);
    set(gca, 'FontSize',40);
    title(['Postynaptic HD Cell: ', int2str(cell)], 'FontSize', 40);
 
 
         
    
%Overlaying intermediate weights
    
    fid = fopen('intermediate_ffweights.bdat', 'rb');
    fseek(fid, total_cells*4*(cell-1), 'bof');
    intermediate_weights = fread(fid, [total_cells, total_cells], 'float32')';
    fclose(fid);

    hold on;
    plot(x, intermediate_weights(idx, :), 'r','LineWidth',3);
    
    
    
%Overlaying initial weights
   

    fid = fopen('initial_ffweights.bdat', 'rb');
    fseek(fid, total_cells*4*(cell-1), 'bof');
    initial_weights = fread(fid, [total_cells, total_cells], 'float32')';
    fclose(fid);

   hold on;
   plot(x, initial_weights(idx, :), '--k','LineWidth',3);
   
   legend('final weights','intermediate weights', 'initial weights');
   
   
   
      
           
end

set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
 

 filename = ['postsyn_ff_weights_cell_', int2str(cell)];

saveas(gcf,[filename],'epsc');
close(gcf);



end

      
end

