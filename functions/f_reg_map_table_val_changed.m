function f_reg_map_table_val_changed(app, event)

n_mouse = strcmpi([app.data_all.wf_fname], app.WFimageDropDownMapping.Value);

app.data_all(n_mouse).wf_mapping_regions{event.Indices(1), event.Indices(2)-1} = event.NewData;

end