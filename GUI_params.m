function ops = GUI_params()

ops.gui_dir = fileparts(which('register_2p_to_wf.mlapp'));
addpath(ops.gui_dir);
addpath([ops.gui_dir '\' 'functions']);

ops.save_fname = 'reg_save.mat';
ops.database_fname = 'reg_save.mat';
ops.tform_fname = 'reg_tform_db.mat';


ops.wf_data_columns = {'wf_fname', 'wf_im'};
ops.fov_data_columns = {'wf_fname', 'region', 'fov_fname', 'fov_im'};


ops.mapping_regions = {'A1', 'A2', 'AAF', 'UF'};

end