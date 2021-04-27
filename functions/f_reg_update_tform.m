function f_reg_update_tform(app)

[db_wf, db_reg, reg_num] = f_reg_get_current_wf_reg(app);
n_tform = str2double(db_reg.current_tform);

num_pts = numel(app.pt2p);
pt2p_new = zeros(num_pts,2);
ptwf_new = zeros(num_pts,2);
if app.PlotinmicronsCheckBox.Value
    [d1, d2] = size(app.fov_axes.CData);
    fov_fac_x = db_reg.fov_pix_val/d2;
    fov_fac_y = db_reg.fov_pix_val/d1;
    wf_fac = db_wf.wf_pix_val;
else
    fov_fac_x = 1;
    fov_fac_y = 1;
    wf_fac = 1;
end
for n_pt = 1:num_pts
    pt2p_new(n_pt,:) = app.pt2p{n_pt}.Position./[fov_fac_x fov_fac_y];
    ptwf_new(n_pt,:) = app.ptwf{n_pt}.Position/wf_fac;
end

app.data_all(db_wf.mouse_num).regions(reg_num).regions_tforms(n_tform).xy2p = {pt2p_new};
app.data_all(db_wf.mouse_num).regions(reg_num).regions_tforms(n_tform).xywf = {ptwf_new};
if rank([pt2p_new, ones(size(pt2p_new,1),1)])>=3 && rank([ptwf_new, ones(size(ptwf_new,1),1)])>=3
    tform1 = fitgeotrans(pt2p_new,ptwf_new,'affine');
else
    tform1 = [];
end
app.data_all(db_wf.mouse_num).regions(reg_num).regions_tforms(n_tform).tform = tform1;

f_reg_update_plot_wf(app);

end