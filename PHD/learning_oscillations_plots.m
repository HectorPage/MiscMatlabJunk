function learning_oscillations_plots(seconds, tsize, cells, type, phase)

    
    if(strcmpi(type, 'allmulti')||strcmpi(type, 'ratesmulti')||strcmpi(type, 'activationsmulti')) 

        x = [tsize:tsize:seconds];
        
        steps = seconds/tsize;
        
        xtick = [0, 0.25, 0.5, 0.75, 1];
        
        y1 = [1:cells(1)];
        [X1, Y1] = meshgrid(x, y1);
        
        y2 = [1:cells(2)];
        [X2, Y2] = meshgrid(x, y2);
        

        if(strcmpi(type, 'allmulti')||strcmpi(type, 'ratesmulti'))
    
            
            E1Rates = zeros(cells(1), steps);
            I1Rates = zeros(cells(2), steps);
          
            
            if(strcmpi(phase, 'train'))
            
                E1Rates = file_load(cells(1), steps, 'E1RatesTrain.bdat', 'all');
                
                I1Rates = file_load(cells(2), steps, 'I1RatesTrain.bdat', 'all');
               
                
            elseif(strcmpi(phase, 'test'))
                
                E1Rates = file_load(cells(1), steps, 'E1RatesTest.bdat', 'all');
                
                I1Rates = file_load(cells(2), steps, 'I1RatesTest.bdat', 'all');
                
                
            else 
                disp('Unrecognised simulation phase. Usage: <seconds> <timestep size> <[number of cells]> <plot type> <simulation phase>');
     
            end
        
           
        
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

				if(strcmpi(phase, 'train'))
				saveas(gcf,'E1 Population Rates Training', 'epsc');
                close(gcf);
				else
				saveas(gcf,'E1 Population Rates Testing', 'epsc');
				close(gcf);
                end
      

            figure();
        
                h2 = surf(X2, Y2, I1Rates);
                set(h2, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('I1 Cell')
                ylim([1 cells(2)])
                xlim([0 seconds])
                title('I1 Cell Firing Rates')
                colormap(1-gray);
                view(0, 90);

				if(strcmpi(phase, 'train'))
				saveas(gcf,'I1 Population Rates Training', 'epsc');
                close(gcf);
				else
				saveas(gcf,'I1 Population Rates Testing', 'epsc');
				close(gcf);
                end

        end
            
     end
    
        
        if(strcmpi(type, 'allmulti')||strcmpi(type, 'activationsmulti'))
        
            E1Activations = zeros(cells(1), steps);
            
            I1Activations = zeros(cells(2), steps);
            
            
           if(strcmpi(phase, 'train'))
            
                E1Activations = file_load(cells(1), steps, 'E1ActivationsTrain.bdat', 'all');
                
                I1Activations = file_load(cells(2), steps, 'I1ActivationsTrain.bdat', 'all');
                
                
            elseif(strcmpi(phase, 'test'))
                
                E1Activations = file_load(cells(1), steps, 'E1ActivationsTest.bdat', 'all');
                
                I1Activations = file_load(cells(2), steps, 'I1ActivationsTest.bdat', 'all');
                
                
            else 
                disp('Unrecognised simulation phase. Usage: <seconds> <timestep size> <[number of cells]> <plot type> <simulation phase>');
     
            end
        
        
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


				saveas(gcf,'E1 Population Activations', 'epsc')
				close(gcf)


                
             figure();
             
                h6 = surf(X2, Y2, I1Activations);
                set(h6, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylim([1 cells(2)])
                xlim([0 seconds])
                ylabel('I1 Cell');
                title('I1 Cell Activations');
                colormap(1-gray);
                view(0, 90);

				saveas(gcf,'I1 Population Activations', 'epsc')
				close(gcf)

        end
        
    
    
    
    if(strcmpi(type, 'allsingle')||strcmpi(type, 'ratessingle')||strcmpi(type, 'activationssingle')||strcmpi(type, 'phasesingle')||strcmpi(type, 'ratesactivationssingle')||strcmpi(type, 'ratesphasesingle')||strcmpi(type, 'activationsphasesingle'))
    
        % The following lines set location and labels of the x axis ticks
      
        steps = seconds/tsize;
        
        x = linspace(0, seconds, steps);
        
        xtick = [0, seconds*0.25, seconds*0.5, seconds*0.75, seconds];
    
    
        % This code does the plotting
    
        if(strcmpi(type, 'allsingle')||strcmpi(type, 'ratessingle')|| strcmpi(type, 'ratesactivationssingle')||strcmpi(type, 'ratesphasesingle'))
        
            E1Rates = zeros(1, steps);
            
            I1Rates = zeros(1, steps);
            
            
            if(strcmpi(phase, 'train'))
            
                E1Rates = file_load(cells(1), steps, 'E1RatesTrain.bdat', 'single');
                
                I1Rates = file_load(cells(2), steps, 'I1RatesTrain.bdat', 'single');
               
                
            elseif(strcmpi(phase, 'test'))
                
                E1Rates = file_load(cells(1), steps, 'E1RatesTest.bdat', 'single');
                
                I1Rates = file_load(cells(2), steps, 'I1RatesTest.bdat', 'single');
                
                
            else 
                disp('Unrecognised simulation phase. Usage: <seconds> <timestep size> <[number of cells]> <plot type> <simulation phase>');
     
            end
            
        
            figure();
    
                subplot(2, 1, 1);
    
                plot(x, E1Rates, 'b');
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlim([0 seconds])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title(['E1 Cell ', int2str(cells(1)), ' Firing Rate']);
    
                subplot(2, 1, 2);
    
                plot(x, I1Rates, 'k');
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlim([0 seconds])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title(['I1 Cell ', int2str(cells(2)), ' Firing Rate']);

				saveas(gcf,'Single Rates', 'epsc')
				close(gcf)


        end
    
        
        if(strcmpi(type, 'allsingle')||strcmpi(type, 'activationssingle')||strcmpi(type, 'ratesactivationssingle')||strcmpi(type, 'activationsphasesingle'))
  
        
            E1Activations = zeros(1, steps);
            
            I1Activations = zeros(1, steps);
            
            
            if(strcmpi(phase, 'train'))
            
                E1Activations = file_load(cells(1), steps, 'E1ActivationsTrain.bdat', 'single');
                
                I1Activations = file_load(cells(2), steps, 'I1ActivationsTrain.bdat', 'single');
                
                
            elseif(strcmpi(phase, 'test'))
                
                E1Activations = file_load(cells(1), steps, 'E1ActivationsTest.bdat', 'single');
                
                I1Activations = file_load(cells(2), steps, 'I1ActivationsTest.bdat', 'single');
               
                
            else 
                disp('Unrecognised simulation phase. Usage: <seconds> <timestep size> <[number of cells]> <plot type> <simulation phase>');
     
            end
        
        
            figure();
    
                subplot(2, 1, 1);
    
                plot(x, E1Activations, 'b');
                set(gca, 'XTick', xtick);
                xlabel('Time (seconds)')
                ylabel('Activation Level');
                title(['E1 Cell ', int2str(cells(1)), ' Activation Levels']);
    
                subplot(2, 1, 2);
    
                plot(x, I1Activations, 'k');
                set(gca, 'XTick', xtick);
                xlabel('Time (seconds)')
                ylabel('Activation Level');
                title(['I1 Cell ', int2str(cells(2)), ' Activation Levels']);

				saveas(gcf,'Single Activations', 'epsc')
				close(gcf)


        end
    
        
        if(strcmpi(type, 'allsingle')||strcmpi(type, 'phasesingle')||strcmpi(type, 'ratesphasesingle')||strcmpi(type, 'activationsphasesingle'))
        
        
            if(~exist('E1Rates', 'var')&&~exist('I1Rates', 'var'))
            
                E1Rates = zeros(1, steps);
               
                I1Rates = zeros(1, steps);
                
                
             if(strcmpi(phase, 'train'))
            
                E1Rates = file_load(cells(1), steps, 'E1RatesTrain.bdat', 'single');
               
                I1Rates = file_load(cells(2), steps, 'I1RatesTrain.bdat', 'single');
                
                
            elseif(strcmpi(phase, 'test'))
                
                E1Rates = file_load(cells(1), steps, 'E1RatesTest.bdat', 'single');
                
                I1Rates = file_load(cells(2), steps, 'I1RatesTest.bdat', 'single');
                
                
            else 
                disp('Unrecognised simulation phase. Usage: <seconds> <timestep size> <[number of cells]> <plot type> <simulation phase>');
     
            end
            
            end
        
        
            figure();

                plot(x, E1Rates, 'b')
                hold on
                plot(x, I1Rates, 'k')
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlim([0 seconds])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title('E1 and I1 Firing Rates')

				saveas(gcf,'Single Phase', 'epsc')
				close(gcf)


        
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
