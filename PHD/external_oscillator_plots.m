function external_oscillator_plots(seconds, tsize, cells, type, mode)

    
    if(strcmpi(type, 'allmulti')||strcmpi(type, 'ratesmulti')||strcmpi(type, 'activationsmulti')) 

        x = [tsize:tsize:seconds];
        
        steps = seconds/tsize;
        
        xtick = [0, 0.25, 0.5, 0.75, 1];
        
        y1 = [1:cells(1)];
        [X1, Y1] = meshgrid(x, y1);
        
        

        if(strcmpi(type, 'allmulti')||strcmpi(type, 'ratesmulti'))
    
            
            E1Rates = zeros(cells(1), steps);
            
            E1Rates = file_load(cells(1), steps, 'E1Rates.bdat', 'all');

            figure();
        
                h1 = surf(X1, Y1, E1Rates);
                set(h1, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('E1 Cell')
                ylim([1 cells(1)]);
                xlim([0 seconds])
                title('E1 Cell Firing Rates')
                colormap(1-gray);
                view(0, 90);

				if (strcmpi(mode, 'save'))
                    saveas(gcf,'E1 Population Rates', 'epsc');
                    close(gcf);
                end
                
      

            

        end
            
     end
    
        
        if(strcmpi(type, 'allmulti')||strcmpi(type, 'activationsmulti'))
        
            E1Activations = zeros(cells(1), steps);
     
            E1Activations = file_load(cells(1), steps, 'E1Activations.bdat', 'all');

            figure();
            
                h5 = surf(X1, Y1, E1Activations);
                set(h5, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('E1 Cell');
                ylim([1 cells(1)])
                xlim([0 seconds])
                title('E1 Cell Activations');
                colormap(1-gray);
                view(0, 90);

                if (strcmpi(mode, 'save'))
                    saveas(gcf,'E1 Population Activations', 'epsc')
                    close(gcf)
                end


        end
        
    
    
    
    if(strcmpi(type, 'allsingle')||strcmpi(type, 'ratessingle')||strcmpi(type, 'activationssingle')||strcmpi(type, 'ratesactivationssingle'))
    
        % The following lines set location and labels of the x axis ticks
      
        steps = seconds/tsize;
        
        x = linspace(0, seconds, steps);
        
        xtick = [0, seconds*0.25, seconds*0.5, seconds*0.75, seconds];
    
    
        % This code does the plotting
    
        if(strcmpi(type, 'allsingle')||strcmpi(type, 'ratessingle')|| strcmpi(type, 'ratesactivationssingle'))
        
            E1Rates = zeros(1, steps);

            E1Rates = file_load(cells(1), steps, 'E1Rates.bdat', 'single');
                
    
            figure();
    
                plot(x, E1Rates, 'b');
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlim([0 seconds])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title(['E1 Cell ', int2str(cells(1)), ' Firing Rate']);
    
                if (strcmpi(mode, 'save'))
                    saveas(gcf,'E1 Single Cell Firing Rate', 'epsc')
                    close(gcf)
                end


        end
    
        
        if(strcmpi(type, 'allsingle')||strcmpi(type, 'activationssingle')||strcmpi(type, 'ratesactivationssingle'))
  
        
            E1Activations = zeros(1, steps);

            E1Activations = file_load(cells(1), steps, 'E1Activations.bdat', 'single');
                
               
        
            figure();
    
                plot(x, E1Activations, 'b');
                set(gca, 'XTick', xtick);
                xlabel('Time (seconds)')
                ylabel('Activation Level');
                title(['E1 Cell ', int2str(cells(1)), ' Activation Levels']);
    
                if (strcmpi(mode, 'save'))
                    saveas(gcf,'E1 Single Cell Activations', 'epsc')
                    close(gcf)
                end


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
