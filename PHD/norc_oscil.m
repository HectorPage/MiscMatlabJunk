function norc_oscil (seconds, tsize, cells, mode)


    steps = uint32(((seconds/tsize)/100)); %Not Dividing by 100, as new program DOESN'T save every 100th timestep, to reduce filesize.
    
    x = [tsize:(tsize*100):seconds]; %If going back to saving every 100th timestep, x = [tsize:(tsize*100):seconds];
    xtick = [0,steps/4, steps/2, (steps/4)*3, steps];
    xticklabel = [0,seconds/4, seconds/2, (seconds/4)*3, seconds];
    
COMBcells = cells *2;
   

%LOADING CELL FIRING RATES%             
E1Rates = zeros(cells(1), steps);
E1Rates = file_load(cells(1), steps, 'HDRates.bdat');
COMBRates = zeros(COMBcells, steps);
COMBRates = file_load(COMBcells, steps, 'COMBRates.bdat');

             
%Set up favoured view vector format

increment = 360/cells;                    
favoured_view = (0:cells-1)*increment;
                       

%CALCULATING HD PVECTOR%

pvector_HD = zeros(1,steps);

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

end


%CALCULATING COMB PVECTORS%

pvector_COMB = zeros(1,steps);
for idx = 1:steps
                        
    vector1_COMB = 0;
    vector2_COMB = 0; 
                        
                        
    for jdx = 1:cells
        
        if idx <= uint32((1.1/tsize)/100) &&  idx >((3.1/tsize)/100)            %This if clause takes PVector of NOROT COMB vs. ROT COMB at the correct simulation times
            vector1_COMB = vector1_COMB + (COMBRates(jdx,idx) * sind(favoured_view(jdx)));
            vector2_COMB = vector2_COMB + (COMBRates(jdx,idx) * cosd(favoured_view(jdx)));
        else
            vector1_COMB = vector1_COMB + (COMBRates(jdx+500,idx) * sind(favoured_view(jdx)));
            vector2_COMB = vector2_COMB + (COMBRates(jdx+500,idx) * cosd(favoured_view(jdx)));
        end
                            
    end
    
    
    if((vector1_COMB > 0) && (vector2_COMB >0))
        pvector_COMB(idx) = atand(vector1_COMB/vector2_COMB);
    elseif (vector2_COMB < 0 )
        pvector_COMB(idx) = (atand(vector1_COMB/vector2_COMB)) + 180;
    else
        pvector_COMB(idx) = (atand(vector1_COMB/vector2_COMB)) + 360;
    end

end

%CALCULATING RATE OF CHANGE OF P VECTORS

PV_grad_HD = gradient(pvector_HD);
PV_grad_COMB = gradient(pvector_COMB);

PV_grad_HD(PV_grad_HD<0) = 0;
PV_grad_COMB(PV_grad_COMB<0) = 0;
PV_grad_HD(1:(uint32(((1.1/tsize)/100)-1))) = 0;    %Getting rid of dodgy readings cause by packet initialisation at start of simulations
PV_grad_COMB(1:(uint32(((1.1/tsize)/100)-1))) = 0;


%PLOTTING PVECTOR GRADIENTS
figure();
plot(x,PV_grad_HD, 'b', 'Linewidth',2);
hold on;
plot(x,PV_grad_COMB, 'r', 'Linewidth',2);
%xlim([0,(seconds)]);
xlabel('Time (s)', 'FontSize', 32)
%set(gca, 'XTick', xtick, 'Fontsize', 24);
%set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
%ylim([0,360]);
ylabel('Rate of P Vector Change', 'FontSize', 32);
%set(gca, 'YTick', [60, 120, 180, 240, 300, 360],'Fontsize',24);
title('Rate of P Vecor Change', 'FontSize', 32);
                   
             
                    
if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_gradient_position', 'fig');
    close(gcf);
end


 
%PLOTTING PVECTORS%
figure();
plot(x,pvector_HD, 'b', 'Linewidth',2);
hold on;
plot(x,pvector_COMB, 'r', 'Linewidth',2);
%xlim([0,(seconds)]);
xlabel('Time (s)', 'FontSize', 32)
%set(gca, 'XTick', xtick, 'Fontsize', 24);
%set(gca, 'XTickLabel',xticklabel,'Fontsize',24);
ylim([0,360]);
ylabel('P Vector', 'FontSize', 32);
set(gca, 'YTick', [60, 120, 180, 240, 300, 360],'Fontsize',24);
title('PVector', 'FontSize', 32);
                   
             
                    
if (strcmpi(mode, 'save'))
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    saveas(gcf,'_position', 'fig');
    close(gcf);
end

%Dumping final HD positions for reference

fid = fopen('positions.dat', 'w');
for counter = 1:100 
 fprintf(fid, '%f\n', pvector_HD(end-counter));
end
 fclose(fid);

end


function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end