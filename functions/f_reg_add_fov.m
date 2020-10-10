function f_reg_add_fov(app, fov_data)
%% check if required colums are present
fov_cols = app.ops.fov_data_columns;
for n_col = 1:numel(fov_cols)
    temp_cols = strcmpi(fov_cols{n_col}, fields(fov_data));
    if ~sum(temp_cols)
        fov_cols(temp_cols)
        messege1 = sprintf('Your database needs a "%s" column in fov_data table', fov_cols{n_col});
        uialert(app.UIFigure, messege1 ,'Warning','Icon','warning');
    end
end

%%
num_load_data = numel(fov_data.(fov_cols{1}));

%%
changes = 0;
for n_dat = 1:num_load_data
    temp_data = fov_data(n_dat,:);
    
    % check if wf exists
    current_wf = strcmpi([app.data_all.wf_fname], temp_data.wf_fname);
    
    if sum(current_wf)
        r_db = app.data_all(current_wf).regions;

        reg1(1).region_name = temp_data.region;
        reg1(1).fov_fname = temp_data.fov_fname;
        reg1(1).fov_im = temp_data.fov_im;
        reg1(1).regions_tforms = {};
        reg1(1).current_tform = '0';
        
        if isempty(r_db)    % if no regions present
            r_db = reg1;
            changes = changes + 1;
        elseif ~sum(strcmpi([r_db.region_name], temp_data.region)) % if this region not present
            r_db = [r_db; reg1];
            changes = changes + 1;
        else    % compare fovs
            current_region = strcmpi([r_db.region_name], temp_data.region);
            
            fov_exists = sum(strcmpi([r_db(current_region).fov_fname], temp_data.fov_fname));
            if ~fov_exists
                r_db(current_region).fov_fname = [r_db(current_region).fov_fname; temp_data.fov_fname];
                r_db(current_region).fov_im = [r_db(current_region).fov_im; temp_data.fov_im];
                changes = changes + 1;
            end
        end
        app.data_all(current_wf).regions = r_db;
    end
end
if changes
    f_reg_update_dropdown(app);
    f_reg_update_plot_wf(app);
    f_reg_update_plot_fov(app);
end

end