function norc_plot(seconds, tsize, cells, mode, COMB_specifics)

    
COMBcells = cells *2;
   
%SETTING UP INFO NEEDED TO PLOT
    steps = uint32(((seconds/tsize)/100)); %Not Dividing by 100, as new program DOESN'T save every 100th timestep, to reduce filesize.
    
    x = [tsize:(tsize*100):seconds]; %If going back to saving every 100th timestep, x = [tsize:(tsize*100):seconds];
    xtick = [0,steps/4, steps/2, (steps/4)*3, steps];
    xticklabel = [0,seconds/4, seconds/2, (seconds/4)*3, seconds];

         
%LOADING CELL FIRING RATES%             
E1Rates = zeros(cells, steps);
E1Rates = file_load(cells, steps, 'HDRates.bdat');
COMBRates = zeros(COMBcells, steps);
COMBRates = file_load(COMBcells, steps, 'COMBRates.bdat');
ROTRates = zeros(cells, steps);
ROTRates = file_load(cells, steps, 'ROTRates.bdat');
                


%NOW PLOTTING THE LAST 6 SECONDS (TEST PHASE) OF SIMULATIONS, FOR EASIER
%VISUALISATION OF TEST PERFROMANCE

HD_testphase_rates = zeros(cells, uint32(((4.0/tsize)/100)));
COMB_testphase_rates = zeros(COMBcells, uint32(((4.0/tsize)/100)));

HD_testphase_rates = E1Rates(:,(end-uint32(((4.0/tsize)/100)):end-1));
COMB_testphase_rates = COMBRates(:,(end-uint32(((4.0/tsize)/100)):end-1));


 Q = [tsize:(tsize*100):4.0];
 y1 = [1:cells];
[Q1, Y1] = meshgrid(Q, y1);

y2 = [1:COMBcells];
[Q2, Y2] = meshgrid(Q, y2);

figure();
        
 
    h1 = surf(Q1, Y1, HD_testphase_rates);

    set(h1, 'LineStyle', 'none');
    xlabel('Time (s)', 'Fontsize', 32);
    %set(gca, 'XTick',  'Fontsize', 24);
    %set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
    ylabel('Cell', 'Fontsize', 32);
    ylim([1 cells(1)]);
    %xlim([0 4])
    colormap(1-gray);
    view(0, 90);
    title('HD TEST Rates', 'FontSize', 32);
    
    if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_HDTESTrates', 'fig');
    close(gcf);
    end
    
    
    figure();


    h2 = surf(Q2, Y2, COMB_testphase_rates);
    
    set(h2, 'LineStyle', 'none');
    xlabel('Time (s)', 'Fontsize', 32);
    %set(gca, 'XTick', xtick, 'Fontsize', 24);
    %set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
    ylabel('Cell', 'Fontsize', 32);
    ylim([1 COMBcells]);
    %xlim([0 (seconds)])
    colormap(1-gray);
    view(0, 90);
    title('COMB TEST Rates', 'FontSize', 32);
    
    if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_COMBTESTrates', 'fig');
    close(gcf);
    end
    
   




% %PLOTTING CELL FIRING RATES%
% 
% y1 = [1:cells];
% [X1, Y1] = meshgrid(x, y1);
% 
% y2 = [1:COMBcells];
% [X2, Y2] = meshgrid(x, y2);
% 
% 
% %Plotting sparseness of COMB cell layer over time
% COMB_sparseness = zeros(1,steps);
% 
% for counter = 1:steps
% 
%     COMB_firing_sum = 0;
%     COMB_firing_square_sum = 0;
% 
%     
%     for index = 1:COMBcells
%     COMB_firing_sum = COMB_firing_sum + COMBRates(index, counter);
%     
%     COMB_firing_square_sum = COMB_firing_square_sum + ((COMBRates(index, counter) * COMBRates(index, counter))/COMBcells);
%     end
%     
%     COMB_sparseness(counter) = ((COMB_firing_sum/COMBcells) * (COMB_firing_sum/COMBcells)) / (COMB_firing_square_sum);
%     
% end
% 
% figure();
% 
% plot(COMB_sparseness);
%  if (strcmpi(mode, 'save'))
%     set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
%     saveas(gcf,'_comb_sparseness', 'fig');
%     close(gcf);
%     end

