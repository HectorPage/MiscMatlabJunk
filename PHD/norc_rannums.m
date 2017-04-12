function norc_rannums

 
%NOW PLOTTING RANDOM BUFFERS TO SEE WHAT THE VALUES ARE
rannums50 = zeros(1,50);
rannums500 = zeros(1,500);
rannums5000 = zeros(1,5000);
rannums50000 = zeros(1,50000);
rannums500000 = zeros(1,500000);



fid = fopen('RanNums50.bdat', 'rb');
rannums50 = fread(fid, [1,50],'double');
fclose(fid);

figure();
hist(rannums50,10);
title('N = 50', 'Fontsize', 32);
xlabel('\DeltaT', 'Fontsize', 24);
%xlim([0,0.1]);
set(gca, 'Fontsize', 24);
saveas(gcf,'RanNums50', 'epsc');
close(gcf);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('RanNums500.bdat', 'rb');
rannums500 = fread(fid, [1,500],'double');
fclose(fid);

figure();
hist(rannums500,10);
title('N = 500', 'Fontsize', 32);
xlabel('\DeltaT', 'Fontsize', 24);
%xlim([0,0.1]);
set(gca, 'Fontsize', 24);
saveas(gcf,'RanNums500', 'epsc');
close(gcf);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('RanNums5000.bdat', 'rb');
rannums5000 = fread(fid, [1,5000],'double');
fclose(fid);


figure();
hist(rannums5000,10);
title('N = 5000', 'Fontsize', 32);
xlabel('\DeltaT', 'Fontsize', 24);
%xlim([0,0.1]);
set(gca, 'Fontsize', 24);
saveas(gcf,'RanNums5000', 'epsc');
close(gcf);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('RanNums50000.bdat', 'rb');
rannums50000 = fread(fid, [1,50000],'double');
fclose(fid);


figure();
hist(rannums50000,10);
title('N = 50000', 'Fontsize', 32);
xlabel('\DeltaT', 'Fontsize', 24);
%xlim([0,0.1]);
set(gca, 'Fontsize', 24);
saveas(gcf,'RanNums50000', 'epsc');
close(gcf);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('RanNums500000.bdat', 'rb');
rannums500000 = fread(fid, [1,500000],'double');
fclose(fid);


figure();
hist(rannums500000,10);
title('N = 500000', 'Fontsize', 32);
xlabel('\DeltaT', 'Fontsize', 24);
%xlim([0,0.1]);
set(gca, 'Fontsize', 24);
saveas(gcf,'RanNums500000', 'epsc');
close(gcf);

               
                
end

