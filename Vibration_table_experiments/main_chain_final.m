Sname = '32cm_left_2.mat';
csv_file = 'review/32_left_2.csv'; 
target_beads = 66; 
min_beads = 66;
y_order = 'descend';
thrDx = 6; 
xlim_plot = []; 

T = readtable(csv_file);
colmap = lower(string(T.Properties.VariableNames));
iF = find(colmap=="frame",1);
iX = find(colmap=="x",1);
iY = find(colmap=="y",1);


frame = T{:, iF};
xx = T{:, iX};
yy = T{:, iY};

valid = ~(isnan(frame) | isnan(xx) | isnan(yy));
frame = round(frame(valid));
xx = xx(valid);
yy = yy(valid);


[u_frames, ~, ic] = unique(frame, 'stable');
xx_cell = cell(numel(u_frames),1);
yy_cell = cell(numel(u_frames),1);

for k = 1:numel(u_frames)
mask = (ic == k);
xk = xx(mask);
yk = yy(mask);

[yk_sorted, idx] = sort(yk, y_order);
xk_sorted = xk(idx);
yy_cell{k} = yk_sorted;
xx_cell{k} = xk_sorted;
end


n_frames = numel(xx_cell);
is_good = false(n_frames,1);
for k = 1:n_frames
xk = xx_cell{k};

if numel(xk) < 2
is_good(k) = false;
continue
end
dx_neighbor = abs(diff(xk));
is_good(k) = all(dx_neighbor <= thrDx) && (numel(xk) >= min_beads);
end


xx_cell = xx_cell(is_good);
yy_cell = yy_cell(is_good);
u_frames_kept = u_frames(is_good);




n_keep = numel(xx_cell);
xxi = nan(n_keep, target_beads);
yyi = nan(n_keep, target_beads);

for i = 1:n_keep
xk = xx_cell{i};
yk = yy_cell{i};
xxi(i,:) = xk(1:target_beads);
yyi(i,:) = yk(1:target_beads);
end


avex = mean(xxi, 1, 'omitnan');
avey = mean(yyi, 1, 'omitnan');
stdx = std(xxi, 0, 1, 'omitnan');
stdy = std(yyi, 0, 1, 'omitnan');

figure(1); clf
scatter(avex, avey, 12, 'filled'); hold on
plot(avex, avey, '-k','LineWidth',1);
xlabel('X'); ylabel('Y');
title(sprintf('Averaged shape after intra-frame neighbor filter (|Δx|<=%g)', thrDx));
axis equal; grid on
hold on
if ~isempty(xlim_plot); xlim(xlim_plot); end



save(Sname,'xxi','yyi')