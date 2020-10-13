function f_reg_point_remove_pt(app)

rem_point = app.UITablePointsSelection;
if ~isempty(app.UITablePointsSelection)
    rem_point = rem_point(1);

    [db_wf, db_reg, reg_num] = f_reg_get_current_wf_reg(app);

    tform1 = db_reg.regions_tforms(str2double(db_reg.current_tform));

    tform1.xy2p{1}(rem_point,:) = [];
    tform1.xywf{1}(rem_point,:) = [];
    if rank([tform1.xy2p{1}, ones(size(tform1.xy2p{1},1),1)])>=3 && rank([tform1.xywf{1}, ones(size(tform1.xy2p{1},1),1)])>=3
        tform1.tform = fitgeotrans(tform1.xy2p{1},tform1.xywf{1},'affine');
    else
        tform1.tform = [];
    end
    app.data_all(db_wf.mouse_num).regions(reg_num).regions_tforms(str2double(db_reg.current_tform)) = tform1;

    f_reg_points_remove(app);
    f_reg_points_add(app);
    f_reg_update_plot_wf(app);
else
    messege1 = sprintf('Select a point first');
    uialert(app.UIFigure, messege1 ,'Warning','Icon','warning');
end