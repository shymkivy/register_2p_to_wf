function f_reg_load_db_images(app)

filepath = app.imagesDBpathEditField.Value;
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
        f_reg_update_dropdown(app);
        f_reg_update_plot_wf(app);
        f_reg_update_plot_fov(app);
        f_reg_align_point_remove(app);
        f_reg_align_update_table(app);
        f_reg_align_update_plot_wf(app);
        f_reg_align_point_add(app);
    else
        f_reg_yell(app, 'Your database a table of fov_data or wf_data');
    end
end 

end