% figure();
%         
%  
%     h1 = surf(X1, Y1, E1Rates);
% 
%     set(h1, 'LineStyle', 'none');
%     xlabel('Time (s)', 'Fontsize', 32);
%     set(gca, 'XTick', xtick, 'Fontsize', 24);
%     set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
%     ylabel('Cell', 'Fontsize', 32);
%     ylim([1 cells(1)]);
%     %xlim([0 (seconds)])
%     colormap(1-gray);
%     view(0, 90);
%     title('HD Rates', 'FontSize', 32);
%     
%     if (strcmpi(mode, 'save'))
%     set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
%     saveas(gcf,'_HDrates', 'fig');
%     close(gcf);
%     end
%     
% 
%     figure();
%         
%  
%     h1 = surf(X1, Y1, ROTRates);
% 
%     set(h1, 'LineStyle', 'none');
%     xlabel('Time (s)', 'Fontsize', 32);
%     set(gca, 'XTick', xtick, 'Fontsize', 24);
%     set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
%     ylabel('Cell', 'Fontsize', 32);
%     ylim([1 cells(1)]);
%     %xlim([0 (seconds)])
%     colormap(1-gray);
%     view(0, 90);
%     title('ROT Rates', 'FontSize', 32);
%     
%     if (strcmpi(mode, 'save'))
%     set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
%     saveas(gcf,'_ROTrates', 'fig');
%     close(gcf);
%     end
%     
% figure();
% 
% 
%     h2 = surf(X2, Y2, COMBRates);
%     
%     set(h2, 'LineStyle', 'none');
%     xlabel('Time (s)', 'Fontsize', 32);
%     %set(gca, 'XTick', xtick, 'Fontsize', 24);
%     %set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
%     ylabel('Cell', 'Fontsize', 32);
%     ylim([1 COMBcells]);
%     %xlim([0 (seconds)])
%     colormap(1-gray);
%     view(0, 90);
%     title('COMB Rates', 'FontSize', 32);
%     
%     if (strcmpi(mode, 'save'))
%     set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
%     saveas(gcf,'_COMBrates', 'epsc');
%     close(gcf);
%     end
%     
%     
%     

% 


%CALCULATING HD PVECTOR%


increment = 360/cells;
favoured_view = zeros(1,cells);
                    
testing_steps = uint32(((4.0/tsize)/100));
two_seconds = uint32(((2.0/tsize)/100));

pvector_HD = zeros(1,testing_steps);
pvector_HD_speed = zeros(1, testing_steps-100); %THIS HAS BEEN CHANGED FROM testing_steps-100
             
%Set up favoured view vector format
                    
favoured_view = (0:cells-1)*increment;
                       



for idx = 1:testing_steps
                        
    vector1_HD = 0;
    vector2_HD = 0;
                        
                        
    for jdx = 1:cells
        vector1_HD = vector1_HD + (HD_testphase_rates(jdx,idx) * sind(favoured_view(jdx)));
        vector2_HD = vector2_HD + (HD_testphase_rates(jdx,idx) * cosd(favoured_view(jdx)));
                            
    end
    
    
    if((vector1_HD > 0) && (vector2_HD >0))
        pvector_HD(idx) = atand(vector1_HD/vector2_HD);
    elseif (vector2_HD < 0 )
        pvector_HD(idx) = (atand(vector1_HD/vector2_HD)) + 180;
    else
        pvector_HD(idx) = (atand(vector1_HD/vector2_HD)) + 360;
    end


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
    
  pvector_HD_speed(idx) = angle/(tsize*1000); 
 
