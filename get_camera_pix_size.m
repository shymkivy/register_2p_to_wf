clear;
close all;

%%

fpath = 'C:\Users\ys2605\Desktop\stuff\AC_data\mapping\cam_ruler';

%fname_grid = 'EMCCD_100um_grid.tif';
%fname_grid = 'ORCA_100um_grid_512.tif';

fname_grid = 'EMCCD_1mm_ruler.tif';
%fname_grid = 'ORCA_1mm ruler_512.tif';

% for orca, i do another binning from 512 to 256 in imageJ

object_size_um = 1000; % um

%%

im_f = Tiff([fpath '\' fname_grid],'r');

imageData = read(im_f);


%%
figure;
imagesc(imageData);
[x, y] = ginput(2);

%% compute calibration
dx = x(2)-x(1);
dy = y(2)-y(1);

dh = sqrt(dx^2 + dy^2);

pix_size = object_size_um/dh;  % um/pix

pix_size_x = object_size_um/dx;  % um/pix

fprintf('calib 3d for %s is %.3fum/pix\n',fname_grid, pix_size);

fprintf('calib x direction for %s is %.3fum/pix\n',fname_grid, pix_size_x);
