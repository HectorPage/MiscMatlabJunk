function offset_evo(total_cells, time, tsize, speed, plotmode, evo)

%Plotmode = 1 for plotting offset, = 0 for plotting weight vectors

%Reading in the weight vector log

timesteps = (time/tsize)/100;       %saving wVecs every 100th timestep in the C code, so this is 1/100....

wVecs_time = zeros(total_cells, timesteps);
wVecs_time = file_load(total_cells, timesteps, 'weight_vectors.bdat');


%now to calculate offsets from this weight vector

offsets_time = zeros(total_cells, timesteps);



for timestep = 1:timesteps
    
    for cell = 1:total_cells

        distance1 = abs((((cell-1) * 360.0/total_cells)) - wVecs_time(cell,timestep));
        
        distance2 = abs(360.0 - distance1);
        
        
        if(distance1<=distance2)
				distance = distance1;
			else
			
				distance = distance2;
        end
        
        
        
      
        %{
        distance1 = abs(wVecs_time(cell,timestep) - (((cell-1) * 360.0/total_cells)));
        
        distance2 = abs(360.0 - distance1);
        
        
        if(distance1<=distance2)
				distance = distance1;
			else
			
				distance = distance2;
        end
        %}
        

        
        offsets_time(cell, timestep) = distance;
    end
end


%Now plotting as a movie

fid = fopen('offset_mean.dat', 'w');
fprintf(fid, '%f\n', mean(offsets_time(:,timesteps)));
fclose(fid);

std(offsets_time(:,timesteps))

%offrounds = zeros(total_cells,timesteps);
%offrounds = (round(offsets_time(:,:)*1000))/1000;


if(evo)
    

    figure()
for idx = 1:timesteps
    
        if plotmode
    plot(offsets_time(:,idx), 'Linewidth', 2.0);
    %plot(offrounds(:,idx), 'Linewidth', 2.0);
        else
    plot(wVecs_time(:,idx)/(360/total_cells), 'Linewidth', 2.0);
        end
    title(['HD Layer offsets at timestep ', int2str(idx),'00']);
    xlabel('Receiving HD Cell');
    
        if plotmode
     ylabel('Offset');
      ylim([0,4]);
        else
     ylabel('Projecting Cell');
        end
        
    xlim([1 total_cells]);
   
    pause(speed);
    
end

end

final_weights = zeros(500,500);
fid = fopen('final_RCweights.bdat', 'rb');
final_weights = fread(fid, [500,500], 'float32')';

fclose(fid);

max_receive = zeros(1,total_cells); %To store the maximum receiving weight for each postsynaptic cell.
max_offset  =zeros(1,total_cells);  %To store the offset, in cells for each cell....

for cell = 1:total_cells
     [~,max_receive(cell)] = max(final_weights(:,cell));
     
     
end



max_receive(:) = max_receive(:) * (360.0/total_cells);

for cell = 1:total_cells

        distance1 = abs(((cell-1)*(360.0/total_cells)) - max_receive(cell));
        
        distance2 = abs(360.0 - distance1);
        
        
        if(distance1<=distance2)
				max_offset(cell)  = distance1;
			else
			
				max_offset(cell)  = distance2;
        end
        
        
end


figure();
plot(max_offset, 'Linewidth', 2.0); 
ylabel('Offset (deg)', 'Fontsize', 24);
xlabel('Receiving Cell', 'Fontsize', 24);
saveas(gcf,'offsets_cells', 'epsc');
close(gcf);




  end

function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end

