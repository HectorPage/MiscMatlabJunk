function combex_weights(cell_array, total_plots, rows, columns, total_cells)

total_sample_cells = rows*columns;

combex_weights = zeros(total_sample_cells, total_cells);
comb_weights = zeros(total_sample_cells, total_cells);



for plot_number = [1:total_plots]
    
    cell = cell_array(plot_number);
    
    fid = fopen('HD_COMB_weights.bdat', 'rb');

fseek(fid, total_cells*4*(cell-1), 'bof');

comb_weights = fread(fid, [total_cells, total_sample_cells], 'float32')';

fclose(fid);

fid = fopen('HD_COMBEX_weights.bdat', 'rb');

fseek(fid, total_cells*4*(cell-1), 'bof');

combex_weights = fread(fid, [total_cells, total_sample_cells], 'float32')';

fclose(fid);


%Plotting
figure();

x = [1:total_cells];

     
for(idx=1:total_sample_cells)
    subplot(rows, columns, idx)
    
    plot(x, comb_weights(idx, :), 'b', 'LineWidth',2);
    set(gca, 'FontSize',32);
    xlabel('Presynaptic HD Cell', 'FontSize', 32);
    ylabel('Weight', 'FontSize', 32);
    set(gca, 'FontSize',32);
    title(['Postynaptic COMB/COMBEX Cell: ', int2str(cell)], 'FontSize', 32);
    ylim([0,0.5]);
 


    hold on;
    plot(x, combex_weights(idx, :), 'r','LineWidth',2);
    
    
    
   
   legend({'COMB weights','COMBEX weights'});
           
end

set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
 

 filename = ['HD_COMB_COMBEX_weights_', int2str(cell)];

saveas(gcf,[filename],'epsc');
close(gcf);



end

      
end

