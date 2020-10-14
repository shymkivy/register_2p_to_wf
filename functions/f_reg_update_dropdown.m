function f_reg_update_dropdown(app)

app.WFimageDropDown.Items = [app.data_all.wf_fname];

[db_wf, ~] = f_reg_get_current_wf_reg(app);
if ~isempty(db_wf)
    if numel(db_wf.regions)
        app.RegionDropDown.Items = unique([db_wf.regions.region_name]);
        
        [~, db_reg] = f_reg_get_current_wf_reg(app);
        if ~isempty(db_reg)
            app.FOVimageDropDown.Items = db_reg.fov_fname;
            tform_to_select = db_reg.current_tform;

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