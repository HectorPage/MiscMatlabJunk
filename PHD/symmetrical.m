function symmetrical(cell_array, total_plots, rows, columns, total_cells, seconds, tsize, mode)

total_sample_cells = rows*columns;

hax = axes;

if (strcmpi(mode,'overlay'))
sym_weights = zeros(total_sample_cells, total_cells);
asym_weights = zeros(total_sample_cells, total_cells);
both_weights = zeros(total_sample_cells, total_cells);

for plot_number = [1:total_plots]
    
    cell = cell_array(plot_number);
    
    fid = fopen('sym_weights.bdat', 'rb');

fseek(fid, total_cells*4*(cell-1), 'bof');

sym_weights = fread(fid, [total_cells, total_sample_cells], 'float32')';

fclose(fid);

fid = fopen('asym_weights.bdat', 'rb');

fseek(fid, total_cells*4*(cell-1), 'bof');

asym_weights = fread(fid, [total_cells, total_sample_cells], 'float32')';

fclose(fid);

fid = fopen('both_weights.bdat', 'rb');

fseek(fid, total_cells*4*(cell-1), 'bof');

both_weights = fread(fid, [total_cells, total_sample_cells], 'float32')';

fclose(fid);






%Plotting RC weights
figure();

x = [1:total_cells];

for(idx=1:total_sample_cells)
    subplot(rows, columns, idx)
    
    plot(x, sym_weights(idx, :), 'b', 'LineWidth',0.75);
    hold on;
    plot(x, asym_weights(idx, :), 'r', 'LineWidth',0.75);
    plot(x, both_weights(idx, :), 'k', 'LineWidth',0.75);
    
    plotline = line([cell,cell], get(hax,'YLim'), 'Color', [0 0 0]);
    
    set(plotline, 'LineStyle', '--');
    
    set(gca, 'FontSize',32);
    xlabel('Presynaptic Visual Cell', 'FontSize', 32);
    ylabel('Weight', 'FontSize', 32);
    set(gca, 'FontSize',32);
    title(['Postynaptic HD Cell: ', int2str(cell)], 'FontSize', 32);
    ylim([0,0.2]);
    legend({'Symmetrical Weights', 'Asymmetrical Weights', 'Additive Weights'});
    

end
end

end

if(strcmpi(mode,'rates'))

%Now doing HD layer firing plot

x = [tsize:(tsize*100):seconds]; %Now creates x as going from tsize to seconds in steps of tsize*10, as only saving data every 10th timestep.
        
        steps = uint32(((seconds/tsize)/100)); %Dividing by 10, as new program only saves every 10th timestep, to reduce filesize.
        
        xtick = [0:0.1:seconds];
        
        y1 = [1:total_cells(1)];
        [X1, Y1] = meshgrid(x, y1);
        
        E1Rates = zeros(total_cells(1), steps);
        E1Rates = file_load(total_cells(1), steps, 'E1Rates.bdat');
          
        figure();
        
                 h1 = surf(X1, Y1, E1Rates);
                 set(h1, 'LineStyle', 'none');
               xlabel('Time (seconds)');
               set(gca, 'XTick', xtick);
               ylabel('Cell')
              ylim([1 total_cells(1)]);
                 xlim([0 seconds])
                title('Cell Firing Rates')
                colormap(1-gray);
                 view(0, 90);
                 
                 saveas(gcf, 'Rates','epsc');
                 close(gcf);
    
end


if(strcmpi(mode,'weight'))
    
    
for plot_number = [1:total_plots]
    
    cell = cell_array(plot_number);
    
    weights = zeros(total_sample_cells, total_cells);
    fid = fopen('recurrent_weights.bdat', 'rb');
    fseek(fid, total_cells*4*(cell-1), 'bof');
    weights = fread(fid, [total_cells, total_sample_cells], 'float32')';
    fclose(fid);
    
    figure();

x = [1:total_cells];

for(idx=1:total_sample_cells)
    subplot(rows, columns, idx)
    
    plot(x, weights(idx, :), 'b', 'LineWidth',0.75);
    hold on;  
    plotline = line([cell,cell], get(hax,'YLim'), 'Color', [0 0 0]);
    
    set(plotline, 'LineStyle', '--');
    
    set(gca, 'FontSize',32);
    xlabel('Presynaptic Visual Cell', 'FontSize', 32);
    ylabel('Weight', 'FontSize', 32);
    set(gca, 'FontSize',32);
    title(['Postynaptic HD Cell: ', int2str(cell)], 'FontSize', 32);
    ylim([0,0.2]);
    
     saveas(gcf, 'Weight','epsc');
     close(gcf);
    

end
end

end
    
end

function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end
