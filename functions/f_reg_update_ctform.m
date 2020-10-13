function f_reg_update_ctform(app)

[db_wf, ~, reg_num] = f_reg_get_current_wf_reg(app);
app.data_all(db_wf.mouse_num).regions(reg_num).current_tform = num2str(app.TformDropDown.Value);

end