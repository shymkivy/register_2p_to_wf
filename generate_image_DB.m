% need to add spatial freqs here
%%
clear;
close all;

pwd2 = fileparts(which('register_2p_to_wf.mlapp'));

addpath(pwd2);
addpath([pwd2 '\functions']);

load_data_path = 'F:\data\Auditory\mapping_2p_reg_data';
save_data_path = pwd2;

mouse_tag_col_name = 'mouse_tag';
area_tag_col_name = 'area';
wf_fnames_col_name = 'mapping_wf_frame';
twop_fnames_col_name = {'mapping_reg_2p_surface', 'mapping_reg_2p_fov'};

%%
AC_data = readtable([pwd2 '\..\AC_2p_analysis\AC_data_list.xlsx']);
AC_data = AC_data(~isnan(AC_data.im_use_dset),:);


%% extract all data
data_table2 = cell(numel(twop_fnames_col_name),1);
for n_col = 1:numel(twop_fnames_col_name)
    temp_data_table = unique(AC_data(:,{mouse_tag_col_name, wf_fnames_col_name, area_tag_col_name, twop_fnames_col_name{n_col}}));
    data_table2{n_col} = temp_data_table(~strcmpi(temp_data_table.(twop_fnames_col_name{n_col}), ''),:);
    data_table2{n_col}.Properties.VariableNames{1} = 'mouse_tag';
    data_table2{n_col}.Properties.VariableNames{2} = 'wf_fname';
    data_table2{n_col}.Properties.VariableNames{3} = 'area';
    data_table2{n_col}.Properties.VariableNames{4} = 'fov_fname';
end
data_table2 = cat(1,data_table2{:});

%%
wf_fnames = unique(data_table2(:,{'mouse_tag', 'wf_fname'}));


%% load
fov_data = f_reg_load_images(data_table2, load_data_path, 'fov_fname', 'fov_im', 'mouse_tag');
wf_data = f_reg_load_images(wf_fnames, load_data_path, 'wf_fname', 'wf_im', 'mouse_tag');

% here
%wf_mapping_imlist = f_reg_gen_db_load_spatial_wf([load_data_path, '\', mouse_tags{n_ms}, '\', wf_mapping_fname{1}]);

%% save 
save([save_data_path '\reg_images_wf_fov.mat'], 'wf_data', 'fov_data');

