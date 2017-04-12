function touretzky_search(phiE, phiI, RC)

%This program performs a 3D parameter search for phiE1I1 and phiI1E1 in the
%amputated oscillator for a specific RC range.
%Expects parameter ranges given as arrays.
%Starts in parent folder 'parentpath', in which you need to put the .exe 'gaussian_oscillator'.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Hector JI Page Date: 30/11/11         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for adx = 1:numel(RC)
    dirstringRC = [num2str(RC(adx))];
    parentpath = ['~/video_conflict/touretzky_new_paradigm/parameter_search'];
    tier_1_path = [parentpath,'/',dirstringRC];
    
    if ~exist(tier_1_path, 'dir')
        mkdir(tier_1_path);
    end
  
    cd(tier_1_path);       

    for idx = 1:numel(phiE)
        dirstringE = [num2str(phiE(idx))];
        tier_2_path = [tier_1_path,'/',dirstringE];
    
        if exist(tier_2_path, 'dir')        
            cd(tier_2_path); 
        else
            mkdir(tier_2_path);
            cd(tier_2_path);
        
        end
    
        for jdx = 1:numel(phiI)
    
            dirstringI = [num2str(phiI(jdx))];
            tier_3_path = [tier_2_path, '/', dirstringI];
		
            if ~exist(tier_3_path, 'dir')
            
            mkdir(tier_3_path);
            copyfile('~/video_conflict/touretzky_new_paradigm/parameter_search/touretzky_new', tier_3_path);
            cd(tier_3_path);
        
            fid = fopen('touretzky_parameters.dat', 'w+');  
            fprintf(fid, 'time = 5.0\n');
            fprintf(fid, 'E1 cells = 500\n');
            fprintf(fid, 'RC1 connections = 500\n');    
            fprintf(fid, 'phi RC1 = 200.0\n');		
            fprintf(fid, 'tau E1 = 0.001\n');   
            fprintf(fid, 'alpha E1 = 0.0\n');
            fprintf(fid, 'beta E1 = 0.3\n');
            fprintf(fid, 'timestep size = 0.0001\n');
            fprintf(fid, 'input time = 0.02\n');
            fprintf(fid, 'external inhibition = 0.0\n');
            fprintf(fid, 'global inhibition = 0.25\n');
            fprintf(fid, 'vis1 strength = 1.0\n'); 
            fprintf(fid, 'vis1 location = 180.0\n');
            fprintf(fid, ['vis1 sigma = ',dirstringRC,'\n']);   
            fprintf(fid, ['vis2 strength = ',dirstringE,'\n']); 
            fprintf(fid, ['vis2 location = ',dirstringI,'\n']);
            fprintf(fid, ['vis2 sigma = ',dirstringRC,'\n']);
            fprintf(fid, 'packet width = 20.0');
		
            fclose(fid);
        
            system(['./touretzky_new -fname touretzky_parameters.dat']);
		
            plot_touretzky(5.0,0.0001,500,'save','y');
            
            cd(tier_2_path);
        
            end
            
            cd(tier_2_path);
            
        end
    
        cd(tier_1_path); 
   
    end
    
    cd(parentpath);

end

end