end
 

 if pvector_HD_speed(idx)>360
     pvector_HD_speed(idx) = 0;
 end
end

%PLOTTING PVECTOR
figure();
plot(pvector_HD, 'b', 'Linewidth', 2);           
%set(gca, 'XTick', xtick, 'Fontsize', 24);
%xlim([0, steps]);
title('HD Test Motion', 'FontSize', 32);
xlabel('Test Phase Time (s)', 'FontSize', 32);
ylabel('Pvector (deg)', 'FontSize', 32);
set(gca, 'YTick', [0:60:360],'Fontsize',24);
%set(gca, 'XTick', xtick, 'Fontsize', 24);
set(gca, 'XTickLabel',[0:0.5:4],'Fontsize',24);
%ylim([0,200]);

if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_pvector','fig');
    close(gcf);
end                    
                    
                   
%PLOTTING SPEED                    
figure();
plot(pvector_HD_speed, 'b', 'Linewidth', 2);           
%set(gca, 'XTick', xtick, 'Fontsize', 24);
%xlim([0, steps]);
title('Packet Speed', 'FontSize', 32);
xlabel('Time (s)', 'FontSize', 32);
ylabel('Speed (deg/s)', 'FontSize', 32);
set(gca, 'YTick', [0:20:200],'Fontsize',24);
%set(gca, 'XTick', xtick, 'Fontsize', 24);
%set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
%ylim([0,200]);

if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_speeds','fig');
    close(gcf);
end




%PLOTTING COOL COMB OVERLAY
for counter = 1:numel(COMB_specifics)
  
    figure();
    [hAx, hline1, hline2] = plotyy(Q, COMB_testphase_rates(COMB_specifics(counter),:), Q, pvector_HD);
    
    
    %xlabel('Test Phase Time (s)', 'Fontsize', 32);
    
    set(hAx(1), 'YLim', [0,1.027]);
    set(hAx(1), 'YTick', [0:0.25:1],'Fontsize',24);
    
    set(hAx(2), 'YLim', [0,370]);
    set(hAx(2), 'YTick', [0:90:360], 'Fontsize', 24);
    
    set(hAx(1),'ycolor','k');
    set(hAx(2),'ycolor','k');
    
    set(hAx(1), 'XTick', [1,2,3,4],'Fontsize',24);
    set(hAx(2), 'XTick', [1,2,3,4], 'Fontsize', 24);
    
    set(hline1, 'color', 'r');
    set(hline1, 'linewidth', 2.0);
    %ylabel(hAx(1), 'Firing Rate', 'Fontsize', 32,'Color','r');
    set(hline2, 'color', 'b');
    set(hline2, 'linewidth', 2.0);
    %ylabel(hAx(2), 'HD PVector', 'Fontsize', 32, 'Color', 'b');
    
    %this_is_title = ['COMB cell ', int2str(COMB_specifics(counter))];
    %title(this_is_title,'FontSize', 32); 
    
    
    if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
     filename = ['COMB_specifics_cell_', int2str(COMB_specifics(counter))];
     saveas(gcf,[filename],'fig');
     close(gcf);
    end
    
end

%Calculating COMB firing rate peaks

COMB_peakcount = zeros(1,COMBcells);

COMB_rot_peaks = zeros(1,COMBcells); %This holds whether COMB cells are peaking in ROT or NOROT - first column in number of peaks in NOROT, 2nd is ROT peaks
COMB_norot_peaks = zeros(1,COMBcells);
COMB_rot_diff = zeros(1,COMBcells);

COMB_tot_rotpeaks = zeros(1,COMBcells);

COMB_NONSPECIFIC = 0;
COMB_UNRESPONSIVE = 0;
COMB_ROT = 0;
COMB_NOROT = 0;
COMB_ROT_PURE = 0;
COMB_NOROT_PURE = 0;


