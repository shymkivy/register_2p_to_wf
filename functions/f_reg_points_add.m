function f_reg_points_add(app)

if app.PointsonButton.Value
    [~, db_reg] = f_reg_get_current_wf_reg(app);
    if ~isempty(db_reg) && ~isempty(db_reg.regions_tforms)
        f_reg_points_remove(app);

        tform1 = db_reg.regions_tforms(str2double(db_reg.current_tform));

        xy2p = tform1.xy2p{1};
        num_pts = size(xy2p,1);
        pt2p = cell(num_pts,1);
        for n_pt = 1:num_pts
            pt2p{n_pt} = images.roi.Point(app.FOV_axes, 'Color', 'r', 'Position',[xy2p(n_pt,1) xy2p(n_pt,2)]);
            pt2p{n_pt}.Label = num2str(n_pt);
            notify(pt2p{n_pt}, 'ROIMoved');
        end
        app.pt2p = pt2p;

        xywf = tform1.xywf{1};
        ptwf = cell(num_pts,1);
        for n_pt = 1:num_pts
            %x = impoint(app.WF_axes, [xywf(n_pt,1) xywf(n_pt,2)]);
            ptwf{n_pt} = images.roi.Point(app.WF_axes, 'Color', 'r','Position',[xywf(n_pt,1) xywf(n_pt,2)]);
            ptwf{n_pt}.Label = num2str(n_pt);
            notify(ptwf{n_pt}, 'ROIMoved');
        end
        app.ptwf = ptwf;
        
        % add to table
        points_tab.Points = (1:num_pts)';
        app.UITablePoints.Data = struct2table(points_tab);
    end
end

end