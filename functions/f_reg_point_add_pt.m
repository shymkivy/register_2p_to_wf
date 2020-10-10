function f_reg_point_add_pt(app)

[db_wf, db_reg, reg_num] = f_reg_get_current_wf_reg(app);

tform1 = db_reg.regions_tforms(str2double(db_reg.current_tform));

tform1.xy2p{1} = [tform1.xy2p{1}; mean(tform1.xy2p{1})];
tform1.xywf{1} = [tform1.xywf{1}; mean(tform1.xywf{1})];

tform1.tform = fitgeotrans(tform1.xy2p{1},tform1.xywf{1},'affine');

app.data_all(db_wf.mouse_num).regions(reg_num).regions_tforms(str2double(db_reg.current_tform)) = tform1;

f_reg_points_remove(app);
f_reg_points_add(app);
f_reg_update_plot_wf(app);

end