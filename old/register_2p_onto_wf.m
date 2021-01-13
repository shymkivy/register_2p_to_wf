clear;
close all;

data_path = 'F:\data\Auditory\mapping_2p_reg_data';

%%
AC_data = readtable('C:\Users\rylab_dataPC\Desktop\Yuriy\AC_2p_analysis\AC_data_list.xlsx');
AC_data = AC_data(~isnan(AC_data.im_use_dset),:);

brighten_2p_frac = .6;

%%
wf_frames = unique(AC_data.mapping_wf_frame);
for n_fr = numel(wf_frames):-1:1
    if isempty(wf_frames{n_fr})
        wf_frames(n_fr) = [];
    end
end

%% build data struct
data_all = cell(numel(wf_frames),1);
for n_dset = 1:numel(wf_frames)
    temp_data = AC_data(strcmpi(AC_data.mapping_wf_frame, wf_frames{n_dset}),:);
    
    data_all{n_dset}.wf_frame = wf_frames{n_dset};
    data_all{n_dset}.mouse_tag = temp_data.mouse_tag{1};
    
    temp_data2 = unique(temp_data.mapping_reg_2p_fov);
    temp_data2 = temp_data2(~strcmpi(temp_data2, ''));
    
    for n_fov = 1:numel(temp_data2)
        temp_data3 = temp_data(strcmpi(temp_data2{n_fov}, temp_data.mapping_reg_2p_fov),:);
        data_all{n_dset}.mapping_files(n_fov,:) = temp_data3(1,{'mouse_tag', 'area', 'mapping_wf_frame', 'mapping_reg_2p_surface', 'mapping_reg_2p_fov'});
    end
end

