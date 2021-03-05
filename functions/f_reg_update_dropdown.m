function f_reg_update_dropdown(app)

app.WFimageDropDown.Items = [app.data_all.wf_fname];

if isempty(strfind(app.FOVimageDropDown.Value, 'surf'))
    app.current_fov_is_surface = 0;
else
    app.current_fov_is_surface = 1;
end

[db_wf, ~] = f_reg_get_current_wf_reg(app);
if ~isempty(db_wf)
    if numel(db_wf.regions)
        app.RegionDropDown.Items = unique([db_wf.regions.region_name]);
        
        [~, db_reg] = f_reg_get_current_wf_reg(app);
        if ~isempty(db_reg)
            
            dropdown_list = {db_reg.fov_surface_fname; db_reg.fov_fname};
            
            empty1 = cellfun(@isempty,dropdown_list);
            dropdown_list(empty1) = [];

            app.FOVimageDropDown.Items = dropdown_list;
            tform_to_select = db_reg.current_tform;
            
            if numel(dropdown_list) > 1
                if ~app.current_fov_is_surface
                    app.FOVimageDropDown.Value = app.FOVimageDropDown.Items{2};
                end
            end

            if ~strcmpi(tform_to_select, '0')
                app.TformDropDown.Items = {db_reg.regions_tforms.tform_num};
            else
                app.TformDropDown.Items = {tform_to_select};
            end
            app.TformDropDown.Value = tform_to_select;
        end
    end
end

f_reg_points_remove(app);
f_reg_points_add(app);

end