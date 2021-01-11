function f_reg_map_update_panel(app)
    
app.WFimageDropDownMapping.Items = [app.data_all.wf_fname];

n_mouse = strcmpi([app.data_all.wf_fname], app.WFimageDropDownMapping.Value);
db_wf = app.data_all(n_mouse);
data_map1 = struct;
for ii = 1:numel(db_wf.wf_mapping_title)
    data_map1(ii).Stim_type = db_wf.wf_mapping_title{ii};
end

if isfield(db_wf, 'wf_mapping_regions')
    app.mapping_regions = db_wf.wf_mapping_regions.Properties.VariableNames;
    app.UITableMapping.Data = ([struct2table(data_map1), db_wf.wf_mapping_regions]);
    app.UITableMapping.ColumnName = [{'Stim type'} db_wf.wf_mapping_regions.Properties.VariableNames];
else
    app.UITableMapping.Data = struct2table(data_map1);
end

end