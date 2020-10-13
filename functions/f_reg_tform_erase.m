function f_reg_tform_erase(app)

[db_wf, db_reg, reg_num] = f_reg_get_current_wf_reg(app);

curr_tform = str2double(db_reg.current_tform);

db_reg.regions_tforms(curr_tform) = [];

for n_tf = 1:numel(db_reg.regions_tforms)
    db_reg.regions_tforms(n_tf).tform_num = num2str(n_tf);
end

app.data_all(db_wf.mouse_num).regions(reg_num).regions_tforms = db_reg.regions_tforms;
app.data_all(db_wf.mouse_num).regions(reg_num).current_tform = num2str(min([curr_tform, numel(db_reg.regions_tforms)]));

f_reg_update_dropdown(app);
f_reg_update_plot_wf(app);
end