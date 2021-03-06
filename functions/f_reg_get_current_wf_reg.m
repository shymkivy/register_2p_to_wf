function [db_wf, db_reg, reg_num] = f_reg_get_current_wf_reg(app)
db_all = app.data_all;

if ~isempty(db_all)
    current_wf = strcmpi(app.WFimageDropDown.Value, [db_all.wf_fname]);
    db_wf = db_all(current_wf);
    
    if ~isempty(db_wf.regions) && ~isempty(app.RegionDropDown.Value)
        current_reg = strcmpi(app.RegionDropDown.Value, [db_wf.regions.region_name]);
        reg_num = find(current_reg);
        db_reg = db_wf.regions(current_reg);
    else
        db_reg = [];
    end
else
    db_wf = [];
end

end