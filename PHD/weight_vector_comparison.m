function weight_vector_comparison(total_cells, ideal_remap)

%N.B. "ideal_remap" is the location of the conflicting visual landmark cue
%(i.e. it is ideal remap given complete cue capture)

final_vector = zeros(1,total_cells);

vector_compare = zeros(1,total_cells);

%Get final ff_weight vectors

fid = fopen('final_ff_weight_vectors.bdat', 'rb');

final_vector = fread(fid, 'float32');

fclose(fid);


for cell = 1:total_cells

    ideal_final_dir=(cell*0.72)+ideal_remap;
    
    if(ideal_final_dir>=360)
        ideal_final_dir=ideal_final_dir-360;
    end
    
    if(ideal_final_dir < final_vector(cell))
        vector_compare(cell) = (360 + ideal_final_dir) - final_vector(cell);        
    else
    vector_compare(cell) = abs(ideal_final_dir - final_vector(cell));
    end
    
end

bin = 0:10:total_cells;

hist(vector_compare, bin);
xlabel('Remap (Degrees)', 'fontsize', 30);
ylabel('Frequency (Cells)', 'fontsize', 30);
xlim([0,360]);
set(gca, 'XTick', [0:60:360], 'fontsize',30);
set(gca, 'YTick', [0:100:500], 'fontsize', 30)
saveas(gcf,'_histogram.png');

sine_sum=0;
cos_sum=0;

for cell = 1: numel(vector_compare)
    
    sine_sum=sine_sum+sind(vector_compare(cell));
    cos_sum=cos_sum+cosd(vector_compare(cell));
    
end

if(sine_sum>0&&cos_sum>0)
    
    mean_cells=atand(sine_sum/cos_sum);
    
elseif(cos_sum<0)
    
    mean_cells=atand(sine_sum/cos_sum)+180;
    
else
    
    mean_cells=atand(sine_sum/cos_sum)+360;
    
end

variance = var(vector_compare);
standard_deviation = sqrt(variance);

maximum = max(vector_compare);
minimum = min(vector_compare);

fileID = fopen('_statistics.txt','w');
formatSpec = 'Mean: %.2f \r\nVariance: %.2f \r\nS.D: %.2f \r\nMinimum: %.2f \r\nMaximium: %.2f';
fprintf(fileID,formatSpec, mean_cells, variance, standard_deviation, minimum, maximum);
fclose(fileID);
    


end