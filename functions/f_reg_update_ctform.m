function f_reg_update_ctform(app)
[~, db_reg] = f_reg_get_current_wf_reg(app);

db_reg.current_tform = num2str(app.TformDropDown.Value);

end