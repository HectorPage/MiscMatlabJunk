function oscillations_plots(seconds, tsize, type)

    load E1Rates.dat;
    load E2Rates.dat;
    
    load E1Activations.dat;
    load E2Activations.dat;
    
    load I1Rates.dat;
    load I2Rates.dat;
    
    load I1Activations.dat;
    load I2Activations.dat;
    
    
    % The following lines set location and labels of the x axis ticks
    
    timesteps = seconds/tsize;
    
    xtick = [0, timesteps*0.25, timesteps*0.5, timesteps*0.75, timesteps];
    xticklabel = {int2str(0) num2str(seconds*0.25) num2str(seconds*0.5) num2str(seconds*0.75) num2str(seconds)};
    
    
    % This code does the plotting
    
    if(strcmpi(type, 'all')||strcmpi(type, 'rates')|| strcmpi(type, 'ratesactivations')||strcmpi(type, 'ratesphase'))
    
        figure();
    
            subplot(4, 1, 1);
    
            plot(E1Rates, 'b');
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            ylim([0 1])
            xlabel('Time (seconds)')
            ylabel('Firing Rate');
            title('E1 Firing Rate');
    
            subplot(4, 1, 2);
    
            plot(E2Rates, 'b');
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            ylim([0 1])
            xlabel('Time (seconds)')
            ylabel('Firing Rate');
            title('E2 Firing Rate');
    
            subplot(4, 1, 3);
    
            plot(I1Rates, 'k');
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            ylim([0 1])
            xlabel('Time (seconds)')
            ylabel('Firing Rate');
            title('I1 Firing Rate');
    
            subplot(4, 1, 4);
    
            plot(I2Rates, 'k');
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            ylim([0 1])
            xlabel('Time (seconds)')
            ylabel('Firing Rate');
            title('I2 Firing Rate');
    
    end
    
    if(strcmpi(type, 'all')||strcmpi(type, 'activations')||strcmpi(type, 'ratesactivations')||strcmpi(type, 'activationsphase'))
  
        figure();
    
            maxx = zeros(1, 4);
        
            maxx(1) = max(E1Activations);
            maxx(2) = max(E2Activations);
            maxx(3) = max(I1Activations);
            maxx(4) = max(I2Activations);
        
            maxy = max(maxx);
    
            subplot(4, 1, 1);
    
            plot(E1Activations, 'b');
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            %ylim([0 maxy])
            xlabel('Time (seconds)')
            ylabel('Activation Level');
            title('E1 Activation Levels');
    
            subplot(4, 1, 2);
    
            plot(E2Activations, 'b');
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            %ylim([0 maxy])
            xlabel('Time (seconds)')
            ylabel('Activation Level');
            title('E2 Activation Levels');
    
            subplot(4, 1, 3);
    
            plot(I1Activations, 'k');
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            %ylim([0 maxy])
            xlabel('Time (seconds)')
            ylabel('Activation Level');
            title('I1 Activation Levels');
    
            subplot(4, 1, 4);
    
            plot(I2Activations, 'k');
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            %ylim([0 maxy])
            xlabel('Time (seconds)')
            ylabel('Activation Level');
            title('I2 Activation Levels');
            
    end
    
    if(strcmpi(type, 'all')||strcmpi(type, 'phase')||strcmpi(type, 'ratesphase')||strcmpi(type, 'activationsphase'))
        
    
        figure();
    
            subplot(4, 1, 1);
        
            plot(E1Rates, 'b')
            hold on
            plot(E2Rates, 'k')
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            ylim([0 1])
            xlabel('Time (seconds)')
            ylabel('Firing Rate');
            title('E1 and E2 Firing Rates')
            legend('E1', 'E2')
            legend('Location', 'NorthEastOutside')
            legend boxoff
        
            subplot(4, 1, 2);
        
            plot(E1Rates, 'b')
            hold on
            plot(I1Rates, 'k')
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            ylim([0 1])
            xlabel('Time (seconds)')
            ylabel('Firing Rate');
            title('E1 and I1 Firing Rates')
            legend('E1', 'I1')
            legend('Location', 'NorthEastOutside')
            legend boxoff
        
            subplot(4, 1, 3);
        
            plot(E2Rates, 'b')
            hold on
            plot(I2Rates, 'k')
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            ylim([0 1])
            xlabel('Time (seconds)')
            ylabel('Firing Rate');
            title('E2 and I2 Firing Rates')
            legend('E2', 'I2')
            legend('Location', 'NorthEastOutside')
            legend boxoff
        
            subplot(4, 1, 4);
        
            plot(I1Rates, 'b')
            hold on
            plot(I2Rates, 'k')
            set(gca, 'XTick', xtick);
            set(gca, 'XTickLabel', xticklabel)
            ylim([0 1])
            xlabel('Time (seconds)')
            ylabel('Firing Rate');
            title('I1 and I2 Firing Rates')
            legend('I1', 'I2')
            legend('Location', 'NorthEastOutside')
            legend boxoff
        
    end
    
end