%% load images into struct and create png files for the reg gui
for n_dset = 1:numel(wf_frames)
    for n_fov = 1:numel(temp_data2)
        wf_frame = data_all{n_dset}.wf_frame;
        wf_frame_path = [data_path '\' data_all{n_dset}.mouse_tag '\' wf_frame];
        if ~isfield(data_all{n_dset}, 'wf_frame_im')
            fig1 = open([wf_frame_path '.fig']);
            wf_im = fig1.Children.Children.CData;
            close(fig1);
            wf_im = wf_im - min(wf_im(:));
            wf_im = wf_im/max(wf_im(:));
            data_all{n_dset}.wf_frame_im = wf_im;
        end
        wf_im = data_all{n_dset}.wf_frame_im;
        if ~exist([wf_frame_path '.png'], 'file')
            imwrite(wf_im,[wf_frame_path '.png'],'PNG');
        end
        while ~exist([wf_frame_path '.png'], 'file')
            pause(1);
        end
        
        if ~isfield(data_all{n_dset}.mapping_files, 'surface_im')
            data_all{n_dset}.mapping_files.surface_im = cell(size(data_all{n_dset}.mapping_files,1),1);
        end
        if ~isfield(data_all{n_dset}.mapping_files, 'fov_im')
            data_all{n_dset}.mapping_files.fov_im = cell(size(data_all{n_dset}.mapping_files,1),1);
        end
        
        for n_tab = 1:size(data_all{n_dset}.mapping_files,1)    
            if ~isempty(data_all{n_dset}.mapping_files.mapping_reg_2p_surface{n_tab})            
                surface_im_path = [data_path '\' data_all{n_dset}.mouse_tag '\' data_all{n_dset}.mapping_files.mapping_reg_2p_surface{n_tab}];
                if isempty(data_all{n_dset}.mapping_files.surface_im{n_tab})
                    twop_im = double(imread([surface_im_path '.tif']));
                    twop_im = twop_im - min(twop_im(:));
                    twop_im = twop_im/max(twop_im(:));
                    data_all{n_dset}.mapping_files.surface_im{n_tab} = twop_im;
                end
                twop_im = data_all{n_dset}.mapping_files.surface_im{n_tab};
                if ~exist([surface_im_path '.png'], 'file')
                    imwrite(min(twop_im/brighten_2p_frac,1),[surface_im_path '.png'],'PNG');
                end
                while ~exist([surface_im_path '.png'], 'file')
                    pause(1);
                end
            end
            if ~isempty(data_all{n_dset}.mapping_files.mapping_reg_2p_fov{n_tab})      
                fov_im_path = [data_path '\' data_all{n_dset}.mouse_tag '\' data_all{n_dset}.mapping_files.mapping_reg_2p_fov{n_tab}];
                if isempty(data_all{n_dset}.mapping_files.fov_im{n_tab})
                    twop_im = double(imread([fov_im_path '.tif']));
                    twop_im = twop_im - min(twop_im(:));
                    twop_im = twop_im/max(twop_im(:));
                    data_all{n_dset}.mapping_files.fov_im{n_tab} = twop_im;
                end
                twop_im = data_all{n_dset}.mapping_files.fov_im{n_tab};
                if ~exist([fov_im_path '.png'], 'file')
                    imwrite(min(twop_im/brighten_2p_frac,1),[fov_im_path '.png'],'PNG');
                end
                while ~exist([fov_im_path '.png'], 'file')
                    pause(1);
                end
            end
        end
    end
end

%% first register all surface images
fig_reg = figure;
n_save = 1;
temp_data_out = struct();
for n_dset = 1:numel(wf_frames)
    wf_frame = data_all{n_dset}.wf_frame;
    wf_frame_path = [data_path '\' data_all{n_dset}.mouse_tag '\' wf_frame];
    wf_im = data_all{n_dset}.wf_frame_im;

    for n_tab = 1:size(data_all{n_dset}.mapping_files,1)
        surface_fname = data_all{n_dset}.mapping_files.mapping_reg_2p_surface{n_tab};
        if ~isempty(surface_fname)
            surface_im_path = [data_path '\' data_all{n_dset}.mouse_tag '\' surface_fname];
            twop_im = data_all{n_dset}.mapping_files.surface_im{n_tab};
            temp_data_old = data_out_surface(strcmpi({data_out_surface.moving_2p_im}, surface_fname));
            temp_data_old = temp_data_old(strcmpi({temp_data_old.ref_wf_im}, wf_frame));
            if isfield(temp_data_old, 'xy2p') && numel(temp_data_old)>0
                xy2p = temp_data_old.xy2p;
                xywf = temp_data_old.xywf;
            else
                xy2p = [];
                xywf = [];
            end
            if ~isempty(temp_data_old)
                tform = temp_data_old.tform;
                movingRegistered = imwarp(twop_im,tform,'OutputView',imref2d(size(wf_im)));
                figure(fig_reg);
                comb_im = wf_im;
                comb_im(movingRegistered>0) = movingRegistered(movingRegistered>0);
                figure(fig_reg); 
                subplot(1,2,1);
                imagesc(wf_im);axis equal tight;
                subplot(1,2,2);
                imagesc(comb_im);axis equal tight;
                title('Is loaded registration good? (y/n)');
                do_reg = ~ask_yes_no_fig();
            else
                do_reg = 1;
            end
            if do_reg
                reg_good = 0;
                fprintf('Registering %s\n', surface_fname)
                while ~reg_good
                    if isempty(xy2p)
                        [xy2p, xywf] = cpselect([surface_im_path '.png'],[wf_frame_path '.png'],'Wait',true);
                    else
                        [xy2p, xywf] = cpselect([surface_im_path '.png'],[wf_frame_path '.png'],xy2p, xywf,'Wait',true);
                    end
                    tform = fitgeotrans(xy2p,xywf,'affine');
                    movingRegistered = imwarp(twop_im,tform,'OutputView',imref2d(size(wf_im)));

                    comb_im = wf_im;
                    comb_im(movingRegistered>0) = movingRegistered(movingRegistered>0);
                    figure(fig_reg); 
                    subplot(1,2,1);
                    imagesc(wf_im);axis equal tight;
                    subplot(1,2,2);
                    imagesc(comb_im);axis equal tight;
                    title('Is new registration good? (y/n)');
                    reg_good = ask_yes_no_fig();
                end
                temp_data_out(n_save).moving_2p_im = surface_fname;
                temp_data_out(n_save).ref_wf_im = wf_frame;
                temp_data_out(n_save).tform = tform;
                temp_data_out(n_save).xy2p = xy2p;
                temp_data_out(n_save).xywf = xywf;
                n_save = n_save + 1;
            end
        end
    end
end

data_out_surface = [data_out_surface, temp_data_out];

%% plot all reg surf frames

for n_dset = 1:numel(wf_frames)
    wf_frame = data_all{n_dset}.wf_frame;
    wf_frame_path = [data_path '\' data_all{n_dset}.mouse_tag '\' wf_frame];
    wf_im = data_all{n_dset}.wf_frame_im;
    comb_im = wf_im;
    figure;
    subplot(1,2,1);
    imagesc(wf_im);axis equal tight;
    for n_tab = 1:size(data_all{n_dset}.mapping_files,1)
        surface_fname = data_all{n_dset}.mapping_files.mapping_reg_2p_surface{n_tab};
        if ~isempty(surface_fname)
            surface_im_path = [data_path '\' data_all{n_dset}.mouse_tag '\' surface_fname];
            twop_im = data_all{n_dset}.mapping_files.surface_im{n_tab};
            temp_data_old = data_out_surface(strcmpi({data_out_surface.moving_2p_im}, surface_fname));
            temp_data_old = temp_data_old(strcmpi({temp_data_old.ref_wf_im}, wf_frame));
            if isfield(temp_data_old, 'xy2p') && numel(temp_data_old)>0
                xy2p = temp_data_old.xy2p;
                xywf = temp_data_old.xywf;
            else
                xy2p = [];
                xywf = [];
            end
            if ~isempty(temp_data_old)
                tform = temp_data_old.tform;
                movingRegistered = imwarp(twop_im,tform,'OutputView',imref2d(size(wf_im)));
                comb_im(movingRegistered>0) = movingRegistered(movingRegistered>0);
            end
        end
    end
    subplot(1,2,2);
    imagesc(comb_im);axis equal tight;
end

%% register all deep fov images

fig_reg = figure;
n_save = 1;
temp_data_out = struct();
for n_dset = 1:numel(wf_frames)
    wf_frame = data_all{n_dset}.wf_frame;
    wf_frame_path = [data_path '\' data_all{n_dset}.mouse_tag '\' wf_frame];
    wf_im = data_all{n_dset}.wf_frame_im;

    for n_tab = 1:size(data_all{n_dset}.mapping_files,1)
        surface_fname = data_all{n_dset}.mapping_files.mapping_reg_2p_surface{n_tab};
        if ~isempty(surface_fname)
            surface_im_path = [data_path '\' data_all{n_dset}.mouse_tag '\' surface_fname];
            twop_im = data_all{n_dset}.mapping_files.surface_im{n_tab};
            temp_data_old = data_out_surface(strcmpi({data_out_surface.moving_2p_im}, surface_fname));
            temp_data_old = temp_data_old(strcmpi({temp_data_old.ref_wf_im}, wf_frame));
            if isfield(temp_data_old, 'xy2p') && numel(temp_data_old)>0
                xy2p = temp_data_old.xy2p;
                xywf = temp_data_old.xywf;
            else
                xy2p = [];
                xywf = [];
            end
            if ~isempty(temp_data_old)
                tform = temp_data_old.tform;
                movingRegistered = imwarp(twop_im,tform,'OutputView',imref2d(size(wf_im)));
                figure(fig_reg);
                comb_im = wf_im;
                comb_im(movingRegistered>0) = movingRegistered(movingRegistered>0);
                figure(fig_reg); 
                subplot(1,2,1);
                imagesc(wf_im);axis equal tight;
                subplot(1,2,2);
                imagesc(comb_im);axis equal tight;
                title('Is loaded registration good? (y/n)');
                do_reg = ~ask_yes_no_fig();
            else
                do_reg = 1;
            end
            if do_reg
                reg_good = 0;
                fprintf('Registering %s\n', surface_fname)
                while ~reg_good
                    if isempty(xy2p)
                        [xy2p, xywf] = cpselect([surface_im_path '.png'],[wf_frame_path '.png'],'Wait',true);
                    else
                        [xy2p, xywf] = cpselect([surface_im_path '.png'],[wf_frame_path '.png'],xy2p, xywf,'Wait',true);
                    end
                    tform = fitgeotrans(xy2p,xywf,'affine');
                    movingRegistered = imwarp(twop_im,tform,'OutputView',imref2d(size(wf_im)));

                    comb_im = wf_im;
                    comb_im(movingRegistered>0) = movingRegistered(movingRegistered>0);
                    figure(fig_reg); 
                    subplot(1,2,1);
                    imagesc(wf_im);axis equal tight;
                    subplot(1,2,2);
                    imagesc(comb_im);axis equal tight;
                    title('Is new registration good? (y/n)');
                    reg_good = ask_yes_no_fig();
                end
                temp_data_out(n_save).moving_2p_im = surface_fname;
                temp_data_out(n_save).ref_wf_im = wf_frame;
                temp_data_out(n_save).tform = tform;
                temp_data_out(n_save).xy2p = xy2p;
                temp_data_out(n_save).xywf = xywf;
                n_save = n_save + 1;
            end
        end
    end
end

%%

figure;
imshow(wf_im)
roi = images.roi.Point(gca,'Position',[40 65]);
% 
% f_2p = figure;
% imagesc(twop_im); hold on;
% axis equal tight;
% 
% f_wf = figure; 
% imagesc(wf_im); hold on;
% axis equal tight;
% 
% num_points = 3;
% xy2p = zeros(num_points,2);
% xywf = zeros(num_points,2);
% 
% for n_pt = 1:num_points
%     figure(f_2p);
%     title(['Select point ' num2str(n_pt)]);
%     [x1, y1] = ginputColor(1);
%     title('Other plot');
%     xy2p(n_pt,:) = round([x1 y1]);
%     plot(xy2p(n_pt,1),xy2p(n_pt,2), 'om');
%     text(xy2p(n_pt,1)+2,xy2p(n_pt,2),num2str(n_pt))
%     figure(f_wf);
%     title(['Select corresponding point ' num2str(n_pt)]);
%     [x1, y1] = ginputColor(1);
%     title('Other plot');
%     xywf(n_pt,:) = round([x1 y1]);
%     plot(xywf(n_pt,1),xywf(n_pt,2), 'om');
%     text(xywf(n_pt,1)+2,xywf(n_pt,2),num2str(n_pt))
% end
