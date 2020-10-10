function f_reg_tform_clone(app)

[db_wf, db_reg, reg_num] = f_reg_get_current_wf_reg(app);

current_tform = str2double(db_reg.current_tform);
nume_tform_n = numel(db_reg.regions_tforms)+1;

reg_tf2 = [db_reg.regions_tforms; db_reg(current_tform).regions_tforms];

reg_tf2(end).tform_num = num2str(nume_tform_n);

app.data_all(db_wf.mouse_num).regions(reg_num).regions_tforms = reg_tf2;
app.data_all(db_wf.mouse_num).regions(reg_num).current_tform = num2str(nume_tform_n);

f_reg_update_dropdown(app);
end