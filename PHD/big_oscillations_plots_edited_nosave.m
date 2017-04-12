function big_oscillations_plots_edited(seconds, tsize, cells, type)

    
    if(strcmpi(type, 'allmulti')||strcmpi(type, 'ratesmulti')||strcmpi(type, 'activationsmulti')) 

        x = [tsize:tsize:seconds];
        
        steps = seconds/tsize;
        
        xtick = [0, seconds*0.25, seconds*0.5, seconds*0.75, seconds];
        
        y1 = [1:cells(1)];
        [X1, Y1] = meshgrid(x, y1);
        
        y2 = [1:cells(2)];
        [X2, Y2] = meshgrid(x, y2);
        
        y3 = [1:cells(3)];
        [X3, Y3] = meshgrid(x, y3);
        
        y4 = [1:cells(4)];
        [X4, Y4] = meshgrid(x, y4);
        

        if(strcmpi(type, 'allmulti')||strcmpi(type, 'ratesmulti'))
    
            
            E1Rates = zeros(cells(1), steps);
            E2Rates = zeros(cells(2), steps);
            I1Rates = zeros(cells(3), steps);
            I2Rates = zeros(cells(4), steps);
            
            E1Rates = file_load(cells(1), steps, 'E1Rates.bdat', 'all');
            E2Rates = file_load(cells(2), steps, 'E2Rates.bdat', 'all');
            I1Rates = file_load(cells(3), steps, 'I1Rates.bdat', 'all');
            I2Rates = file_load(cells(4), steps, 'I2Rates.bdat', 'all');
        
        
            figure();
        
                h1 = surf(X1, Y1, E1Rates);
                set(h1, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('E1 Cell')
                ylim([1 cells(1)]);
                title('E1 Cell Firing Rates')
                colormap(1-gray);
                view(0, 90);
				
				%saveas(gcf,'E1 Population Rates', 'epsc')
				%close(gcf)

            figure();
        
                h2 = surf(X2, Y2, E2Rates);
                set(h2, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('E2 Cell')
                ylim([1 cells(2)])
                title('E2 Cell Firing Rates')
                colormap(1-gray);
                view(0, 90);

				%saveas(gcf,'E2 Population Rates', 'epsc')
				%close(gcf)


            if(cells(3)>1)
                
                figure();
        
                h3 = surf(X3, Y3, I1Rates);
                set(h3, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('I1 Cell')
                ylim([1 cells(3)])
                title('I1 Cell Firing Rates')
                colormap(1-gray);
                view(0, 90);

				%saveas(gcf,'I1 Population Rates', 'epsc')
				%close(gcf)


            end
            
            if(cells(4)>1)
            
                figure();
       
                h4 = surf(X4, Y4, I2Rates);
                set(h4, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('I2 Cell')
                ylim([1 cells(4)])
                title('I2 Cell Firing Rates')
                colormap(1-gray);
                view(0, 90);

				%saveas(gcf,'I2 Population Rates', 'epsc')
				%close(gcf)


                
            end
            
        end
    
        
        if(strcmpi(type, 'allmulti')||strcmpi(type, 'activationsmulti'))
        
            E1Activations = zeros(cells(1), steps);
            E2Activations = zeros(cells(2), steps);
            I1Activations = zeros(cells(3), steps);
            I2Activations = zeros(cells(4), steps);
            
            E1Activations = file_load(cells(1), steps, 'E1Activations.bdat', 'all');
            E2Activations = file_load(cells(2), steps, 'E2Activations.bdat', 'all');
            I1Activations = file_load(cells(3), steps, 'I1Activations.bdat', 'all');
            I2Activations = file_load(cells(4), steps, 'I2Activations.bdat', 'all');
        
        
            figure();
            
                h5 = surf(X1, Y1, E1Activations);
                set(h5, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('E1 Cell');
                ylim([1 cells(1)])
                title('E1 Cell Activations');
                colormap(1-gray);
                view(0, 90);


				%saveas(gcf,'E1 Population Activations', 'epsc')
				%close(gcf)


                
             figure();
             
                h6 = surf(X2, Y2, E2Activations);
                set(h6, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylim([1 cells(2)])
                ylabel('E2 Cell');
                title('E2 Cell Activations');
                colormap(1-gray);
                view(0, 90);

				%saveas(gcf,'E2 Population Activations', 'epsc')
				%close(gcf)


                
             figure();
             
                h7 = surf(X3, Y3, I1Activations);
                set(h7, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('I1 Cell')
                ylim([1 cells(3)])
                title('I1 Cell Activations');
                colormap(1-gray);
                view(0, 90);

				%saveas(gcf,'I1 Population Activations', 'epsc')
				%close(gcf)


            figure();
            
                h8 = surf(X4, Y4, I2Activations);
                set(h8, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('I2 Cell')
                ylim([1 cells(4)])
                title('I2 Cell Activations');
                colormap(1-gray);
                view(0, 90);

				%saveas(gcf,'I2 Population Activations', 'epsc')
				%close(gcf)


                
        end
        
    end
    
    
    if(strcmpi(type, 'allsingle')||strcmpi(type, 'ratessingle')||strcmpi(type, 'activationssingle')||strcmpi(type, 'phasesingle')||strcmpi(type, 'ratesactivationssingle')||strcmpi(type, 'ratesphasesingle')||strcmpi(type, 'activationsphasesingle'))
    
        % The following lines set location and labels of the x axis ticks
      
        steps = seconds/tsize;
        
        x = linspace(0, 1, steps);
        
        xtick = [0, seconds*0.25, seconds*0.5, seconds*0.75, seconds];
    
    
        % This code does the plotting
    
        if(strcmpi(type, 'allsingle')||strcmpi(type, 'ratessingle')|| strcmpi(type, 'ratesactivationssingle')||strcmpi(type, 'ratesphasesingle'))
        
            E1Rates = zeros(1, steps);
            E2Rates = zeros(1, steps);
            I1Rates = zeros(1, steps);
            I2Rates = zeros(1, steps);
            
            E1Rates = file_load(cells(1), steps, 'E1Rates.bdat', 'single');
            E2Rates = file_load(cells(2), steps, 'E2Rates.bdat', 'single');
            I1Rates = file_load(cells(3), steps, 'I1Rates.bdat', 'single');
            I2Rates = file_load(cells(4), steps, 'I2Rates.bdat', 'single');
            
        
            figure();
    
                subplot(4, 1, 1);
    
                plot(x, E1Rates, 'b');
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title(['E1 Cell ', int2str(cells(1)), ' Firing Rate']);
    
                subplot(4, 1, 2);
    
                plot(x, E2Rates, 'b');
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title(['E2 Cell ', int2str(cells(2)), ' Firing Rate']);
    
                subplot(4, 1, 3);
    
                plot(x, I1Rates, 'k');
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title(['I1 Cell ', int2str(cells(3)), ' Firing Rate']);
    
                subplot(4, 1, 4);
    
                plot(x, I2Rates, 'k');
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title(['I2 Cell ', int2str(cells(4)), ' Firing Rate']);

				%saveas(gcf,'Single Rates', 'epsc')
				%close(gcf)


        end
    
        
        if(strcmpi(type, 'allsingle')||strcmpi(type, 'activationssingle')||strcmpi(type, 'ratesactivationssingle')||strcmpi(type, 'activationsphasesingle'))
  
        
            E1Activations = zeros(1, steps);
            E2Activations = zeros(1, steps);
            I1Activations = zeros(1, steps);
            I2Activations = zeros(1, steps);
            
            E1Activations = file_load(cells(1), steps, 'E1Activations.bdat', 'single');
            E2Activations = file_load(cells(2), steps, 'E2Activations.bdat', 'single');
            I1Activations = file_load(cells(3), steps, 'I1Activations.bdat', 'single');
            I2Activations = file_load(cells(4), steps, 'I2Activations.bdat', 'single');
        
        
            figure();
    
                subplot(4, 1, 1);
    
                plot(x, E1Activations, 'b');
                set(gca, 'XTick', xtick);
                xlabel('Time (seconds)')
                ylabel('Activation Level');
                title(['E1 Cell ', int2str(cells(1)), ' Activation Levels']);
    
                subplot(4, 1, 2);
    
                plot(x, E2Activations, 'b');
                set(gca, 'XTick', xtick);
                xlabel('Time (seconds)')
                ylabel('Activation Level');
                title(['E2 Cell ', int2str(cells(2)), ' Activation Levels']);
    
                subplot(4, 1, 3);
    
                plot(x, I1Activations, 'k');
                set(gca, 'XTick', xtick);
                xlabel('Time (seconds)')
                ylabel('Activation Level');
                title(['I1 Cell ', int2str(cells(3)), ' Activation Levels']);
    
                subplot(4, 1, 4);
    
                plot(x, I2Activations, 'k');
                set(gca, 'XTick', xtick);
                xlabel('Time (seconds)')
                ylabel('Activation Level');
                title(['I2 Cells ', int2str(cells(4)), ' Activation Levels']);

				%saveas(gcf,'Single Activations', 'epsc')
				%close(gcf)


        end
    
        
        if(strcmpi(type, 'allsingle')||strcmpi(type, 'phasesingle')||strcmpi(type, 'ratesphasesingle')||strcmpi(type, 'activationsphasesingle'))
        
        
            if(~exist('E1Rates', 'var')&&~exist('E2Rates', 'var')&&~exist('I1Rates', 'var')&&~exist('I2Rates', 'var'))
            
                E1Rates = zeros(1, steps);
                E2Rates = zeros(1, steps);
                I1Rates = zeros(1, steps);
                I2Rates = zeros(1, steps);
            
                E1Rates = file_load(cells(1), steps, 'E1Rates.bdat', 'single');
                E2Rates = file_load(cells(2), steps, 'E2Rates.bdat', 'single');
                I1Rates = file_load(cells(3), steps, 'I1Rates.bdat', 'single');
                I2Rates = file_load(cells(4), steps, 'I2Rates.bdat', 'single');
            
            end
        
        
            figure();
    
                subplot(4, 1, 1);
        
                plot(x, E1Rates, 'b')
                hold on
                plot(x, E2Rates, 'k')
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title('E1 and E2 Firing Rates')
                legend(['E1 Cell ', int2str(cells(1))], ['E2 Cell ', int2str(cells(2))])
                legend('Location', 'NorthEastOutside')
                legend boxoff
        
                subplot(4, 1, 2);
        
                plot(x, E1Rates, 'b')
                hold on
                plot(x, I1Rates, 'k')
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title('E1 and I1 Firing Rates')
                legend(['E1 Cell ', int2str(cells(1))], ['I1 Cell ', int2str(cells(3))])
                legend('Location', 'NorthEastOutside')
                legend boxoff
        
                subplot(4, 1, 3);
        
                plot(x, E2Rates, 'b')
                hold on
                plot(x, I2Rates, 'k')
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title('E2 and I2 Firing Rates')
                legend(['E2 Cell ', int2str(cells(2))], ['I2 Cell ', int2str(cells(4))])
                legend('Location', 'NorthEastOutside')
                legend boxoff
        
                subplot(4, 1, 4);
        
                plot(x, I1Rates, 'b')
                hold on
                plot(x, I2Rates, 'k')
                set(gca, 'XTick', xtick);
                ylim([0 1])
                xlabel('Time (seconds)')
                ylabel('Firing Rate');
                title('I1 and I2 Firing Rates')
                legend(['I1 Cell ', int2str(cells(3))], ['I2 Cell ', int2str(cells(4))])
                legend('Location', 'NorthEastOutside')
                legend boxoff


				%saveas(gcf,'Single Phase', 'epsc')
				%close(gcf)


        
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