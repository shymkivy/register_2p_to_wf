function ops = GUI_params()

ops.gui_dir = fileparts(which('register_2p_to_wf.mlapp'));
addpath(ops.gui_dir);
addpath([ops.gui_dir '\' 'functions']);

ops.database_path = 'C:\Users\ys2605\Desktop\stuff\AC_data\wf_registration_data\reg_save_6_10_21.mat';
ops.xlsx_path = 'C:\Users\ys2605\Desktop\stuff\AC_2p_analysis\AC_data_list.xlsx';

ops.save_path = 'C:\Users\ys2605\Desktop\stuff\AC_data\wf_registration_data\reg_save_6_10_21.mat';

ops.wf_data_columns = {'wf_fname', 'wf_im'};
ops.fov_data_columns = {'wf_fname', 'area', 'fov_fname', 'fov_im'};

ops.mapping_regions = {'A1', 'A2', 'AAF', 'UF'};

end