for cell = 1:COMBcells
    combbradient = zeros(testing_steps);
    combgradient = gradient(COMB_testphase_rates(cell,:));   %Less of a noisier signal by looking at gradient - easier for [findpeaks]

    [pks, locs] = findpeaks(combgradient, 'MinPeakHeight', 0.2);

    COMB_peakcount(cell) = numel(pks);
    
    for counter = 1:numel(locs)
        if locs(counter)<=100 || locs(counter)>=300
            COMB_norot_peaks(cell) = COMB_norot_peaks(cell) + 1;
        else
            COMB_rot_peaks(cell) = COMB_rot_peaks(cell) + 1;
        end
               
    end
   
    COMB_rot_diff(cell) = abs(COMB_norot_peaks(cell) - COMB_rot_peaks(cell));
    
    
     
    if(COMB_rot_diff(cell) == 0)
        COMB_NONSPECIFIC = COMB_NONSPECIFIC +1;
        if(max(COMB_testphase_rates(cell,:))<0.25)
            COMB_UNRESPONSIVE = COMB_UNRESPONSIVE + 1;
        end
    continue;    
    end
    
    
    if(COMB_norot_peaks(cell)>COMB_rot_peaks(cell))
        COMB_NOROT = COMB_NOROT + 1;
        if(COMB_rot_peaks(cell) == 0)
            COMB_NOROT_PURE = COMB_NOROT_PURE + 1;
        end
    else
        COMB_ROT = COMB_ROT +1;
        if (COMB_norot_peaks(cell) == 0)
            COMB_ROT_PURE = COMB_ROT_PURE + 1;
        end
    end
    
    
    
    
   
% 
%     if(COMB_rot_diff(cell) > 0)
%         COMB_ROT = COMB_ROT + 1;
%         if(COMB_norot_peaks(cell) < 1)
%             COMB_ROT_PURE = COMB_ROT_PURE +1;
%         end
%     end
%     
%     if(COMB_rot_diff(cell) < 0)
%       COMB_NOROT = COMB_NOROT + 1;
%          if(COMB_rot_peaks(cell) < 1);
%             COMB_NOROT_PURE = COMB_NOROT_PURE +1;
%          end
%     end
end



COMB_NONSPECIFIC
COMB_UNRESPONSIVE
COMB_ROT
COMB_ROT_PURE
COMB_NOROT
COMB_NOROT_PURE

hist(COMB_peakcount,5)
figure();
plot(COMB_rot_diff);



% 
% figure();
% plot(COMB_peakcount)





% for cell = 1:COMBcells
% 
%     for indexer = 2:testing_steps
%    
%         if(COMB_testphase_rates(cell, indexer) > 0.75 && COMB_testphase_rates(cell, indexer) - COMB_testphase_rates(cell,indexer-1) > 0.25)
%             
%             COMB_peakcount(cell) = COMB_peakcount(cell) +1;
%           
%         end
%     end
% end


     
% N = 0.01/tsize; %N should be 1 second in timesteps, taking into account data is saved every 100th timestep.
% 
%  N = (0.01/tsize);
%  %M = pvector_HD_speed(end-(2*N));
%  M = mean(pvector_HD_speed(end-(2*N):end-N));
%  
%  fid = fopen('speed.dat', 'w');
%  fprintf(fid, 'speed: %f', M);
%  fclose(fid);
 
 
% % %NOW PLOTTING RANDOM BUFFERS TO SEE WHAT THE VALUES ARE
% % HD_delays = zeros(1,cells);
% % COMB_delays = zeros(1,COMBcells);
% % 
% % fid = fopen('HDBufferInitial.bdat', 'rb');
% % HD_delays = fread(fid, [1,cells],'int32');
% % fclose(fid);
% % 
% % fid = fopen('COMBBufferInitial.bdat', 'rb');
% % COMB_delays = fread(fid, [1,COMBcells],'int32');
% % fclose(fid);
% % 
% % 
% % figure();
% % hist(HD_delays,10);
% % 
% % figure();
% % hist(COMB_delays,10 );
% 

                
end

function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end
