function f_reg_load_data(app)

%% first load all AC data descriptions in excel
if ~isempty(app.xlsxpathEditField.Value)
   if exist(app.xlsxpathEditField.Value, 'file')
       warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames');
       app.data_xlsx = readtable(app.xlsxpathEditField.Value);
   end
end

%% now load database with images and tforms
filepath = app.DBpathEditField.Value;
[~,~,ext] = fileparts(filepath);


if strcmpi(ext, '.mat')
    data = load(filepath);
    if isfield(data, 'wf_data') || isfield(data, 'fov_data')
        if isfield(data, 'wf_data')
            f_reg_add_wf(app, data.wf_data);
        end
        if isfield(data, 'fov_data')
            f_reg_add_fov(app, data.fov_data);
        end
    elseif isfield(data, 'data_all')
        app.data_all = data.data_all;
        if ~isfield(app.data_all, 'wf_mapping_regions')
            temp_reg = array2table(ones(numel(app.data_all(1).wf_mapping_title), numel(app.ops.mapping_regions)));
            temp_reg.Properties.VariableNames = app.ops.mapping_regions;
            for n_exp = 1:numel(app.data_all)
                app.data_all(n_exp).wf_mapping_regions = temp_reg;
            end
        end
        if ~isfield(app.data_all, 'wf_mapping_regions_coords')
            temp_cell = cell(numel(app.data_all(1).wf_mapping_title), numel(app.ops.mapping_regions));
            for n_exp = 1:numel(app.data_all)
                app.data_all(n_exp).wf_mapping_regions_coords = temp_cell;
            end
        end
        
        idx_var = strcmpi(app.data_xlsx.Properties.VariableNames, 'cam_um_pix');
        if sum(idx_var)
            for n_exp = 1:numel(app.data_all)
                idx_dset = strcmpi(app.data_xlsx.mapping_wf_frame, app.data_all(n_exp).wf_fname);
                if sum(idx_dset)
                    cam_pix_all = app.data_xlsx(idx_dset,idx_var).Variables;
                    app.data_all(n_exp).wf_pix_val = median(cam_pix_all);
                end
            end
        end

        idx_var_fov = strcmpi(app.data_xlsx.Properties.VariableNames, 'FOV_max');
        idx_var_zoom = strcmpi(app.data_xlsx.Properties.VariableNames, 'im_zoom');
        if sum(idx_var_fov) && sum(idx_var_zoom)
            for n_exp = 1:numel(app.data_all)
                for n_reg = 1:numel(app.data_all(n_exp).regions)
                    idx_dset = strcmpi(app.data_xlsx.experiment, app.data_all(n_exp).regions(n_reg).fov_fname(1:end-4));
                    cam_fov = app.data_xlsx(idx_dset,idx_var_fov).Variables;
                    cam_zoom = app.data_xlsx(idx_dset,idx_var_zoom).Variables;
                    if isnan(cam_zoom)
                       fprintf('zoom val missing for %s\n',app.data_xlsx(idx_dset,:).experiment{1});
                    end
                    if isnan(cam_fov)
                       fprintf('cam fov size val missing for%s\n',app.data_xlsx(idx_dset,:).experiment{1});
                    end
                    if and(~isnan(cam_zoom),~isnan(cam_fov))
                        app.data_all(n_exp).regions(n_reg).fov_pix_val = cam_fov/cam_zoom;
                    end
                end
            end
        end
        
        f_reg_update_dropdown(app);
        f_reg_update_plot_wf(app);
        f_reg_update_plot_fov(app);
        f_reg_align_point_remove(app);
        f_reg_align_update_table(app);
        f_reg_align_update_plot_wf(app);
        f_reg_align_point_add(app);
        f_reg_initialize_reg_mouse_tab(app);
    else
        f_reg_yell(app, 'Your database a table of fov_data or wf_data');
    end
end

% extract pixel sizes from xlsx file 



end