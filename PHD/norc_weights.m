function norc_weights(cell_array, total_plots, rows, columns, HD_cells, COMB_cells,speed, delay, SO)

total_sample_cells = rows*columns;



HDtoCOMB_weights = zeros(total_sample_cells, COMB_cells);
COMBtoHD_weights = zeros(total_sample_cells, HD_cells);

initial_HDtoCOMB_weights = zeros(total_sample_cells, COMB_cells);
initial_COMBtoHD_weights = zeros(total_sample_cells, HD_cells);


ROTtoCOMB_weights = zeros(HD_cells,COMB_cells);    
initial_ROTtoCOMB_weights = zeros(HD_cells, COMB_cells);


offset = ((speed*delay)/(360.0/HD_cells));


increment = 360/HD_cells;
favoured_view = zeros(1,HD_cells);
favoured_view = [1:HD_cells]*increment;


max_receive  = zeros(1,total_plots);
max_project = zeros(1, total_plots);
max_diff  = zeros(1,total_plots);

%  projection_file = fopen('_CombProjections.dat', 'w');

%for plot_number = [1:total_plots]
     %cell = cell_array(plot_number);
%     
%     fid = fopen('HDtoCOMBweights.bdat', 'rb');
%     HDtoCOMB_weights = fread(fid, [HD_cells, COMB_cells], 'float32');
%     fclose(fid);
%     
%     if exist('initial_HDtoCOMBweights.bdat');
%     fid = fopen('initial_HDtoCOMBweights.bdat','rb');
%     initial_HDtoCOMB_weights = fread(fid, [HD_cells, COMB_cells], 'float32');
%     fclose(fid);
%     end
%     
%     %Plotting HD to COMB weights first: all receiving weights for a given
%     %POSTsynaptic COMB cell
%    
% 
%     x = [1:HD_cells]; %x is presynaptic HD cells cells
%   
%     
%     
%     %Getting maximum of HD to COMB weight profile
%    
%         vector1 = 0.0;
%         vector2 = 0.0;
%         
%         max_receive = 0.0;
%         
%         for presynaptic = 1:HD_cells;
%             
% 			vector1 = vector1 + HDtoCOMB_weights(presynaptic, cell) * (sind(favoured_view(presynaptic)));
% 			vector2 = vector2 + HDtoCOMB_weights(presynaptic, cell) * (cosd(favoured_view(presynaptic)));
%%         end
%         
%         if (vector1 > 0.0 && vector2 > 0.0) 
% 		
% 			max_receive(plot_number) = (atand((vector1/vector2)));
% 		
% 		else if(vector2 < 0.0)
% 		
% 			max_receive(plot_number) = (atand((vector1/vector2))) + 180.0;
% 		
% 		else
% 		
% 			max_receive(plot_number) = (atand((vector1/vector2))) + 360.0;
%             
%             end
%         end
%         
%        % disp(max_receive);
%         
%        
%         fprintf(projection_file, '\nreceive: %f \t', max_receive(plot_number));
%        
% 
%   
%     
% %     figure();
% %     plot(x, HDtoCOMB_weights(:, cell), 'b', 'LineWidth',3); %cell indexes postsynaptic receiving cell, I think?
% %      if exist('initial_HDtoCOMBweights.bdat');
% %     hold on;
% %     plot(x, initial_HDtoCOMB_weights(:, cell), 'r', 'LineWidth',3);
% %      end
% %     set(gca, 'FontSize',32);
% %     xlabel('Presynaptic HD Cell', 'FontSize', 40);
% %     ylabel('Weight', 'FontSize', 40);
% %     %ylim([0,0.1]);
% %     %set(gca,'YTick',[0:0.025:0.1]);
% %     %xlim([1,1000]);
% %     set(gca, 'FontSize',40);
% %     set(gca, 'FontSize',40);
% %     title(['Postsynaptic COMB Cell: ', int2str(cell)], 'FontSize', 40);
% %     
% %     [value,location] = max(HDtoCOMB_weights(:,cell));
% %      
% %     set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
% %     set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
% %     filename = ['HDtoCOMBweights__cell_', int2str(cell)];
% %     saveas(gcf,[filename],'epsc');
% %     close(gcf);
% %     
    %if exist('ROTtoCOMBweights.bdat')
     
     %Plotting ROT to COMB weights: all  receiving weights for a given
     %POSTsynaptic COMB cells
     
   
     
%      fid = fopen('ROTtoCOMBweights.bdat', 'rb');          OLD VERSION
%      ROTtoCOMB_weights = fread(fid, [HD_cells, COMB_cells], 'float32');
%      fclose(fid);
%       if exist('initial_ROTtoCOMBweights.bdat');
%      fid = fopen('initial_ROTtoCOMBweights.bdat','rb');
%      initial_ROTtoCOMB_weights = fread(fid,[HD_cells, COMB_cells], 'float32');
%      fclose(fid);
      %end
% %  
    % figure();
 
     %x = [1:HD_cells]; %x is postsynaptic COMB cells THIS IS THE OLD
     %VERSION
     
  
   
