function ops = GUI_params()

ops.gui_dir = 'C:\Users\rylab_dataPC\Desktop\Yuriy\register_2p_to_wf';
addpath(ops.gui_dir);
addpath([ops.gui_dir '\' 'functions']);

ops.database_path = 'C:\Users\rylab_dataPC\Desktop\Yuriy\register_2p_to_wf\reg_tform_db.mat';

ops.wf_data_columns = {'wf_fname', 'wf_im'};
ops.fov_data_columns = {'wf_fname', 'region', 'fov_fname', 'fov_im'};


end