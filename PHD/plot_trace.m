function plot_trace(seconds, tsize, cells, type)
%This function plots excitatory cell trace for all cells in either the test
%or training phase depending on 'type'


steps = seconds/tsize;


if strcmpi(type, 'trainall')||strcmpi(type, 'testall')
   
    E1Trace = zeros(cells, steps);
    
    x = linspace(0,seconds,steps);
    y = linspace(1,cells,cells);
    
    xtick = [0, seconds*0.25, seconds*0.5, seconds*0.75, seconds];
    
    [X, Y] = meshgrid(x, y);
    
   if strcmpi(type, 'trainall')
       
    E1Trace = file_load(cells, steps, 'Trace_Train.bdat', 'all');
    
    figure();
        
        h = surf(X, Y, E1Trace);
        set(h, 'LineStyle', 'none');
        xlabel('Time (seconds)');
        xlim([0,seconds]);
        set(gca, 'XTick', xtick);
        ylabel('E1 Cell')
        ylim([1 cells]);
        title('E1 Cell Trace')
        colormap(1-gray);
        view(0, 90);
				
        saveas(gcf,'E1_Population_Trace_Train', 'epsc')
		close(gcf)

    
   else
       
    E1Trace = file_load(cells, steps, 'Trace_Test.bdat', 'all');
    
     figure();
        
        h = surf(X, Y, E1Trace);
        set(h, 'LineStyle', 'none');
        xlabel('Time (seconds)');
        xlim([0,seconds]);
        set(gca, 'XTick', xtick);
        ylabel('E1 Cell')
        ylim([1 cells]);
        title('E1 Cell Trace')
        colormap(1-gray);
        view(0, 90);
				
        saveas(gcf,'E1_Population_Trace_Test', 'epsc')
		close(gcf)
   end
   
end

if strcmpi(type, 'trainsingle')||strcmpi(type, 'testsingle')
       
    E1Trace = zeros(1, steps);
    x = linspace(0,seconds,steps);
    xtick = [0, seconds*0.25, seconds*0.5, seconds*0.75, seconds];
    
    if strcmpi(type, 'trainsingle')
        E1Trace = file_load(cells, steps, 'Trace_Train.bdat', 'single');
        
        figure();
        
        plot(x, E1Trace, 'b');
        set(gca, 'XTick', xtick);
        xlim([0,seconds]);
        ylim([0 1])
        xlabel('Time (seconds)')
        ylabel('Firing Rate');
        title(['E1 Cell ', int2str(cells), ' Trace Training']);
        
        saveas(gcf, ['E1 Cell', int2str(cells),' Trace_Train'], 'epsc');
        close(gcf);
    end
    
    if strcmpi(type, 'testsingle')
        E1Trace = file_load(cells, steps, 'Trace_Test.bdat', 'single');
        
        figure();
        
        plot(x, E1Trace, 'b');
        set(gca, 'XTick', xtick);
        xlim([0,seconds]);
        ylim([0 1])
        xlabel('Time (seconds)')
        ylabel('Firing Rate');
        title(['E1 Cell ', int2str(cells), ' Trace Testing']);
        
        saveas(gcf, ['E1 Cell', int2str(cells),' Trace_Test'], 'epsc');
        close(gcf);
    end
end
       
    
       
   
end







function rates = file_load(cells, steps, fname, type)

    if(strcmpi(type, 'all'))
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
    elseif(strcmpi(type, 'single'))
        
        rates = zeros(1, steps);
        
        fid = fopen(fname, 'rb');
        
        fseek(fid, steps*4*(cells-1), 'bof');
        
        rates = fread(fid, steps, 'float32');
        
        fclose(fid);
        
    end
end

