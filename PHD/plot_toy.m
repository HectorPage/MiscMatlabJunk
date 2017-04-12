function plot_toy(seconds, tsize, cells, mode, slice)

    steps = uint32(((seconds/tsize)/100)); %Dividing by 10, as new program only saves every 10th timestep, to reduce filesize.
 
    if slice %only looking at the last 10 seconds of simulation
         
         slice_steps = uint32(((10.0/tsize)/100));
         x = [tsize:(tsize*100):10.0];
         xtick = [0,slice_steps/4, slice_steps/2, (slice_steps/4)*3, slice_steps];
         xticklabel = [0,10.0/4, 10.0/2, (10.0/4)*3, 10.0];
    else
        
        x = [tsize:(tsize*100):seconds]; %Now creates x as going from tsize to seconds in steps of tsize*10, as only saving data every 10th timestep.
        xtick = [0,steps/4, steps/2, (steps/4)*3, steps];
        xticklabel = [0,seconds/4, seconds/2, (seconds/4)*3, seconds];
    
    end
   


y1 = [1:cells(1)];
[X1, Y1] = meshgrid(x, y1);

         
%LOADING CELL FIRING RATES%             
E1Rates = zeros(cells(1), steps);
E1Rates = file_load(cells(1), steps, 'HDRates.bdat');
                
%PLOTTING CELL FIRING RATES%
figure();
        
if slice
    
    slice_start = steps - slice_steps;
    
    sliceRates = zeros(cells(1), slice_steps);
    sliceRates = wkeep(E1Rates,[cells(1), slice_steps],[1,slice_start]); 

    h1 = surf(X1, Y1, sliceRates);
    
    set(h1, 'LineStyle', 'none');
    xlabel('Time (s)', 'Fontsize', 32);
    set(gca, 'XTick', xtick, 'Fontsize', 24);
    set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
    ylabel('Cell', 'Fontsize', 32);
    ylim([1 cells(1)]);
    xlim([0 10.0])
    colormap(1-gray);
    view(0, 90);
    
    if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_sliceRates', 'fig');
    close(gcf);
    end
else
    
    h1 = surf(X1, Y1, E1Rates);

    set(h1, 'LineStyle', 'none');
    xlabel('Time (s)', 'Fontsize', 32);
    set(gca, 'XTick', xtick, 'Fontsize', 24);
    set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
    ylabel('Cell', 'Fontsize', 32);
    ylim([1 cells(1)]);
    xlim([0 seconds])
    colormap(1-gray);
    view(0, 90);
    
    if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_rates', 'fig');
    close(gcf);
end
end        


    figure();
   
    xdegrees = zeros(1, cells);
    increment = 360/cells;
             
   for cell = 1 : cells;
                 
    xdegrees(cell) = increment * cell;
                 
   end
   
   plot(xdegrees, E1Rates(:,1), 'b');
   hold on;
   grid on;
   xlabel('Degrees');
   set(gca,'XTick', [0,45,90,135,180,225,270,315,360]);
   xlim([0,360]);
   ylabel('Firing Rate');
   title('Packet Locations');
              


 
if slice
   return;
end

increment = 360/cells;
favoured_view = zeros(1,cells);
                    
pvector_HD = zeros(1,steps);
pvector_HD_speed = zeros(1, steps-100);
             
%Set up favoured view vector format
                    
favoured_view = (0:cells-1)*increment;
                       


%CALCULATING PVECTORS%
for idx = 1:steps
                        
    vector1_HD = 0;
    vector2_HD = 0;
                        
                        
    for jdx = 1:cells
        vector1_HD = vector1_HD + (E1Rates(jdx,idx) * sind(favoured_view(jdx)));
        vector2_HD = vector2_HD + (E1Rates(jdx,idx) * cosd(favoured_view(jdx)));
                            
    end
    
    
    if((vector1_HD > 0) && (vector2_HD >0))
        pvector_HD(idx) = atand(vector1_HD/vector2_HD);
    elseif (vector2_HD < 0 )
        pvector_HD(idx) = (atand(vector1_HD/vector2_HD)) + 180;
    else
        pvector_HD(idx) = (atand(vector1_HD/vector2_HD)) + 360;
    end
    

 %CALCULATING PACKET SPEED%
    
%  if(idx>21)
%  
%    distance_one = abs(pvector_HD(idx-20) - pvector_HD(idx));
%    distance_two = abs(360.0 - distance_one);
%     
%    if(distance_one <= distance_two)
%        
%        pvector_HD_speed(idx) = distance_one/0.2;
%    else
%        pvector_HD_speed(idx) = distance_two/0.2;
%    end
%  end


if(idx>11)
theta1 = pvector_HD(idx-10);
theta2 = pvector_HD(idx);
    
 if theta1==theta2
        angle=0;
    else
        if theta1==0
            theta1=360;
        end

        if theta2==0
            theta2=360;
        end

        thetaReverse=theta1+180;
        
        if theta2<theta1
            theta2Adj=theta2+360;
        else
            theta2Adj=theta2;
        end

        theta1Rad=theta1*(pi/180);
        theta2Rad=theta2Adj*(pi/180);

        x1=cos(theta1Rad);
        y1=sin(theta1Rad);

        x2=cos(theta2Rad);
        y2=sin(theta2Rad);

        length=sqrt((x1-x2)^2+(y1-y2)^2);

        angle=acos((2-length^2)/2);
        angle=angle*(180/pi);

        if theta2Adj>thetaReverse
            angle=360-angle;
        end

        if angle==360
            angle=0;
        end
    end
    
  pvector_HD_speed(idx) = angle/0.1;
 
end
 

end
                    
                    

%PLOTTING PVECTOR%
figure();
plot((x),pvector_HD, 'b', 'Linewidth',2);
xlim([0,(seconds)]);
xlabel('Time (s)', 'FontSize', 32)
set(gca, 'XTick', xtick, 'Fontsize', 24);
set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
ylim([0,360]);
ylabel('P Vector', 'FontSize', 32);
set(gca, 'YTick', [60, 120, 180, 240, 300, 360],'Fontsize',24);
title('PVector', 'FontSize', 32);
                   
             
                    
if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_position', 'fig');
    close(gcf);
end
                                          
                   
%PLOTTING SPEED                    
figure();
plot(pvector_HD_speed, 'b', 'Linewidth', 2);           
%set(gca, 'XTick', xtick, 'Fontsize', 24);
xlim([0, steps]);
title('Packet Speed', 'FontSize', 32);
xlabel('Time (s)', 'FontSize', 32);
ylabel('Speed (deg/s)', 'FontSize', 32);
set(gca, 'YTick', [40, 80, 120, 160, 200],'Fontsize',24);
set(gca, 'XTick', xtick, 'Fontsize', 24);
set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
%ylim([0,200]);

if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_speeds','fig');
    close(gcf);
end
     
N = 10;
M = mean(pvector_HD_speed(end-N+1:end));

fid = fopen('speed.dat', 'w');
fprintf(fid, 'speed: %f', M);
fclose(fid);
               
                
end

function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end
