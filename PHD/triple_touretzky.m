function triple_touretzky(seconds, tsize, cells, mode, degrees)

        x = [tsize:tsize:seconds];
        
        steps = seconds/tsize;
        
        xtick = [0, 0.25, 0.5, 0.75, 1];
        
        y1 = [1:cells(1)];
        [X1, Y1] = meshgrid(x, y1);

         
             
             
            E1Rates = zeros(cells(1), steps);
            
            E1Rates = file_load(cells(1), steps, 'E1Rates.bdat');


          
                pvector1 = file_load(cells(1), 1, 'Input_Location1.bdat');
                pvector2 = file_load(cells(1), 1, 'Input_Location2.bdat');
                pvector3 = file_load(cells(1), 1, 'Input_Location3.bdat');
                
                figure();
                
                if (strcmpi(degrees, 'y'));
             
                    xdegrees = zeros(1, cells);
                    increment = 360/cells;
             
                    for cell = 1 : cells;
                 
                    xdegrees(cell) = increment * cell;
                 
                    end
                
                    plot(xdegrees, pvector1, 'r');
                    hold on;
                    grid on;
                    plot(xdegrees, pvector2, 'b');
                    plot(xdegrees, pvector3, 'g');
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
                    plot(xaxis, pvector3, 'g');
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
