function f_reg_update_tform(app)

[db_wf, db_reg, reg_num] = f_reg_get_current_wf_reg(app);
n_tform = str2double(db_reg.current_tform);

num_pts = numel(app.pt2p);
pt2p_new = zeros(num_pts,2);
ptwf_new = zeros(num_pts,2);
for n_pt = 1:num_pts
    pt2p_new(n_pt,:) = app.pt2p{n_pt}.Position;
    ptwf_new(n_pt,:) = app.ptwf{n_pt}.Position;
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