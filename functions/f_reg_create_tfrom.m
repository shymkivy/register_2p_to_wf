function f_reg_create_tfrom(app)

[db_wf, db_reg, reg_num] = f_reg_get_current_wf_reg(app);

if ~isempty(db_reg.regions_tforms)
    num_tforms = numel(db_reg.regions_tforms);
else
    num_tforms = 0;
end

tforms_blank(1).tform_num = num2str(num_tforms+1);
tforms_blank(1).tform = [];
tforms_blank(1).xy2p = {};
tforms_blank(1).xywf = {};

if isempty(db_reg.regions_tforms)
    tforms1 = tforms_blank;
else
    tforms1 = [db_reg.regions_tforms; tforms_blank];
end

app.data_all(db_wf.mouse_num).regions(reg_num).regions_tforms = tforms1;
app.data_all(db_wf.mouse_num).regions(reg_num).current_tform = num2str(tforms_blank(1).tform_num);

f_reg_update_dropdown(app);
f_reg_update_plot_wf(app);
end