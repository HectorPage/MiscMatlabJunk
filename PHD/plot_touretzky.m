function plot_touretzky(seconds, tsize, cells, mode, degrees)

        x = [tsize:tsize:seconds];
        
        steps = seconds/tsize;
        
        xtick = [0, 1, 2, 3, 4, 5];
        
        y1 = [1:cells(1)];
        [X1, Y1] = meshgrid(x, y1);

         
              pvector1 = file_load(cells(1), steps, 'Input_Location1.bdat');
              pvector2 = file_load(cells(1), steps, 'Input_Location2.bdat');
             
            E1Rates = zeros(cells(1), steps);
            
            E1Rates = file_load(cells(1), steps, 'E1Rates.bdat');

                figure();
        
                h1 = surf(X1, Y1, E1Rates);
                set(h1, 'LineStyle', 'none');
                xlabel('Time (seconds)');
                set(gca, 'XTick', xtick);
                ylabel('Cell')
                ylim([1 cells(1)]);
                xlim([0 seconds])
                title('Cell Firing Rates')
                colormap(1-gray);
                view(0, 90);
               
              

				if (strcmpi(mode, 'save'))
                  saveas(gcf,'Population_Rates', 'epsc');
                  close(gcf);
                end
                
          
               
                
                figure();
                
                if (strcmpi(degrees, 'y'));
             
                    xdegrees = zeros(1, cells);
                    increment = 360/cells;
             
                    for cell = 1 : cells;
                 
                    xdegrees(cell) = increment * cell;
                 
                    end
                
                    plot(xdegrees, pvector1(:,1), 'r');
                    hold on;
                    grid on;
                    plot(xdegrees, pvector2(:,steps), 'b');
                    plot(xdegrees, E1Rates(:,steps), '--k');
                    xlabel('Degrees');
                    set(gca,'XTick', [0,45,90,135,180,225,270,315,360]);
                    xlim([0,360]);
                    ylabel('Firing Rate');
                    title('Packet Locations');
                
					if (strcmpi(mode, 'save'))
					saveas(gcf,'Packet_Locations', 'epsc');
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
