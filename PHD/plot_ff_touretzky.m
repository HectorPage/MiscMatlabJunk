function plot_ff_touretzky(seconds, tsize, cells, mode, degrees, type)

        x = [tsize:(tsize*100):seconds]; %Now creates x as going from tsize to seconds in steps of tsize*10, as only saving data every 10th timestep.
        
        steps = uint32(((seconds/tsize)/100)); %Dividing by 10, as new program only saves every 10th timestep, to reduce filesize.
        
        xtick = [0:1:seconds];
        
        y1 = [1:cells(1)];
        [X1, Y1] = meshgrid(x, y1);

         
              pvector1 = file_load(cells(1), steps, 'Input_Location1.bdat');
              pvector2 = file_load(cells(1), steps, 'visring_location.bdat');
             
            E1Rates = zeros(cells(1), steps);
           
            switch type
                case 'hd'             
                    E1Rates = file_load(cells(1), steps, 'HDRates.bdat');
                case 'comb'
                    E1Rates = file_load(cells(1), steps, 'COMBRates.bdat');
                case 'combex'
                    E1Rates = file_load(cells(1), steps, 'COMBEXRates.bdat');
                case 'vis'
                   E1Rates = file_load(cells(1), steps, 'visring_location.bdat'); 
                case 'overlay'
                    E1Rates = file_load(cells(1), steps, 'HDRates.bdat');
                    VISRates = file_load(cells(1), steps, 'visring_location.bdat');
                    %COMBRates = file_load(cells(1), steps, 'COMBRates.bdat');
                    %COMBEXRates = file_load(cells(1), steps, 'COMBEXRates.bdat');
                    
                    %ROTRates = file_load(1, steps, 'ROTRates.bdat');
                    %NOROTRates = file_load(1, steps, 'NOROTRates.bdat');
            end
            
                 figure();
        
                 h1 = surf(X1, Y1, E1Rates);
                 set(h1, 'LineStyle', 'none');
               xlabel('Time (s)', 'Fontsize', 32);
               set(gca, 'XTick', xtick, 'Fontsize', 24);
               ylabel('Cell', 'Fontsize', 32);
              ylim([1 cells(1)]);
                 xlim([0 seconds])
                %title('Cell Firing Rates')
                colormap(1-gray);
                 view(0, 90);
               
              

 				if (strcmpi(mode, 'save'))
                   set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                   saveas(gcf,'_rates', 'png');
                   close(gcf);
                 end
                
          
               
                
                figure();
                
                if (strcmpi(degrees, 'y'));
             
                    xdegrees = zeros(1, cells);
                    increment = 360/cells;
             
                    for cell = 1 : cells;
                 
                    xdegrees(cell) = increment * cell;
                 
                    end
                
                    plot(xdegrees, pvector1(:,1), 'r', 'LineWidth', 1.5 );
                    hold on;
                    grid on;
                    plot(xdegrees, pvector2(:,steps), 'b', 'LineWidth', 1.5 );
                    plot(xdegrees, E1Rates(:,steps), '--k', 'LineWidth', 1.5 );
                    xlabel('Degrees', 'Fontsize',32);
                    set(gca,'XTick', [90,180,270,360],'Fontsize',24);
                    set(gca,'YTick', [0,1,2],'Fontsize',24);
                    xlim([0,360]);
                    ylabel('Firing Rate','Fontsize',32);
                    %title('Packet Locations');
                
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
                    
                if strcmpi(type, 'overlay')
                
                    increment = 360/cells;
                    favoured_view = zeros(1,cells);
                    
                    pvector_HD = zeros(1,steps);
                    pvector_VIS = zeros(1,steps);
                    pvector_COMB = zeros(1,steps);
                    pvector_COMBEX = zeros(1,steps);
                    diff_pvector = zeros(1, steps);
                    pvector_HD_speed = zeros(1, steps-100);
                    pvector_VIS_speed = zeros(1, steps-100);
                    %pvector_COMB_speed = zeros(1, steps-100);
                    %pvector_COMBEX_speed = zeros(1, steps-100);
                    
                    %Set up favoured view vector format
                    
                    favoured_view = (0:cells-1)*increment;
                       
                    
                    
                    for idx = 1:steps
                        
                        vector1_HD = 0;
                        vector2_HD = 0;
                        vector1_VIS = 0;
                        vector2_VIS = 0;
                     %   vector1_COMB = 0;
                      %  vector2_COMB = 0;
                        %vector1_COMBEX = 0;
                        %vector2_COMBEX = 0;
                        
                        for jdx = 1:cells
                            vector1_HD = vector1_HD + (E1Rates(jdx,idx) * sind(favoured_view(jdx)));
                            vector2_HD = vector2_HD + (E1Rates(jdx,idx) * cosd(favoured_view(jdx)));
                            
                            vector1_VIS = vector1_VIS + (VISRates(jdx,idx) * sind(favoured_view(jdx)));
                            vector2_VIS = vector2_VIS + (VISRates(jdx,idx) * cosd(favoured_view(jdx)));
                            
                       %     vector1_COMB = vector1_COMB + (COMBRates(jdx,idx) * sind(favoured_view(jdx)));
                        %    vector2_COMB = vector2_COMB + (COMBRates(jdx,idx) * cosd(favoured_view(jdx)));
                            
                            %vector1_COMBEX = vector1_COMBEX + (COMBEXRates(jdx,idx) * sind(favoured_view(jdx)));
                            %vector2_COMBEX = vector2_COMBEX + (COMBEXRates(jdx,idx) * cosd(favoured_view(jdx)));
                        end
                        
                        if((vector1_HD > 0) && (vector2_HD >0))
                            pvector_HD(idx) = atand(vector1_HD/vector2_HD);
                        elseif (vector2_HD < 0 )
                            pvector_HD(idx) = (atand(vector1_HD/vector2_HD)) + 180;
                        else
                                pvector_HD(idx) = (atand(vector1_HD/vector2_HD)) + 360;
                         end
                        
                        
                         if((vector1_VIS > 0) && (vector2_VIS >0))
                            pvector_VIS(idx) = atand(vector1_VIS/vector2_VIS);
                         elseif (vector2_VIS < 0 )
                            pvector_VIS(idx) = (atand(vector1_VIS/vector2_VIS)) + 180;
                          else
                                pvector_VIS(idx) = (atand(vector1_VIS/vector2_VIS)) + 360;
                         end
                         
                         % if((vector1_COMB > 0) && (vector2_COMB >0))
                          %  pvector_COMB(idx) = atand(vector1_COMB/vector2_COMB);
                        % elseif (vector2_COMB < 0 )
                         %   pvector_COMB(idx) = (atand(vector1_COMB/vector2_COMB)) + 180;
                         % else
                          %      pvector_COMB(idx) = (atand(vector1_COMB/vector2_COMB)) + 360;
                          % end
                         
                          
                          %if((vector1_COMBEX > 0) && (vector2_COMBEX >0))
                            %pvector_COMBEX(idx) = atand(vector1_COMBEX/vector2_COMBEX);
                         %elseif (vector2_COMBEX < 0 )
                            %pvector_COMBEX(idx) = (atand(vector1_COMBEX/vector2_COMBEX)) + 180;
                          %else
                                %pvector_COMBEX(idx) = (atand(vector1_COMBEX/vector2_COMBEX)) + 360;
                         %end
                         
                      diff_pvector(idx)=abs(pvector_HD(idx)-pvector_VIS(idx));
                      
                      if(diff_pvector(idx) > 180)
                          diff_pvector(idx) = 360 - diff_pvector(idx);
                      end
                      
                      if(idx>1)       
              
                          if(abs(pvector_HD(idx-1) - pvector_HD(idx)) < 0.0001)  %This condition might not be technically correct, but it works for now..........
                              
                              pvector_HD_speed(idx-1) = 0;
                              
                              
                            elseif(pvector_HD(idx)==pvector_HD(idx-1))
                                
                                pvector_HD_speed(idx-1) = 0;
                              
                              
                            elseif(pvector_HD(idx) < pvector_HD(idx-1))
                                  
                                  pvector_HD_speed(idx-1) = ((360 - pvector_HD(idx-1)) + pvector_HD(idx))/0.01;        
                                  
                         
                            elseif(pvector_HD(idx) > pvector_HD(idx-1))
                                     
                                      pvector_HD_speed(idx-1)= abs(pvector_HD(idx)-pvector_HD(idx-1))/0.01; 
                                  
                          end
                                                  
                          
                                                                          
                          if(abs(pvector_VIS(idx-1) - pvector_VIS(idx)) < 0.0001)  %This condition might not be technically correct, but it works for now..........
                              
                              pvector_VIS_speed(idx-1) = 0;
                              
                              
                            elseif(pvector_VIS(idx)==pvector_VIS(idx-1))
                                
                                pvector_VIS_speed(idx-1) = 0;
                              
                              
                            elseif(pvector_VIS(idx) < pvector_VIS(idx-1))
                                  
                                  pvector_VIS_speed(idx-1) = ((360 - pvector_VIS(idx-1)) + pvector_VIS(idx))/0.01;        
                                  
                         
                            elseif(pvector_VIS(idx) > pvector_VIS(idx-1))
                                     
                                      pvector_VIS_speed(idx-1)= abs(pvector_VIS(idx)-pvector_VIS(idx-1))/0.01; 
                                  
                          end
                          
                          
                                                                           
                           %if(abs(pvector_COMB(idx-1) - pvector_COMB(idx)) < 0.0001)  %This condition might not be technically correct, but it works for now..........
                              
                            %  pvector_COMB_speed(idx-1) = 0;
                              
                              
                            %elseif(pvector_COMB(idx)==pvector_COMB(idx-1))
                                
                             %   pvector_COMB_speed(idx-1) = 0;
                              
                              
                           % elseif(pvector_COMB(idx) < pvector_COMB(idx-1))
                                  
                            %      pvector_COMB_speed(idx-1) = ((360 - pvector_COMB(idx-1)) + pvector_COMB(idx))/0.01;        
                                  
                         
                           % elseif(pvector_COMB(idx) > pvector_COMB(idx-1))
                                     
                            %          pvector_COMB_speed(idx-1)= abs(pvector_COMB(idx)-pvector_COMB(idx-1))/0.01; 
                                  
                         % end
                          
                          %if(abs(pvector_COMBEX(idx-1) - pvector_COMBEX(idx)) < 0.0001)  %This condition might not be technically correct, but it works for now..........
                              
                              %pvector_COMBEX_speed(idx-1) = 0;
                              
                              
                            %elseif(pvector_COMBEX(idx)==pvector_COMBEX(idx-1))
                                
                                %pvector_COMBEX_speed(idx-1) = 0;
                              
                              
                            %elseif(pvector_COMBEX(idx) < pvector_COMBEX(idx-1))
                                  
                                  %pvector_COMBEX_speed(idx-1) = ((360 - pvector_COMBEX(idx-1)) + pvector_COMBEX(idx))/0.01;        
                                  
                         
                            %elseif(pvector_COMBEX(idx) > pvector_COMBEX(idx-1))
                                     
                                  %pvector_COMBEX_speed(idx-1)= abs(pvector_COMBEX(idx)-pvector_COMBEX(idx-1))/0.01; 
                                  
                          %end
                          
                          %if(pvector_HD_speed == 0)
                              %pvector_COMBEX_speed = 0;
                              %pvector_COMB_speed = 0;
                          %end
                          
                                  
                      end
                                                                                  
                      
                    end
                    
                    
                    for idx = 2:steps
                         if(pvector_HD_speed(idx-1) > 200.0)
                              pvector_HD_speed(idx-1) = 0.0;
                         end
                    end
                        
                    figure();
                    plot((x),pvector_HD, 'b', 'Linewidth',2);
                    hold on;
                    plot((x),pvector_VIS, 'r', 'Linewidth',2);
                    %plot(x,pvector_COMB, 'g')
                    %plot(x,pvector_COMBEX, 'k')
                    xlim([0,(seconds)]);
                    xlabel('Time (s)', 'FontSize', 32)
                    set(gca, 'XTick', xtick, 'Fontsize', 24);
                    ylim([0,360]);
                    ylabel('P Vector', 'FontSize', 32);
                    set(gca, 'YTick', [60, 120, 180, 240, 300, 360],'Fontsize',24);
                    %title('Pvector comparison');
                    
                   %legend({'HD Pvectors', 'VIS Pvectors'});
                    %lh=findall(gcf,'tag','legend');
                    %set(lh,'location','northeastoutside');
                    
                    if (strcmpi(mode, 'save'))
                    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
					saveas(gcf,'_positions', 'png');
					close(gcf);
                    end
                                          
                    
                    figure();
                    plot((x), diff_pvector, 'LineWidth', 2);
                    xlim([0, (seconds)]);
                    ylabel('Disparity (deg)', 'FontSize', 32);
                    xlabel('Time (s)', 'FontSize', 32);
                    set(gca, 'XTick', xtick, 'Fontsize', 24);
                    
                    %title('HD-VIS Pvector difference');
                    
                    figure();
                    plot(pvector_HD_speed, 'b');           
                    %set(gca, 'XTick', xtick, 'Fontsize', 24);
                    hold on;
                    plot(pvector_VIS_speed, 'r');
                    xlim([0, steps]);
                    %plot(pvector_COMB_speed, 'g');
                    %plot(pvector_COMBEX_speed, 'k');
                    %legend({'HD Speed', 'VIS Speed'});
                    %lh=findall(gcf,'tag','legend');
                    %set(lh,'location','northeastoutside');
                    %title('Packet Speeds');
                    xlabel('Time (s)', 'FontSize', 32);
                    ylabel('Speed (deg/s)', 'FontSize', 32);
                    set(gca, 'YTick', [40, 80, 120, 160, 200],'Fontsize',24);
                    set(gca, 'XTick', [100,200,300,400,500,600,700,800,900,1000,1100], 'Fontsize', 24);
                    set(gca, 'XTickLabel', [1,2,3,4,5,6,7,8,9,10,11],'Fontsize',24)
                    
                    if (strcmpi(mode, 'save'))
                        set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                        saveas(gcf,'_speeds','png');
                        close(gcf);
                    end
                    
                    %figure();
                    %plot(ROTRates, 'b');
                    %hold on
                    %plot(NOROTRates, 'r');
                    %title('Rotation Cell Firing');
                    %legend({'ROT Rates', 'NOROT Rates'});
                    
                    
                end
               
                
end

function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end
