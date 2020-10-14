function f_reg_map_update_panel(app)
    
app.WFimageDropDownMapping.Items = [app.data_all.wf_fname];

n_mouse = strcmpi([app.data_all.wf_fname], app.WFimageDropDownMapping.Value);
db_wf = app.data_all(n_mouse);
data_map1 = struct;
for ii = 1:numel(db_wf.wf_mapping_title)
    data_map1(ii).Stim_type = db_wf.wf_mapping_title{ii};
end

if isfield(db_wf, 'wf_mapping_regions')
    app.UITableMapping.Data = ([struct2table(data_map1), db_wf.wf_mapping_regions]);
    app.UITableMapping.ColumnName = [{'Stim type'} app.mapping_regions];
else
    app.UITableMapping.Data = struct2table(data_map1);
end

end