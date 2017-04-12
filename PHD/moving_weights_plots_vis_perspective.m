function moving_weights_plots_vis_perspective(cell_array, total_plots, rows, columns, total_cells)

total_sample_cells = rows*columns;

final_weights = zeros(total_sample_cells, total_cells);

intermediate_weights = zeros(total_sample_cells, total_cells);

initial_weights = zeros(total_sample_cells, total_cells);

for plot_number = [1:total_plots]
    
    cell = cell_array(plot_number);
    
    fid = fopen('final_ffweights.bdat', 'rb');      %Plot final weights first, to get correct overlaying (i.e. initital weights on top, only final deviations visisble)

   final_weights = fread(fid, [total_cells, total_cells], 'float32')';

fclose(fid);

figure();

x = [1:total_cells];


%for(idx=1:total_sample_cells)
    %subplot(rows, columns, idx)
    
    plot(x, final_weights(:, cell), 'b','LineWidth',2);
    set(gca, 'FontSize',32);
    xlabel('Postsynaptic HD Cell', 'FontSize', 32);
    ylabel('Weight', 'FontSize', 32);
    set(gca, 'FontSize',32);
    title(['Presynaptic Visual Cell: ', int2str(cell)], 'FontSize', 32);
    ylim([0,0.5]);
    
    
    %Overlaying intermediate weights
    
    fid = fopen('intermediate_ffweights.bdat', 'rb');

    intermediate_weights = fread(fid, [total_cells, total_cells], 'float32')';

    fclose(fid);

    hold on;
    plot(x, intermediate_weights(:, cell), '--r','LineWidth',2);

    
    
%Overlaying initial weights.

    fid = fopen('initial_ffweights.bdat', 'rb');

    initial_weights = fread(fid, [total_cells, total_cells], 'float32')';

fclose(fid);

    hold on;
    plot(x, initial_weights(:, cell), '--k','LineWidth',2);
    
    legend('final weights','intermediate weights', 'initial weights');

set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
 


    filename = ['presyn_ff_weights_cell_', int2str(cell)];

saveas(gcf,[filename],'epsc');
close(gcf);

end
end

