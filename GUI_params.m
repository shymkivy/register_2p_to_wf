function ops = GUI_params()

ops.gui_dir = fileparts(which('register_2p_to_wf.mlapp'));
addpath(ops.gui_dir);
addpath([ops.gui_dir '\' 'functions']);

ops.database_path = 'F:\AC_data\dset_viewer_save\reg_save_11_19_22.mat';
ops.xlsx_path = 'C:\Users\ys2605\Desktop\stuff\AC_2p_analysis\AC_data_list_all.xlsx';

ops.save_path = 'F:\AC_data\dset_viewer_save\reg_save_11_19_22.mat';

ops.wf_data_columns = {'wf_fname', 'wf_im'};
ops.fov_data_columns = {'wf_fname', 'area', 'fov_fname', 'fov_im'};

ops.mapping_regions = {'A1', 'A2', 'AAF', 'UF'};

end