%      plot(x, ROTtoCOMB_weights(:, cell), 'b', 'LineWidth',3); %OLD VERSION
%      if exist('initial_ROTtoCOMBweights.bdat');
%      hold on;
%      plot(x, initial_ROTtoCOMB_weights(:, cell), 'r', 'LineWidth',3);
%      end
%      set(gca, 'FontSize',32);
%      xlabel('Presynaptic ROT Cell', 'FontSize', 40);
%      ylabel('Weight', 'FontSize', 40);
%      %ylim([0,0.1]);
%     % set(gca,'YTick',[0:0.025:0.1]);\ZK
%      %xlim([1,500]);
%      set(gca, 'FontSize',40);
%      set(gca, 'FontSize',40);
%      title(['Postsynaptic COMB Cell: ', int2str(cell)], 'FontSize', 40);
%      
%      
%       
%      set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
%      set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
%      filename = ['ROTtoCOMBweights_cell_', int2str(cell)];
%      saveas(gcf,[filename],'epsc');
%      close(gcf);
     
% 
%     %Plotting COMB to HD weights: all projecting weights for a given
%     %PREsynaptic COMB cell
   

    fid = fopen('COMBtoHDweights.bdat', 'rb');
    COMBtoHD_weights = fread(fid, [COMB_cells, HD_cells], 'float32')';
    fclose(fid);
    
    if exist('initial_COMBtoHDweights.bdat');
    fid = fopen('initial_COMBtoHDweights.bdat', 'rb');
    initial_COMBtoHD_weights = fread(fid, [COMB_cells, HD_cells], 'float32')';
    fclose(fid);
    end

   y = [1:HD_cells]; % y is postsynaptic HD cells
    
   COMB_HD_peaks = zeros(1,COMB_cells);
   
   for presynaptic = 1:COMB_cells       
       [pks,locs] = findpeaks(COMBtoHD_weights(:,presynaptic),'MinPeakDistance',60, 'MinPeakHeight', 0.05);
       COMB_HD_peaks(presynaptic) = (numel(pks));      
   end
   
   pks = findpeaks(COMBtoHD_weights(:,50), 'MinPeakDistance',60, 'MinPeakHeight', 0.05)
   
%    
%    numel(COMB_HD_peaks(COMB_HD_peaks==6))
%    
%    hist(COMB_HD_peaks,6);
%    
%    figure()
%    plot(y, gradient(COMBtoHD_weights(:, 419)), 'b','LineWidth',3);
%    hold on
%    plot(y, COMBtoHD_weights(:, 419), 'r', 'LineWidth',3);
%    
%    figure();
%    plot(COMB_HD_peaks);
   
  
%    
%     %Getting maximum of COMB to HD weight profile
%    
%         vector1 = 0.0;
%         vector2 = 0.0;
%         
%         max_project = 0.0;
%         
%         for postsynaptic = 1:HD_cells;
%             
% 			vector1 = vector1 + COMBtoHD_weights(postsynaptic, cell) * (sind(favoured_view(postsynaptic)));
% 			vector2 = vector2 + COMBtoHD_weights(postsynaptic, cell) * (cosd(favoured_view(postsynaptic)));
%         end
%         
%         if (vector1 > 0.0 && vector2 > 0.0) 
% 		
% 			max_project(plot_number) = (atand((vector1/vector2)));
% 		
% 		else if(vector2 < 0.0)
% 		
% 			max_project(plot_number) = (atand((vector1/vector2))) + 180.0;
% 		
% 		else
% 		
% 			max_project(plot_number) = (atand((vector1/vector2))) + 360.0;
%             
%             end
%         end
%         
%         %disp(max_project);
%          
%        
%         fprintf(projection_file, 'project: %f \t', max_project(plot_number));
%         
%         
%         distance1 = 0.0;
%         distance2 = 0.0;
%         
%         distance1 = abs(max_project(cell) - max_receive(cell));	
%         distance2 = abs(360.0 - distance1);
% 			
% 	if(distance1<=distance2)
%         max_diff(plot_number) = distance1;
% 		fprintf(projection_file, 'difference: %f \n', max_diff(plot_number));
% 	else
% 		max_diff(plot_number) = distance2;	
% 		fprintf(projection_file, 'difference: %f \n', max_diff(plot_number));
%     end

   
    
    
   
%     plot(y, COMBtoHD_weights(:, cell), 'b','LineWidth',3);
%     if exist('initial_COMBtoHDweights.bdat');
%     hold on;
%     plot(y, initial_COMBtoHD_weights(:, cell), 'r','LineWidth',3);
%     end
%     set(gca, 'FontSize',32);
%     xlabel('Postsynaptic HD Cell', 'FontSize', 40);
%     ylabel('Weight', 'FontSize', 40);
%     %ylim([0,0.1]);
%     %set(gca,'YTick',[0:0.025:0.1]);
%     %xlim([1,1000]);
%     %Plotting location of max projecting HD cell current COMB cell receives
%     Q = [location,location];
%     D = [0,1];
%     hold on;
%     plot(Q,D, 'k', 'LineWidth',3);
%     set(gca, 'FontSize',40);
%     set(gca, 'FontSize',40);
%     title(['Presynaptic COMB Cell: ', int2str(cell)], 'FontSize', 40);
%    
%     
%    
%    
%     set(gcf,'Position', get(0,'Screensize'));   %Maximise figure to look good when saved.
%     set(gcf, 'PaperPositionMode', 'auto');      %Overwite tendency of 'saveas' command to resize figure back again.
%     filename = ['COMBtoHDweights__cell_', int2str(cell)];
%     saveas(gcf,[filename],'epsc');
%     close(gcf);


    
    
    
    
%end

%fclose(projection_file);

% dimension = [1:1:total_plots];
% figure()
% plot(dimension, max_diff);
%
end    

