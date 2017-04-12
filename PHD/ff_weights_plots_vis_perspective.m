function ff_weights_plots_vis_perspective(cell_array, total_plots, rows, columns, total_cells)

total_sample_cells = rows*columns;

weights = zeros(total_sample_cells, total_cells);

for plot_number = [1:total_plots]
    
    cell = cell_array(plot_number);
    
    fid = fopen('final_ffweights.bdat', 'rb');      %Plot final weights first, to get correct overlaying (i.e. initital weights on top, only final deviations visisble)

weights = fread(fid, [total_cells, total_cells], 'float32')';

fclose(fid);

figure();

x = [1:total_cells];


%for(idx=1:total_sample_cells)
    %subplot(rows, columns, idx)
    
    plot(x, weights(:, cell), 'b','LineWidth',3);
    set(gca, 'FontSize',40);
    xlabel('Postsynaptic HD Cell', 'FontSize', 40);
    ylabel('Weight', 'FontSize', 40);
    ylim([0,0.25]);
    set(gca,'YTick',[0:0.05:0.25]);
    set(gca, 'FontSize',40);
    title(['Presynaptic Visual Cell: ', int2str(cell)], 'FontSize', 40);
  
    
%Overlaying final weights.

    fid = fopen('initial_ffweights.bdat', 'rb');

    weights = fread(fid, [total_cells, total_cells], 'float32')';

fclose(fid);

    hold on;
    plot(x, weights(:, cell), '--k','LineWidth',3);

set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
 


    filename = ['presyn_ff_weights_cell_', int2str(cell)];

saveas(gcf,[filename],'epsc');
close(gcf);

end
end

