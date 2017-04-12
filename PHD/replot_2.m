function replot_2(seconds, tsize, cells, mode, degrees, dirstringRC)

        x = [tsize:(tsize*100):seconds]; %Now creates x as going from tsize to seconds in steps of tsize*10, as only saving data every 10th timestep.
        
        steps = ((seconds/tsize)/100); %Dividing by 10, as new program only saves every 10th timestep, to reduce filesize.
         
        pvector1 = file_load(cells(1), steps, 'Input_Location1.bdat');
        pvector2 = file_load(cells(1), steps, 'visring_location.bdat');
             
            E1Rates = zeros(cells(1), steps);
            
            E1Rates = file_load(cells(1), steps, 'E1Rates.bdat');

                
                figure();
                
                if (strcmpi(degrees, 'y'));
             
                    xdegrees = zeros(1, cells);
                    increment = 360/cells;
             
                    for cell = 1 : cells;
                 
                    xdegrees(cell) = increment * cell;
                 
                    end
                
                    plot(xdegrees, pvector1(:,1), 'r', 'LineWidth', 2.0);
                    hold on;
                    grid on;
                    plot(xdegrees, pvector2(:,steps), 'b', 'LineWidth', 2.0);
                    plot(xdegrees, E1Rates(:,steps), '--k', 'LineWidth', 2.0);
                    xlabel('Degrees', 'FontSize', 32);
                    set(gca,'XTick', [0,45,90,135,180,225,270,315,360]);
                    set(gca, 'FontSize',18);
                    xlim([0,360]);
                    ylabel('Firing Rate', 'FontSize', 32);
                    set(gca, 'FontSize',18);
                    title(['RC\sigma = ' , dirstringRC, '  FF\sigma = 65'], 'FontSize', 32);
                
					if (strcmpi(mode, 'save'))
					saveas(gcf,'Packet_Locations', 'pdf');
					close(gcf);
					end

                
                else
                    
                    xaxis = [1:cells];
                
                    plot(xaxis, pvector1, 'r');
                    hold on;
                    plot(xaxis, pvector2, 'b');
                    plot(xaxis, E1Rates(:,steps), '--k');
                    xlabel('Cells');
                    ylabel('Firing Rate');
                    title('Packet Locations');

					if (strcmpi(mode, 'save'))
					saveas(gcf,'Packet_Locations', 'epsc');
					close(gcf);
					end
                    
                end
                
               
                
end

function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end
