function f_reg_points_add(app)

if app.PointsonButton.Value
    [db_wf, db_reg] = f_reg_get_current_wf_reg(app);
    if ~isempty(db_reg) && ~isempty(db_reg.regions_tforms)
        f_reg_points_remove(app);

        tform1 = db_reg.regions_tforms(str2double(db_reg.current_tform));
        
        if ~isempty(tform1.xy2p)
            xy2p = tform1.xy2p{1};
            num_pts = size(xy2p,1);
            pt2p = cell(num_pts,1);
            [d1,d2] = size(app.fov_axes.CData);
            if app.PlotinmicronsCheckBox.Value
                fov_fac_x = db_reg.fov_pix_val/d2;
                fov_fac_y = db_reg.fov_pix_val/d1;
            else
                fov_fac_x = 1;
                fov_fac_y = 1;
            end
            for n_pt = 1:num_pts
                pt2p{n_pt} = images.roi.Point(app.FOV_axes, 'Color', 'r', 'Position',[xy2p(n_pt,1)*fov_fac_x xy2p(n_pt,2)*fov_fac_y]);
                pt2p{n_pt}.Label = num2str(n_pt);
                %notify(pt2p{n_pt}, 'ROIMoved');
            end
            app.pt2p = pt2p;
        
            xywf = tform1.xywf{1};
            ptwf = cell(num_pts,1);
            if app.PlotinmicronsCheckBox.Value
                wf_fac = db_wf.wf_pix_val;
            else
                wf_fac = 1;
            end
            for n_pt = 1:num_pts
                %x = impoint(app.WF_axes, [xywf(n_pt,1) xywf(n_pt,2)]);
                ptwf{n_pt} = images.roi.Point(app.WF_axes, 'Color', 'r','Position',[xywf(n_pt,1) xywf(n_pt,2)]*wf_fac);
                ptwf{n_pt}.Label = num2str(n_pt);
                %notify(ptwf{n_pt}, 'ROIMoved');
            end
            app.ptwf = ptwf;
            
            % add to table
            points_tab.Points = (1:num_pts)';
            app.UITablePoints.Data = struct2table(points_tab);
        end
    end
end

end