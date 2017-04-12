function moving_HDCOMB_weights_plots(cell_array, total_plots, rows, columns, total_cells)

total_sample_cells = rows*columns;

weights = zeros(total_sample_cells, total_cells);

for plot_number = [1:total_plots]
    
    cell = cell_array(plot_number);
    
    fid = fopen('HD_COMB_weights.bdat', 'rb');

fseek(fid, total_cells*4*(cell-1), 'bof');

weights = fread(fid, [total_cells, total_sample_cells], 'float32')';

fclose(fid);

%Plotting Presynaptic receiving connections for a particular COMB cell
figure();

x = [1:total_cells];

for(idx=1:total_sample_cells)
    subplot(rows, columns, idx)
    
    plot(x, weights(idx, :), 'b', 'LineWidth',2);
    set(gca, 'FontSize',32);
    xlabel('Presynaptic HD Cell', 'FontSize', 32);
    ylabel('Weight', 'FontSize', 32);
    set(gca, 'FontSize',32);
    title(['Postynaptic COMB Cell: ', int2str(cell)], 'FontSize', 32);
    ylim([0,0.5]);
    hold on;
    line([250,250],[0,1]);
    
    
        
end

set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
 

 filename = ['postsyn_HD_COMB_weights_cell_', int2str(cell)];

saveas(gcf,[filename],'epsc');
close(gcf);

%Plotting Presynaptic receiving connections for a particular HD cell

for plot_number = [1:total_plots]
    
    cell = cell_array(plot_number);
    
    fid = fopen('COMB_HD_weights.bdat', 'rb');

fseek(fid, total_cells*4*(cell-1), 'bof');

weights = fread(fid, [total_cells, total_sample_cells], 'float32')';

fclose(fid);


%Plotting weights
figure();

x = [1:total_cells];

for(idx=1:total_sample_cells)
    subplot(rows, columns, idx)
    
    plot(x, weights(idx, :), 'b', 'LineWidth',2);
    set(gca, 'FontSize',32);
    xlabel('Presynaptic COMB Cell', 'FontSize', 32);
    ylabel('Weight', 'FontSize', 32);
    set(gca, 'FontSize',32);
    title(['Postynaptic HD Cell: ', int2str(cell)], 'FontSize', 32);
    ylim([0,0.5]);
    hold on;
    line([250,250],[0,1]);
    
    
        
end

set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
 

 filename = ['postsyn_COMB_HD_weights_cell_', int2str(cell)];

saveas(gcf,[filename],'epsc');
close(gcf);



end
end

