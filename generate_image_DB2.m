clear;
close all;

addpath('C:\Users\rylab_dataPC\Desktop\Yuriy\register_2p_to_wf');
addpath('C:\Users\rylab_dataPC\Desktop\Yuriy\register_2p_to_wf\functions');

load_data_path = 'F:\data\Auditory\mapping_2p_reg_data';
save_data_path = 'C:\Users\rylab_dataPC\Desktop\Yuriy\register_2p_to_wf';


mouse_tag_col_name = 'mouse_tag';
area_tag_col_name = 'area';
wf_fnames_col_name = 'mapping_wf_frame';
twop_fnames_col_name = {'mapping_reg_2p_surface', 'mapping_reg_2p_fov'};
wf_mapping_freq = 'mapping_freq';

remove_pat_title = {'\fontsize{10}diff '};

%%
AC_data = readtable('C:\Users\rylab_dataPC\Desktop\Yuriy\AC_2p_analysis\AC_data_list.xlsx');
AC_data = AC_data(~isnan(AC_data.im_use_dset),:);


%%
mouse_tags = unique(AC_data.(mouse_tag_col_name));
num_mice = numel(mouse_tags);
%% sort mouse tags
date_mice = zeros(num_mice,3);
for n_ms = 1:num_mice
    indx = strfind(mouse_tags{n_ms}, '_');
    date_mice(n_ms,1) = str2double(mouse_tags{n_ms}(indx(2)+1:indx(2)+2));
    date_mice(n_ms,2) = str2double(mouse_tags{n_ms}(1:indx(1)-1));
    date_mice(n_ms,3) = str2double(mouse_tags{n_ms}(indx(1)+1:indx(2)-1));
end
[~, sind1] = sort(date_mice(:,3), 'ascend');
[~, sind2] = sort(date_mice(sind1,2), 'ascend');
[~, sind3] = sort(date_mice(sind1(sind2),1), 'ascend');

mouse_tags = mouse_tags(sind1(sind2(sind3)));

%%
data_all = struct();
for n_ms = 1:num_mice
    data_all(n_ms).mouse_num = n_ms;
    AC_data2 = AC_data(strcmpi(AC_data.mouse_tag, mouse_tags{n_ms}),:);
    wf_fname = unique(AC_data2.(wf_fnames_col_name));
    wf_fname = wf_fname(~strcmpi(wf_fname, ''));
    data_all(n_ms).wf_fname = wf_fname(1);
    % make regions
    regions1 = unique(AC_data2.(area_tag_col_name));
    data_all(n_ms).wf_im = {f_reg_gen_db_load_im([load_data_path, '\', mouse_tags{n_ms}, '\', wf_fname{1}])};
    empty_reg = false(numel(regions1),1);
    for n_reg = 1:numel(regions1)
        data_all(n_ms).regions(n_reg).region_name = regions1(n_reg);
        AC_data3 = AC_data2(strcmpi(AC_data2.(area_tag_col_name), regions1{n_reg}),:);
        data_all(n_ms).regions(n_reg).fov_fname = cell(numel(twop_fnames_col_name),1);
        data_all(n_ms).regions(n_reg).fov_im = cell(numel(twop_fnames_col_name),1);
        empty_fov_fname = true(numel(twop_fnames_col_name),1);
        for n_fov = 1:numel(twop_fnames_col_name)
            fov1 = unique(AC_data3.(twop_fnames_col_name{n_fov}));
            fov1 = fov1(~strcmpi(fov1, ''));
            if ~isempty(fov1)
                data_all(n_ms).regions(n_reg).fov_fname{n_fov} = fov1{1};
                data_all(n_ms).regions(n_reg).fov_im{n_fov} = f_reg_gen_db_load_im([load_data_path, '\', mouse_tags{n_ms}, '\', fov1{1}]);
                empty_fov_fname(n_fov) = 0;
            end
        end
        data_all(n_ms).regions(n_reg).fov_fname(empty_fov_fname) = [];
        data_all(n_ms).regions(n_reg).fov_im(empty_fov_fname) = [];
        empty_reg(n_reg) = prod(empty_fov_fname);
        data_all(n_ms).regions(n_reg).regions_tforms = [];
        data_all(n_ms).regions(n_reg).current_tform = '0';
    end
    data_all(n_ms).regions(empty_reg) = [];
    wf_mapping_fname = unique(AC_data2.(wf_mapping_freq));
    wf_mapping_fname = wf_mapping_fname(~strcmpi(wf_mapping_fname, ''));
    data_all(n_ms).wf_mapping_fname = wf_mapping_fname(1);
    wf_mapping_imlist = f_reg_gen_db_load_spatial_wf([load_data_path, '\', mouse_tags{n_ms}, '\', wf_mapping_fname{1}]);
    data_all(n_ms).wf_mapping_im = flipud(wf_mapping_imlist(:,1));
    num_im = numel(wf_mapping_imlist(:,2));
    
    titles1 = cell(num_im,1);
    for n_im = 1:num_im
        temp_tit = wf_mapping_imlist{n_im,2};
        for n_pat = 1:numel(remove_pat_title)
            n_st = strfind(temp_tit, remove_pat_title{n_pat});
            temp_tit(n_st:numel(remove_pat_title{n_pat})) = [];
        end
        titles1{n_im} = temp_tit;
    end
    
    data_all(n_ms).wf_mapping_title = flipud(titles1);
    
end



%% save 
save([save_data_path '\reg_images_db.mat'], 'data_all');

