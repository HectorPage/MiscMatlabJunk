function norc_combslice(COMBcells)

   


COMBRates = zeros(COMBcells, 1);
COMBRates = file_load(COMBcells, 1, '_COMBslice.bdat');


COMBActs = zeros(COMBcells, 1);
COMBActs = file_load(COMBcells, 1, '_COMBactslice.bdat');

HDRates = zeros(COMBcells/2,1);
HDRates = file_load(COMBcells/2,1, '_HDslice.bdat');

    COMB_sparseness = 0;
    COMB_firing_sum = 0;
    COMB_firing_square_sum = 0;

    for index = 1:COMBcells
    COMB_firing_sum = COMB_firing_sum + COMBRates(index);
    
    COMB_firing_square_sum = COMB_firing_square_sum + ((COMBRates(index) * COMBRates(index))/COMBcells);
    end
    
    COMB_sparseness = ((COMB_firing_sum/COMBcells) * (COMB_firing_sum/COMBcells)) / (COMB_firing_square_sum)
                
%PLOTTING CELL FIRING RATES%
    figure();
    plot(COMBRates(:));
    ylim([0,1]);
    
    figure();
    plot(COMBActs(:), 'r');
    %ylim([0,13]);
    
    figure();
    plot(HDRates(:));
    ylim([0,1]);
    
   
end

function rates = file_load(cells, steps, fname)
        
       rates = zeros(cells, steps);
       
       fid = fopen(fname, 'rb');
       
       rates = fread(fid, [steps, cells], 'float32')';
       
       fclose(fid);
       
  
end
