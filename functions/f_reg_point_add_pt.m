function f_reg_point_add_pt(app)

[~, db_reg, ~] = f_reg_get_current_wf_reg(app);

if ~strcmpi(db_reg.current_tform, '0')
    f_reg_update_tform(app);
else
    f_reg_create_tfrom(app);
end

[db_wf, db_reg, reg_num] = f_reg_get_current_wf_reg(app);

tform1 = db_reg.regions_tforms(str2double(db_reg.current_tform));

if ~isempty(tform1.xy2p)
    if numel(tform1.xy2p{1})>2
        tform1.xy2p{1} = [tform1.xy2p{1}; mean(tform1.xy2p{1})];
        tform1.xywf{1} = [tform1.xywf{1}; mean(tform1.xywf{1})];
    else
        tform1.xy2p{1} = [tform1.xy2p{1}; size(app.fov_axes.CData)/2];
        tform1.xywf{1} = [tform1.xywf{1}; size(app.wf_axes.CData)/2];
    end
else
    tform1.xy2p{1} = size(app.fov_axes.CData)/2;
    tform1.xywf{1} = size(app.wf_axes.CData)/2;
end



if rank([tform1.xy2p{1}, ones(size(tform1.xy2p{1},1),1)])>=3 && rank([tform1.xywf{1}, ones(size(tform1.xy2p{1},1),1)])>=3
    tform1.tform = fitgeotrans(tform1.xy2p{1},tform1.xywf{1},'affine');
end

app.data_all(db_wf.mouse_num).regions(reg_num).regions_tforms(str2double(db_reg.current_tform)) = tform1;

f_reg_points_remove(app);
f_reg_points_add(app);
f_reg_update_plot_wf(app);

end