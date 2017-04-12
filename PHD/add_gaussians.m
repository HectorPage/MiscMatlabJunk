function add_gaussians(offset, sigma, cells, cell_loc)

pref_dirs = zeros(1,cells);
increment = 360/cells;

pref_dirs = (increment:increment:360);

diff = zeros(1,cells);
off_diff = zeros(1,cells);

diff1 = 0;
diff2 = 0;

Gauss1 = zeros(1,cells);
Gauss2 = zeros(1,cells);
Gauss_add = zeros(1,cells);


for idx = 1:cells
    diff1 = abs(pref_dirs(idx) - pref_dirs(cell_loc));
    diff2 = 360 - diff1;
    
    if diff1 < diff2
        diff = diff1;
    else
        diff = diff2;
    end
end

diff1 = 0;
diff2 = 0;

for idx = 1:cells
    diff1 = abs(pref_dirs(idx) - pref_dirs(cell_loc + offset));
    diff2 = 360 - diff1;
    
    if diff1 < diff2
        off_diff = diff1;
    else
        off_diff = diff2;
    end
end
    
for idx = 1:cells
    Gauss1(idx) = exp(-0.5 * (diff(idx)/sigma) * (diff(idx)/sigma));
    
    Gauss2(idx) = exp(-0.5 * (off_diff(idx)/sigma) * (off_diff(idx)/sigma));
end

figure();
plot(Gauss1, 'b', LineWidth, 2.0);
hold on;
plot(Gauss2, 'r', LineWidth, 2.0);

Gauss_add = Gauss1+Gauss2;

plot(Gauss_add, '--k', LineWidth, 2.0);




end

