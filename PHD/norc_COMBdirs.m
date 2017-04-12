function norc_COMBdirs(HD_cells, COMB_cells)


HDtoCOMB_weights = zeros(HD_cells, COMB_cells); %C code saves as pre-post
COMBtoHD_weights = zeros(COMB_cells, HD_cells); %C code saves as post-pre

COMB_receive = zeros(1,COMB_cells);
COMB_project = zeros(1,COMB_cells);
COMB_diff = zeros(1,COMB_cells);

increment = 360/HD_cells;
favoured_view = zeros(1,HD_cells);
favoured_view = [1:HD_cells]*increment;

 
    fid = fopen('HDtoCOMBweights.bdat', 'rb');
    HDtoCOMB_weights = fread(fid, [HD_cells, COMB_cells], 'float32');
    fclose(fid);
    
    
    fid = fopen('COMBtoHDweights.bdat', 'rb');
    COMBtoHD_weights = fread(fid, [HD_cells, COMB_cells], 'float32');
    fclose(fid);

for postsynaptic = 1:COMB_cells      
        vector1 = 0.0;
        vector2 = 0.0;
        
        for presynaptic = 1:HD_cells;
            
			vector1 = vector1 + HDtoCOMB_weights(presynaptic, postsynaptic) * (sin(favoured_view(presynaptic)*(pi/180.0)));
			vector2 = vector2 + HDtoCOMB_weights(presynaptic, postsynaptic) * (cos(favoured_view(presynaptic)*(pi/180.0)));
            
        end
        
        if (vector1 > 0.0 && vector2 > 0.0) 
		
			max_receive(postsynaptic)= (atan((vector1/vector2)) * (180.0/pi));
		
		else if(vector2 < 0.0)
		
			max_receive(postsynaptic) = (atan((vector1/vector2)) * (180.0/pi)) + 180.0;
		
		else
		
			max_receive(postsynaptic) = (atan((vector1/vector2)) * (180.0/pi)) + 360.0;
            
            end
        end
        
  end
  
end



%HERE CALCULATING THE DIFFERENCE FOR EACH COMB CELL OF 
        
for cell=1:COMB_cells    
distance1 = abs(COMB_project(cell) - COMB_receive(cell));	
distance2 = abs(360.0 - distance1);
			
	if(distance1<=distance2)
		COMB_diff(cell) = distance1;
	else
			
		COMB_diff(cell) = distance2;
    end


end

fid = fopen('_CombProjections.dat', 'w');
for cell=1:COMB_cells
fprintf(fid, 'receive: %f project: %f offset: %f \n', COMB_receive(cell), COMB_project(cell), COMB_diff(cell));
end
fclose(fid);



x = [1:COMB_cells];
figure();
plot(x, COMB_diff, 'b', 'LineWidth',3);
set(gca, 'FontSize',32);
xlabel('COMB Cell', 'FontSize', 40);
ylabel('Offset', 'FontSize', 40);
set(gca, 'FontSize',40);
title('COMB cell offsets', 'FontSize', 40);
     
set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
filename = 'COMBoffsets';
saveas(gcf,[filename],'epsc');
close(gcf);



%ALSO NEED TO THINK OF A WAY OF PLOTTING FIRING OF EACH COMB CELL DURING
%TESTING - IS IT SPECIFIC TO ROTATION OR NO ROTATION?


end    

